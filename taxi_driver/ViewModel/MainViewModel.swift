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
    // 4 = Show User Home
    

    
    
    init() {
        
        reloadData()
        statiDataApi()
        
    }
    
    func reloadData(){
        userlogin = Utils.UDValueBool(key: Globs.userLogin)
        
        if( userlogin ) {
            
            ServiceCall.userPayload = Utils.UDValue(key: Globs.userPayload) as? NSDictionary ?? [:]
            ServiceCall.userType = ServiceCall.userPayload.value(forKey: KKey.userType) as? Int ?? 1
            
            if(ServiceCall.userType == 1) {
                showType = 4
            }else{
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
    
    func statiDataApi() {
        
        ServiceCall.post(parameter: ["last_call_time": ""], path: Globs.svStaticData, isTokenApi: false) { responseObj in
            
            if let responseObj = responseObj {
                if  responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    var payloadObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    DBHelper.shared.addZone(arr: payloadObj.value(forKey: "zone_list") as? [NSDictionary] ?? [] )
                    DBHelper.shared.addService(arr: payloadObj.value(forKey: "service_detail") as? [NSDictionary] ?? [] )
                    DBHelper.shared.addPrice(arr: payloadObj.value(forKey: "price_detail") as? [NSDictionary] ?? [] )
                    DBHelper.shared.addDocument(arr: payloadObj.value(forKey: "document") as? [NSDictionary] ?? [] )
                    DBHelper.shared.addZoneDocument(arr: payloadObj.value(forKey: "zone_document") as? [NSDictionary] ?? [] )
                    
                    
                    print("Static Data Save Done -----")
                }
            }
            
        
        } failure: { error in
            print("Static Data Api Calling Error: \( error?.localizedDescription ?? "Error" )")
        }
    }
    
    
    
}

