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
    
    init() {
        self.documentListApi()
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
    
    func uploadDocumentApi(parameter: NSDictionary, image: UIImage) {
        ServiceCall.multipart(parameter: parameter, path: Globs.svDriverDoucmentUpload, imageDic: ["image": image], isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.success
                    self.showError = true
                    self.documentListApi()
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

