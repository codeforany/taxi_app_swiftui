//
//  LoginViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 26/12/23.
//

import SwiftUI
import CountryPicker
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    static var shared: LoginViewModel = LoginViewModel()
    
    @Published var txtMobile: String = ""
    @Published var txtMobileCode: String = ""
    @Published var country: Country = Country(phoneCode: "91", isoCode: "IN")
    @Published var showOTP = false
    
    @Published var txtCode: String = ""
    
    @Published var vID: String = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    var isDriverLoginFlow = true
    
    func submitMobileNumber(cObj: Country, isDriver: Bool = true ) {
        if(txtMobile.count < 10) {
            errorMessage = "Please enter valide mobile number"
            showError = true
            return
        }
        
        txtMobileCode = "+\( cObj.phoneCode)"
        country = cObj
        showOTP = true
        isDriverLoginFlow = isDriver
        
        sendSMS()
    
    }
    
    
    func sendSMS(){
        PhoneAuthProvider.provider().verifyPhoneNumber("\(  txtMobileCode)\(txtMobile)", uiDelegate: nil) {
            verificationID, error in
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showError = true
                return
            }else{
                self.vID = verificationID ?? ""
            }
        }
    }
    
    func verifyCode(){
        
        if(txtCode.count != 6) {
            self.errorMessage = "Please enter valide code"
            self.showError = true
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: vID, verificationCode: txtCode)
        
        Auth.auth().signIn(with: credential) {
            authResult, error in
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showError  = true
            }else{
                self.loginApi(parameter: ["user_type": self.isDriverLoginFlow ? "2" : "1", "mobile_code": self.txtMobileCode, "mobile": self.txtMobile, "os_type": "i", "push_token":"", "socket_id": ""  ])
            }
        }
        
    }
    
    //MARK: ServiceCall
    
    func loginApi(parameter: NSDictionary) {
        
        ServiceCall.post(parameter: parameter, path: Globs.svLogin) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    ServiceCall.userPayload = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    ServiceCall.userType = ServiceCall.userPayload.value(forKey: KKey.userType) as? Int ?? 1
                    
                    Utils.UDSET(data: ServiceCall.userPayload, key: Globs.userPayload)
                    Utils.UDSET(data: true, key: Globs.userLogin)
                    MainViewModel.shard.reloadData()
                    
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
            
        
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }
    }
    
    func userProfileImageUpload(image: UIImage) {
        
        ServiceCall.multipart(parameter: [:], path: Globs.svProfileImage, imageDic: ["image": image], isTokenApi: true ) { responseObj in
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    ServiceCall.userPayload = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    ServiceCall.userType = ServiceCall.userPayload.value(forKey: KKey.userType) as? Int ?? 1
                    
                    Utils.UDSET(data: ServiceCall.userPayload, key: Globs.userPayload)
                    Utils.UDSET(data: true, key: Globs.userLogin)
                    
                    MainViewModel.shard.reloadData()
                    
                    self.errorMessage = "Profile Image uploading Successfully "
                    self.showError  = true

                    
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError  = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ??  MSG.fail
            self.showError  = true
        }

        
        
    }
    
}
