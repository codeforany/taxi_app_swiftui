//
//  DocumentViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 27/04/24.
//

import SwiftUI

class DocumentViewModel: ObservableObject {
    static var shared = DocumentViewModel()
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var docArr: [DocumentModel] = []
    @Published var carDocArr: [DocumentModel] = []
    
    @Published var selectCarDoc: NSDictionary = [:]
    
    init() {
        self.documentListApi()
    }
    
    func selectCarGetDocList(obj: NSDictionary) {
        selectCarDoc = obj
        carDocumentListApi()
    }
    
    //MARK: Action
    func uploadDocAction(obj: NSDictionary, img: UIImage ) {
        uploadDocumentApi(parameter: [
            "doc_id":"\( obj.value(forKey: "doc_id") ?? "" )",
            "zone_doc_id":"\( obj.value(forKey: "zone_doc_id") ?? "" )",
            "user_car_id":"",
            "expriry_date": Date().addingTimeInterval( 60.0 * 60.0 * 24.0 * 365.0 ).string,
        ], image: img)
        
    }
    
    func uploadCarDocAction(obj: NSDictionary, img: UIImage ) {
        uploadDocumentApi(parameter: [
            "doc_id":"\( obj.value(forKey: "doc_id") ?? "" )",
            "zone_doc_id":"\( obj.value(forKey: "zone_doc_id") ?? "" )",
            "user_car_id": "\( selectCarDoc.value(forKey: "user_car_id") ?? "" )",
            "expriry_date": Date().addingTimeInterval( 60.0 * 60.0 * 24.0 * 365.0 ).string,
        ], image: img, isCarUpload: true)
        
    }
    
    //MARK: ApiCalling
    
    func documentListApi(){
        ServiceCall.post(parameter: [:], path: Globs.svPersonalDocumentList, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.docArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? [] ).map({ obj in
                        return DocumentModel(obj: obj)
                    })
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
    
    func carDocumentListApi(){
        ServiceCall.post(parameter: ["user_car_id": "\( selectCarDoc.value(forKey: "user_car_id") ?? "" )" ], path: Globs.svCarDocumentList, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.carDocArr = (responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? [] ).map({ obj in
                        return DocumentModel(obj: obj)
                    })
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
    
    func uploadDocumentApi(parameter: NSDictionary, image: UIImage, isCarUpload: Bool = false ) {
        ServiceCall.multipart(parameter: parameter, path: Globs.svDriverDoucmentUpload, imageDic: ["image": image], isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.success
                    self.showError = true
                    
                    if(isCarUpload) {
                        self.carDocumentListApi()
                    }else{
                        self.documentListApi()
                    }
                    
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

