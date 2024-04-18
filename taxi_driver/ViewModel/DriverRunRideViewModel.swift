//
//  DriverRunRideViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 08/04/24.
//

import SwiftUI
import MapKit

class BStatus {
    static var bsPending = 0
    static var bsAccept = 1
    static var bsGoUser = 2
    static var bsWaitUser = 3
    static var bsStart = 4
    static var bsComplete = 5
    static var bsCancel = 6
    static var bsDriverNotFound = 7
}

class DriverRunRideViewModel: ObservableObject {
    
    static var shared = DriverRunRideViewModel()
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
    
    @Published var rateUser: Int = 4
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
    
    init() {
        apiHome()
        
        sVM.socket.on("user_cancel_ride") { data, ack in
            print(" socket user_cancel_ride response %@ ", data)
            
            if(data.count > 0) {
                if let resObj = data[0] as? NSDictionary {
                    if resObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                        let bObj = resObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                        if bObj.value(forKey: "booking_id") as? Int ?? -1 == self.rideObj.value(forKey: "booking_id") as? Int ?? 0 {
                            self.showRunningRide = false
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                DriverViewModel.shared.errorMessage = "User cancel ride"
                                DriverViewModel.shared.showError = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Action
    func actionDriverRideCancel(){
        apiDriverRideCancel(parameter: [
            "booking_id" : self.rideObj.value(forKey: "booking_id") ?? "",
            "booking_status": self.rideObj.value(forKey: "booking_status") ?? ""
        ])
    }
    func actionRating(){
        apiDriverRating(parameter:
                        [
                            "booking_id" :  self.rideObj.value(forKey: "booking_id") ?? "",
                            "rating": "\( self.rateUser )",
                            "comment": ""
                        ]
        )
    }
    
    func actionStatusChange(){
            
        let rideStatusId = rideObj.value(forKey: "booking_status") as? Int ?? 0
        
        if(rideStatusId == BStatus.bsGoUser) {
            apiDriverWaituser(parameter: ["booking_id": self.rideObj.value(forKey: "booking_id") ?? "" ])
        }else if rideStatusId == BStatus.bsWaitUser{
            
            if(!showOTP) {
                showOTP = true
                return
            }
            
            if (txtOTP.count != 4) {
                errorMessage = "Please enter valid OTP"
                showError  = true
                return
            }
            
            let lastLocation = LocationManagerViewModel.shared.location
            
            apiDriverRideStart(parameter: [
                "booking_id": self.rideObj.value(forKey: "booking_id")  ?? "",
                "pickup_latitude": lastLocation.coordinate.latitude,
                "pickup_longitude": lastLocation.coordinate.longitude,
                "otp_code": txtOTP
            ], loc: lastLocation)
            
            
        }else if ( rideStatusId == BStatus.bsStart ) {
                
            if(!showToll) {
                showToll = true
                return
            }
            
            let lastLocation = LocationManagerViewModel.shared.location
            LocationManagerViewModel.shared.stopRideLocationSave()
            
            apiDriverRideStop(parameter: [
                "booking_id" :  self.rideObj.value(forKey: "booking_id") ?? "",
                "drop_latitude" : lastLocation.coordinate.latitude,
                "drop_longitude" : lastLocation.coordinate.longitude,
                "ride_location": LocationManagerViewModel.shared.getRideSaveLocationJsonString(bookingId: self.rideObj.value(forKey: "booking_id") as? Int ??  0 ),
                "toll_tax" : txtToll == "" ? "0" : txtToll
            ])
            
        }
        
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
    
    func apiDriverWaituser(parameter: NSDictionary) {
            
        ServiceCall.post(parameter: parameter, path: Globs.svDriverWaitUser, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    let payloadObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    self.setRideData(obj: payloadObj)
                    
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
    
    func apiDriverRideStart(parameter: NSDictionary, loc: CLLocation) {
            
        ServiceCall.post(parameter: parameter, path: Globs.svRideStart, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    let payloadObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    self.setRideData(obj: payloadObj)
                    
                    self.showOTP = false
                    self.txtOTP = ""
                    
                    LocationManagerViewModel.shared.startRideLocationSave(loc: loc, bookingId: self.rideObj.value(forKey: "booking_id") as? Int ?? 0)
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.success
                        self.showError = true
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
    
    func apiDriverRideStop(parameter: NSDictionary) {
            
        ServiceCall.post(parameter: parameter, path: Globs.svRideStop, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    let payloadObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    self.setRideData(obj: payloadObj)
                    
                    self.showToll = false
                    self.txtToll = ""
                    
                   
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.success
                        self.showError = true
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
    
    func  apiDriverRideCancel(parameter: NSDictionary) {
            
        ServiceCall.post(parameter: parameter, path: Globs.svDriverRideCancel, isTokenApi: true) { responseObj in
            
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
    
    func apiDriverRating(parameter: NSDictionary){
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
            
            pickupLocation = CLLocationCoordinate2D(latitude: LocationManagerViewModel.shared.location.coordinate.latitude , longitude:  LocationManagerViewModel.shared.location.coordinate.longitude)
            
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
            
            pickupLocation = CLLocationCoordinate2D(latitude: LocationManagerViewModel.shared.location.coordinate.latitude , longitude:  LocationManagerViewModel.shared.location.coordinate.longitude)
            
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
            return "Pickup Up \( rideObj.value(forKey: "name") ?? "" )"
        case 3:
            return "Waiting For \( rideObj.value(forKey: "name") ?? "" )"
        case 4:
            return "Ride Started With \( rideObj.value(forKey: "name") ?? "" )"
        case 5:
            return "Ride Complete With \( rideObj.value(forKey: "name") ?? "" )"
        case 6:
            return "Ride Cancel \( rideObj.value(forKey: "name") ?? "" )"
        default:
            return             "Finding Driver Near By"
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

