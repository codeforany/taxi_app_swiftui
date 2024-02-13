//
//  SupportViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/01/24.
//

import SwiftUI

class SupportViewModel: ObservableObject {
    
    static var shared = SupportViewModel()
    
    
    var sVM = SocketViewModel.shared
    
    @Published var userArr: [SupportUserModel] = []
    @Published var messageArr: [MessageModel] = []
    
    @Published var txtMessage = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var selectSupportUser: SupportUserModel? {
        didSet {
            
            if (selectSupportUser != nil) {
                
                messageArr = []
                supportUserConnectApi(parameter: [
                    "user_id": selectSupportUser?.id ?? "" ,
                    "socket_id": sVM.socket.sid ?? "" ,
                ])
                showMessage = true
            }else{
                messageArr = []
            }
            
        }
    }
    @Published var showMessage = false
    
    init(){
            
        sVM.socket.on("support_message") { data, ack in
            
            print("socket support_message response: %@", data )
            
            if(data.count > 0) {
                    
                if let resObj = data[0] as? NSDictionary {
                        
                    if resObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                            
                        var pObj = resObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []
                        var uObj = SupportUserModel(uObj: resObj.value(forKey: "user_info") as? NSDictionary ?? [:])
                        
                        if (pObj.count > 0) {
                            var mObj = MessageModel(mObj: pObj[0])
                            
                            if let selectUser = self.selectSupportUser, selectUser.id == mObj.senderId {
                                self.messageArr.append(mObj)
                            }
                            
                            
                            for i in 0 ..< self.userArr.count {
                                
                                var sObj = self.userArr[i]
                                
                                if sObj.id == uObj.id {
                                    
                                    
                                    
                                    uObj.message = mObj.message
                                    uObj.baseCount = sObj.baseCount + 1
                                    uObj.createdDate = mObj.createdDate
                                    
                                    self.userArr.remove(at: i)
                                    break
                                }
                            }
                            
                            
                                uObj.message = mObj.message
                                uObj.baseCount = 1
                                uObj.createdDate = mObj.createdDate
                                self.userArr.insert(uObj, at: 0)
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: ServiceCall
    
    func supportUserApi() {
        
        ServiceCall.post(parameter: ["socket_id": sVM.socket.sid ?? ""], path: Globs.svSupportUserList, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    var arr: [SupportUserModel] =  (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? [] ).map { obj  in
                        
                        return SupportUserModel(uObj: obj)
                    
                    }
                    self.userArr = arr
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
    
    func supportUserConnectApi(parameter: NSDictionary) {
        
        ServiceCall.post(parameter: parameter, path: Globs.svSupportConnect, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    var pObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    var arr: [MessageModel] =  (pObj.value(forKey: "messages") as? [NSDictionary] ?? [] ).map { obj  in
                        return MessageModel(mObj: obj)
                    }
                    self.messageArr = arr
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
    
    func sendMessageApi() {
        ServiceCall.post(parameter: [
            "message": txtMessage,
            "receiver_id": selectSupportUser?.id ?? "" ,
            "socket_id": sVM.socket.sid ?? "" ,
        ], path: Globs.svSupportMessage, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    var pObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    self.txtMessage = ""
                    self.messageArr.append(MessageModel(mObj: pObj))
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
    
    func clearAllMessageApi(){
        ServiceCall.post(parameter: [
            "receiver_id": selectSupportUser?.id ?? "" ,
        ], path: Globs.svSupportMessageClear, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    self.messageArr = []
                    
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

