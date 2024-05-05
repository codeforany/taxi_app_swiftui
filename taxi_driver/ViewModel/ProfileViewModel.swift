//
//  ProfileViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 01/01/24.
//

import SwiftUI
import CountryPicker

class ProfileViewModel: ObservableObject {
    static var shared = ProfileViewModel()
    
    @Published var txtName = ""
    @Published var txtEmail = ""
    @Published var txtMobile = ""
    
    
    @Published var txtBankName = ""
    @Published var txtAccountHolderName = ""
    @Published var txtAccountNumber = ""
    @Published var txtSwiftCode = ""
    
    
    @Published var countryObj: Country? =  Country(phoneCode: "91", isoCode: "IN")
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var zoneArr: NSArray = []
    @Published var serviceArr: [ServiceModel] = []
    
    @Published var selectZone: NSDictionary?
    @Published var isMale: Bool = false
    
    
    @Published var txtCurrentPassword = ""
    @Published var txtNewPassword = ""
    @Published var txtConfirmPassword = ""
    
    @Published var showCurrentPassword = false
    @Published var showNewPassword = false
    @Published var showConfirmPassword = false
    
    func loadData() {
        
        txtName = ServiceCall.userPayload.value(forKey: "name") as? String ?? ""
        txtEmail = ServiceCall.userPayload.value(forKey: "email") as? String ?? ""
        txtMobile = ServiceCall.userPayload.value(forKey: "mobile") as? String ?? ""
        isMale = ServiceCall.userPayload.value(forKey: "gender") as? String ?? "" == "m"
        countryObj = Country(phoneCode: "91", isoCode: "IN")
        
        if(zoneArr.count > 0) {
                
            selectZone = zoneArr.first(where: { obj in
                
                if let obj = obj as? NSDictionary {
                    return "\( obj.value(forKey: "zone_id") as? Int ?? 0 )" == "\(ServiceCall.userPayload.value(forKey: "zone_id") as? Int ?? -1)"
                }
                return false
                
            }) as? NSDictionary
            
        }
        if(serviceArr.count > 0 ) {
            
            let selectServiceIDArr = (ServiceCall.userPayload.value(forKey: "select_service_id") as? String ?? "").split(separator: ",").map { id in
                return Int(id)
            }
            for sObj in serviceArr {
                sObj.value = selectServiceIDArr.contains(sObj.id)
            }
        }
        
    }
    
    //MARK: Action
    
    func updateAction(){
        if(txtName.isEmpty) {
            self.errorMessage = "Please enter name"
            self.showError  = true
            return
        }
        
        if(txtEmail.isEmpty) {
            self.errorMessage = "Please enter email"
            self.showError  = true
            return
        }
        
        if(txtMobile.isEmpty) {
            self.errorMessage = "Please enter mobile"
            self.showError  = true
            return
        }
        
        if self.selectZone == nil {
            self.errorMessage = "Please select Zone"
            self.showError  = true
            return
        }
        
        let selectService = serviceArr.filter { sObj in
            return sObj.value == true
        }.map { sObj in
            return "\(sObj.id)"
        }.joined(separator: ",")
        
        updateProfileApi(parameter: [
            "name": txtName,
            "email": txtEmail,
            "gender": isMale ? "m" : "f",
            "mobile": txtMobile,
            "mobile_code": countryObj?.phoneCode,
            "zone_id": selectZone?.value(forKey: "zone_id") as? Int ?? "",
            "select_service_id": selectService
        ] )
    }
    
    func updateBankDetailAction(){
        if(txtBankName.isEmpty) {
            self.errorMessage = "Please enter bank name"
            self.showError  = true
            return
        }
        
        if(txtAccountHolderName.isEmpty) {
            self.errorMessage = "Please enter account holder name"
            self.showError  = true
            return
        }
        
        if(txtAccountNumber.isEmpty) {
            self.errorMessage = "Please enter account numbe"
            self.showError  = true
            return
        }
        
        if txtSwiftCode.isEmpty {
            self.errorMessage = "Please enter Swift Code / IFSC Code"
            self.showError  = true
            return
        }
        
        updateBankDetailApi(parameter: [
            "bank_name": txtBankName,
            "account_name": txtAccountHolderName,
            "account_no": txtAccountNumber,
            "ifsc": txtSwiftCode
        ] )
    }
    
    func actionChangePassword(){
            
        if txtCurrentPassword.isEmpty {
            self.errorMessage = "Please enter current password"
            self.showError = true
            return
        }
        
        if txtNewPassword.isEmpty {
            self.errorMessage = "Please enter new password"
            self.showError = true
            return
        }
        
        if txtNewPassword != txtConfirmPassword {
            self.errorMessage = "Password not match"
            self.showError = true
            return
        }
        
        self.changePasswordApi(parameter: [
            "old_password": txtCurrentPassword,
            "new_password": txtNewPassword
        ])
        
    }
    
    //MARK: ServiceCall
    
    func getServiceZoneApi() {
        
        ServiceCall.post(parameter: [:], path: Globs.svServiceAndZoneList, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    let payloadObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    self.zoneArr = payloadObj.value(forKey: "zone_list") as? NSArray ?? []
                    
                    var serviceArrObj: [ServiceModel] = []
                    
                    for sObj in (payloadObj.value(forKey: "service_list") as? NSArray ?? []) {
                        
                        if let sObj = sObj as? NSDictionary {
                            serviceArrObj.append(ServiceModel(sObj: sObj, isTrue: false))
                        }
                    }
                    
                    self.serviceArr = serviceArrObj
                    
                    self.loadData()
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
    
    func updateProfileApi(parameter: NSDictionary) {
        
        
        
        
        ServiceCall.post(parameter: parameter, path: Globs.svProfileUpdate, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    ServiceCall.userPayload = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    ServiceCall.userType = ServiceCall.userPayload.value(forKey: KKey.userType) as? Int ?? 1
                    
                    Utils.UDSET(data: ServiceCall.userPayload, key: Globs.userPayload)
                    Utils.UDSET(data: true, key: Globs.userLogin)
                    
                    
                    
                    
                    self.errorMessage = "Profile Update Successfully "
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
    
    
    func getBankDetailApi() {
        
        ServiceCall.post(parameter: [:], path: Globs.svBankDetail, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    let payloadObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    self.txtBankName  = payloadObj.value(forKey: "bank_name") as? String ?? ""
                    self.txtAccountNumber = payloadObj.value(forKey: "account_no") as? String ?? ""
                    self.txtAccountHolderName = payloadObj.value(forKey: "account_name") as? String ?? ""
                    self.txtSwiftCode  = payloadObj.value(forKey: "bsb") as? String ?? ""
                    
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
    
    
    func updateBankDetailApi(parameter: NSDictionary) {
        
        ServiceCall.post(parameter: parameter, path: Globs.svDriverBankUpdate, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.errorMessage = "Bank detail Update Successfully "
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
    
    func changePasswordApi(parameter: NSDictionary) {
        
        
        ServiceCall.post(parameter: parameter, path: Globs.svChangePassword, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.txtCurrentPassword = ""
                    self.txtNewPassword = ""
                    self.txtConfirmPassword = ""
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.success
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

