//
//  UserRunRideViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 12/04/24.
//

import SwiftUI

import MapKit


class UserRunRideViewModel: ObservableObject {
    
    static var shared = UserRunRideViewModel()
    let rm = RoadManager()
    let sVM = SocketViewModel.shared
    
    @Published var rideObj : NSDictionary = [:]
    
    @Published var pickupLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var dropLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    @Published var pickUpPinIcon = "pickup_pin"
    @Published var dropPinIcon = "drop_pin"
    
    @Published var isOpen = true
    @Published var showCancel = false
    @Published var showCancelReason = false
    
    @Published var rateUser: Int = 5
    @Published var showToll = false
    @Published var txtToll = ""
    
    @Published var showOTP = false
    @Published var txtOTP = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    @Published var showRunningRide = false
    
    
    @Published var rideStatusName = ""
    @Published var rideStatusText = ""
    @Published var rideStatusColor = Color.blue
    @Published var displayAddress = ""
    @Published var displayAddressIcon = ""
    @Published var estDuration = 0.0
    @Published var estDistance = 0.0
    @Published var btnName = ""
    
    @Published var isAlertOkBack = false
    @Published var showRideComplete = false
    
    init() {
        apiHome()
        
        sVM.socket.on("user_request_accept") { data, ack in
            print(" socket user_request_accept response %@ ", data)
            
            if(data.count > 0) {
                if let resObj = data[0] as? NSDictionary {
                    if resObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                        
                        self.apiHome()
                    }
                }
            }
        }
        
