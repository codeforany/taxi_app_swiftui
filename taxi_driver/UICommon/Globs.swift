//
//  Globs.swift
//  taxi_driver
//
//  Created by CodeForAny on 26/12/23.
//

import SwiftUI

struct Globs {
    static let AppName = "Taxi Driver"
    
    
    static let userPayload = "user_payload"
    static let userLogin = "user_login"
    
    static let BASE_URL = "http://localhost:3001"
    static let API_URL = BASE_URL + "/api/"
    static let NODE_URL = BASE_URL
    
    static let svLogin = API_URL + "login"
    static let svProfileImage = API_URL + "profile_image"
    
    static let svServiceAndZoneList = API_URL + "service_and_zone_list"
    static let svProfileUpdate = API_URL + "profile_update"
    
    static let svBankDetail = API_URL + "bank_detail"
    static let svDriverBankUpdate = API_URL + "driver_bank_update"
    
    static let svBrandList = API_URL + "brand_list"
    static let svModelList = API_URL + "model_list"
    static let svSeriesList = API_URL + "series_list"
    static let svAddCar = API_URL + "add_car"
    static let svCarList = API_URL + "car_list"
    static let svDeleteCar = API_URL + "car_delete"
    static let svSetRunningCar = API_URL + "set_running_car"
    
    static let svSupportUserList = API_URL + "support_user_list"
    static let svSupportConnect = API_URL + "support_connect"
    static let svSupportMessage = API_URL + "support_message"
    static let svSupportMessageClear = API_URL + "support_clear"
    
    static let svStaticData = API_URL + "static_data"
    
    
    
    
}

struct KKey {
    static let status = "status"
    static let message = "message"
    static let payload = "payload"
    
    static let userType = "user_type"
    static let userId = "user_id"
    static let authToken = "auth_token"
}

class Utils {
    class func UDSET(data: Any, key: String) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func UDValue(key: String) -> Any {
        return UserDefaults.standard.value(forKey: key) as Any
    }
    
    class func UDValueBool(key: String) -> Bool {
        return UserDefaults.standard.value(forKey: key) as? Bool ?? false
    }
    
    class func UDValueTrueBool(key: String) -> Bool {
        return UserDefaults.standard.value(forKey: key) as? Bool ?? true
    }
    
    class func UDRemove(key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getJson(objects: [Any]?) -> Any? {
            
        if(objects == nil) {
            return nil
        }
        
        for objectsString in objects! {
            do {
                if let objectData = (objectsString as? String)?.data(using: .utf8) {
                    return try JSONSerialization.jsonObject(with: objectData, options: .mutableContainers )
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
        
    }
    
    class func jsonString(obj: Any, prettyPrint: Bool) -> String {
        guard let data  = try? JSONSerialization.data(withJSONObject: obj, options: []) else{
            return "{}"
        }
        return String(data: data, encoding: .utf8) ?? "{}"
    }
}

struct MSG {
    static let fail = "Fail"
    static let success = "Success"
}
