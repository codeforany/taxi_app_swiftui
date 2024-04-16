//
//  MyRideViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 15/04/24.
//

import SwiftUI

class MyRideViewModel: ObservableObject {
    static var shared = MyRideViewModel()
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var myRideArr: [NSDictionary] = []
    @Published var driverAmount = 0.0
    @Published var totalAmount = 0.0
    
    func statusText(rideObj: NSDictionary) -> String {
            
        switch rideObj.value(forKey: "booking_status")  as? Int ?? 0 {
        case 2:
            return "On Way"
        case 3:
            return "Waiting"
        case 4:
            return "Started"
        case 5:
            return "Completed"
        case 6:
            return "Cancel"
        case 7:
            return "No Drivers"
        default:
            return "Pending"
        }
        
    }
    
    func statusColor(rideObj: NSDictionary) -> Color {
            
        switch rideObj.value(forKey: "booking_status")  as? Int ?? 0 {
        case 2:
            return Color.green
        case 3:
            return Color.orange
        case 4:
            return Color.green
        case 5:
            return Color.green
        case 6:
            return Color.red
        case 7:
            return Color.red
        default:
            return Color.blue
        }
        
    }
    
    func statusWiseDateTime(rideObj: NSDictionary) -> String {
            
        switch rideObj.value(forKey: "booking_status")  as? Int ?? 0 {
        case 2:
            return (rideObj.value(forKey: "accpet_time") as? String ?? "").date.statusString
        case 3:
            return (rideObj.value(forKey: "start_time") as? String ?? "").date.statusString
        case 4:
            return (rideObj.value(forKey: "start_time") as? String ?? "").date.statusString
        case 5:
            return (rideObj.value(forKey: "stop_time") as? String ?? "").date.statusString
        case 6:
            return (rideObj.value(forKey: "stop_time") as? String ?? "").date.statusString
        case 7:
            return (rideObj.value(forKey: "stop_time") as? String ?? "").date.statusString
        default:
            return (rideObj.value(forKey: "pickup_date") as? String ?? "").date.statusString
        }
        
    }
    
    //MARK: ApiCalling
    func  apiUserRideAll() {
            
        ServiceCall.post(parameter: [:], path: Globs.svUserAllRideList, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.myRideArr = responseObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []
                }
            }
            
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? MSG.fail
            self.showError = true
        }

        
    }
    
    func apiDriverRideAll(){
        ServiceCall.post(parameter: [:], path: Globs.svDriverAllRideList, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    let payload = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    self.myRideArr = payload.value(forKey: "ride_list") as?  [NSDictionary] ?? []
                    self.totalAmount = Double("\( payload.value(forKey: "total") ?? "" )") ?? 0.0
                    self.driverAmount = Double("\( payload.value(forKey: "driver_total") ?? "" )") ?? 0.0
                }
            }
            
            
        } failure: { error in
            self.errorMessage  = error?.localizedDescription ?? MSG.fail
            self.showError = true
        }

    }
    
}
