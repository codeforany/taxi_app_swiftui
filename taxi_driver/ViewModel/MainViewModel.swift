//
//  MainViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 30/12/23.
//

import SwiftUI

class MainViewModel: ObservableObject  {
    static var shard = MainViewModel()
    
    @Published var userlogin  = false
    @Published var showType: Int = 0
    // 0 = Login
    // 1 = Show Profile Image
    // 2 = Show profile Detail Edit
    // 3 = Show Home
    
    
    init() {
        
        reloadData()
        
    }
    
    func reloadData(){
        userlogin = Utils.UDValueBool(key: Globs.userLogin)
        
        if( userlogin ) {
            
            ServiceCall.userPayload = Utils.UDValue(key: Globs.userPayload) as? NSDictionary ?? [:]
            ServiceCall.userType = ServiceCall.userPayload.value(forKey: KKey.userType) as? Int ?? 1
            
            if(ServiceCall.userPayload.value(forKey: "image") as? String ?? "" == "" ) {
                showType = 1
            }else if (ServiceCall.userPayload.value(forKey: "name") as? String ?? "" == "" ) {
                showType = 2
            }else{
                showType = 3
            }
        }
    }
    
}

