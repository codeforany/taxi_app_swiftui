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
    static let isOnline = "is_online"
    
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
    static let svBookingRequest = API_URL + "booking_request"
    static let svUpdateLocation = API_URL + "update_location"
    
    static let svDriverOnline = API_URL + "driver_online"
    static let svDriverRideAccept = API_URL + "ride_request_accept"
    static let svDriverRideDecline = API_URL + "ride_request_decline"
    
    static let svHome = API_URL + "home"
    static let svDriverWaitUser = API_URL + "driver_wait_user"
    
    static let svRideStart = API_URL + "ride_start"
    static let svRideStop = API_URL + "ride_stop"
    
    static let svDriverRideCancel = API_URL + "driver_cancel_ride"
    static let svUserRideCancel = API_URL + "user_cancel_ride"
    static let svUserAllRideList = API_URL + "user_all_ride_list"
    static let svDriverAllRideList = API_URL + "driver_all_ride_list"
    
    static let svRideRating = API_URL + "ride_rating"
    static let svBookingDetail = API_URL + "booking_detail"
    static let svDriverSummary = API_URL + "driver_summary"
    
    static let svPersonalDocumentList = API_URL + "personal_document_list"
    static let svDriverDoucmentUpload = API_URL + "driver_update_document"
    static let svCarDocumentList = API_URL + "car_document_list"
    
    static let svChangePassword = API_URL + "change_password"
    static let svContactUs = API_URL + "contact_us"
    
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
