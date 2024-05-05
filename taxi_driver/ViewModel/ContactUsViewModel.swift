//
//  ContactUsViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 06/05/24.
//

import SwiftUI

class ContactUsViewModel: ObservableObject {
    
    static var shared = ContactUsViewModel()
    
    @Published var showError = false
    @Published var errorMessage  = ""
    
    @Published var txtName = ""
    @Published var txtEmail = ""
    @Published var txtSubject = ""
    @Published var txtMessage = ""
    
    //MARK: Action
    
    func actionSubmit(){
        
        if(txtName.isEmpty) {
            errorMessage = "Please enter name"
            showError = true
            return
        }
        
        if(txtEmail.isEmpty) {
            errorMessage = "Please enter email address"
            showError = true
            return
        }
        
        if(txtSubject.isEmpty) {
            errorMessage = "Please enter subject"
            showError = true
            return
        }
        
        if(txtMessage.isEmpty) {
            errorMessage = "Please enter message"
            showError = true
            return
        }
        
        contactUsApi(parameter: [
            "name": txtName,
            "email": txtEmail,
            "subject": txtSubject,
            "message": txtMessage,])
        
    }
    
    //MARK: ApiCalling
    
    func contactUsApi(parameter: NSDictionary) {
        
        ServiceCall.post(parameter: parameter, path: Globs.svContactUs) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.txtName = ""
                    self.txtEmail = ""
                    self.txtSubject = ""
                    self.txtMessage = ""
                    
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.success
                    self.showError = true
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError = true
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? MSG.fail
            self.showError = true
        }

        
    }
}
