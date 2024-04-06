//
//  DriverViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 06/04/24.
//

import SwiftUI

class DriverViewModel: ObservableObject {
    static var shared = DriverViewModel()
    
    @Published var isOnline = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    
    init() {
        isOnline = Utils.UDValueBool(key: Globs.isOnline)
        LocationManagerViewModel.shared.start()
    }
    
    //MARK: Action
    
    func actionGoOnline(){
        
        isOnline = !isOnline
        apiDriverOnline(parameter: [ "is_online":  isOnline ? "1" : "0" ])
        
    }
    
    //MARK: ApiCalling
    
    func apiDriverOnline(parameter: NSDictionary) {
            
        ServiceCall.post(parameter: parameter, path: Globs.svDriverOnline, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    Utils.UDSET(data: self.isOnline, key: Globs.isOnline)
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