        sVM.socket.on("driver_cancel_ride") { data, ack in
            print(" socket driver_cancel_ride response %@ ", data)
            
            if(data.count > 0) {
                if let resObj = data[0] as? NSDictionary {
                    if resObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                        let bObj = resObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                        if bObj.value(forKey: "booking_id") as? Int ?? -1 == self.rideObj.value(forKey: "booking_id") as? Int ?? 0 {
                            self.showRunningRide = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                UserHomeViewModel.shared.errorMessage = "Driver cancel ride"
                                UserHomeViewModel.shared.showError = true
                            }
                        }
                    }
                }
            }
        }
        
        
        sVM.socket.on("driver_wait_user") { data, ack in
            print(" socket driver_wait_user response %@ ", data)
            
            if(data.count > 0) {
                if let resObj = data[0] as? NSDictionary {
                    if resObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                        let bObj = resObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                        if bObj.value(forKey: "booking_id") as? Int ?? -1 == self.rideObj.value(forKey: "booking_id") as? Int ?? 0 {
                            if let tempObj = self.rideObj as? NSMutableDictionary {
                                tempObj.setValue( bObj.value(forKey: "booking_status") , forKey: "booking_status")
                                self.setRideData(obj: tempObj)
                            }
                        }
                    }
                }
            }
        }
        
        sVM.socket.on("ride_start") { data, ack in
            print(" socket ride_start response %@ ", data)
            
            if(data.count > 0) {
                if let resObj = data[0] as? NSDictionary {
                    if resObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                        let bObj = resObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                        if bObj.value(forKey: "booking_id") as? Int ?? -1 == self.rideObj.value(forKey: "booking_id") as? Int ?? 0 {
                            if let tempObj = self.rideObj as? NSMutableDictionary {
                                tempObj.setValue( bObj.value(forKey: "booking_status") , forKey: "booking_status")
                                self.setRideData(obj: tempObj)
                            }
                        }
                    }
                }
            }
        }
        
        sVM.socket.on("ride_stop") { data, ack in
            print(" socket ride_stop response %@ ", data)
            
            if(data.count > 0) {
                if let resObj = data[0] as? NSDictionary {
                    if resObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                        let bObj = resObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                        if bObj.value(forKey: "booking_id") as? Int ?? -1 == self.rideObj.value(forKey: "booking_id") as? Int ?? 0 {
                            if let tempObj = self.rideObj as? NSMutableDictionary {
                                tempObj.setValue( bObj.value(forKey: "booking_status") , forKey: "booking_status")
                                tempObj.setValue( bObj.value(forKey: "amt") , forKey: "amount")
                                tempObj.setValue( bObj.value(forKey: "tax_amt") , forKey: "tax_amount")
                                tempObj.setValue( bObj.value(forKey: "duration") , forKey: "duration")
                                tempObj.setValue( bObj.value(forKey: "total_distance") , forKey: "total_distance")
                                tempObj.setValue( bObj.value(forKey: "toll_tax") , forKey: "toll_tax")
                                self.setRideData(obj: tempObj)
                                self.showRideComplete = true
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Action
    func actionDriverRideCancel(){
        apiUserRideCancel(parameter: [
            "booking_id" : self.rideObj.value(forKey: "booking_id") ?? "",
            "booking_status": self.rideObj.value(forKey: "booking_status") ?? ""
        ])
    }
    
    func actionRating(){
        apiUserRating(parameter:
                        [
                            "booking_id" :  self.rideObj.value(forKey: "booking_id") ?? "",
                            "rating": "\( self.rateUser )",
                            "comment": ""
                        ]
        )
    }
    
   
    
    //MARK: ApiCalling
    func apiHome() {
            
        ServiceCall.post(parameter: [:], path: Globs.svHome, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                        
                    let payloadObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    self.setRideData(obj: payloadObj.value(forKey: "running") as? NSDictionary ?? [:] )
                   
                }
            }
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? MSG.fail
            self.showError = true
        }
    }
    
    
    
    func  apiUserRideCancel(parameter: NSDictionary) {
            
        ServiceCall.post(parameter: parameter, path: Globs.svUserRideCancel, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.isAlertOkBack = true
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
    
    
    func apiUserRating(parameter: NSDictionary){
        ServiceCall.post(parameter: parameter , path: Globs.svRideRating, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.isAlertOkBack = true
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
    
    func setRideData(obj: NSDictionary) {
        self.rideObj = obj
        if(self.rideObj.count > 0) {
            
            self.rideStatusName = statusName()
            self.rideStatusText = statusText()
            self.rideStatusColor  = statusColor()
            
            self.loadRideRoadData()
            if(!self.showRunningRide) {
                self.showRunningRide = true
            }
        }
    }
    
    func loadRideRoadData(){
        let rideStatusId = rideObj.value(forKey: "booking_status") as? Int ?? 0
            
        if (rideStatusId == BStatus.bsGoUser || rideStatusId == BStatus.bsWaitUser) {
            btnName = rideStatusId == BStatus.bsGoUser ? "ARRIVED" : "START"
            
            displayAddress = rideObj.value(forKey: "pickup_address") as? String ?? ""
            displayAddressIcon = "pickup_pin_1"
            pickUpPinIcon = "target"
            dropPinIcon = "pickup_pin"
            
            pickupLocation = CLLocationCoordinate2D(latitude: Double( rideObj.value(forKey: "lati") as? String ?? "0.0" ) ?? 0.0  , longitude:  Double( rideObj.value(forKey: "longi") as? String ?? "0.0" ) ?? 0.0 )
            
            dropLocation = CLLocationCoordinate2D(latitude: Double( rideObj.value(forKey: "pickup_lat") as? String ?? "0.0" ) ?? 0.0 , longitude: Double( rideObj.value(forKey: "pickup_long") as? String ?? "0.0" ) ?? 0.0)
            
            rm.getRoad(wayPoints: [ "\(self.pickupLocation.longitude),\(self.pickupLocation.latitude)", "\(dropLocation.longitude),\(dropLocation.latitude)"  ], typeRoad: .bike) { roadData in
                
                    
                DispatchQueue.main.async {
                    
                    if let roadData = roadData {
                        self.estDistance = roadData.distance // in Km
                        self.estDuration = roadData.duration / 60.0 // in min
                    
                    }
                    
                }
                
            }
        }else{
            btnName = "COMPLETE"
            
            displayAddress = rideObj.value(forKey: "drop_address") as? String ?? ""
            displayAddressIcon = "drop_pin_1"
            pickUpPinIcon = "target"
            dropPinIcon = "drop_pin"
            
            pickupLocation = CLLocationCoordinate2D(latitude: Double( rideObj.value(forKey: "lati") as? String ?? "0.0" ) ?? 0.0  , longitude:  Double( rideObj.value(forKey: "longi") as? String ?? "0.0" ) ?? 0.0 )
            
            dropLocation = CLLocationCoordinate2D(latitude: Double( rideObj.value(forKey: "drop_lat") as? String ?? "0.0" ) ?? 0.0 , longitude: Double( rideObj.value(forKey: "drop_long") as? String ?? "0.0" ) ?? 0.0)
            
            rm.getRoad(wayPoints: [ "\(self.pickupLocation.longitude),\(self.pickupLocation.latitude)", "\(dropLocation.longitude),\(dropLocation.latitude)"  ], typeRoad: .bike) { roadData in
                
                    
                DispatchQueue.main.async {
                    
                    if let roadData = roadData {
                        self.estDistance = roadData.distance // in Km
                        self.estDuration = roadData.duration / 60.0 // in min
                    
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
    func statusName() -> String {
            
        switch rideObj.value(forKey: "booking_status")  as? Int ?? 0 {
        case 2:
            return "On Way Driver \( rideObj.value(forKey: "name") ?? "" )"
        case 3:
            return "Waiting Driver \( rideObj.value(forKey: "name") ?? "" )"
        case 4:
            return "Ride Started With \( rideObj.value(forKey: "name") ?? "" )"
        case 5:
            return "Ride Complete With \( rideObj.value(forKey: "name") ?? "" )"
        case 6:
            return "Ride Cancel \( rideObj.value(forKey: "name") ?? "" )"
        case 7:
            return "No Driver Found"
        default:
            return "Finding Driver Near By"
        }
        
    }
    
    func statusText() -> String {
            
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
    
    func statusColor() -> Color {
            
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
    
}

