//
//  DriverViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 06/04/24.
//

import SwiftUI
import MapKit

class DriverViewModel: ObservableObject {
    static var shared = DriverViewModel()
    var sVM  = SocketViewModel.shared
    
    @Published var isOnline = false
    
    
    @Published var newRequestObj: NSDictionary = [:]
    @Published var pickupLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var dropLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var showNewRequest = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    
    init() {
        isOnline = Utils.UDValueBool(key: Globs.isOnline)
        LocationManagerViewModel.shared.start()
        
        sVM.socket.on("new_ride_request") { data, ack in
            print(" socket new_ride_request response %@ ", data)
            
            if(data.count > 0) {
                if let resObj = data[0] as? NSDictionary {
                    if resObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                        
                        var pObj = resObj.value(forKey: KKey.payload) as? [NSDictionary] ?? []
                        
                        if(pObj.count > 0) {
                            self.newRequestObj = pObj[0]
                            self.pickupLocation = CLLocationCoordinate2D(latitude: Double(self.newRequestObj.value(forKey: "pickup_lat") as? String ?? "") ?? 0.0, longitude: Double(self.newRequestObj.value(forKey: "pickup_long") as? String ?? "") ?? 0.0)
                            self.dropLocation = CLLocationCoordinate2D(latitude: Double(self.newRequestObj.value(forKey: "drop_lat") as? String ?? "") ?? 0.0 ,  longitude: Double(self.newRequestObj.value(forKey: "drop_long") as? String ?? "") ??  0.0 )
                            self.showNewRequest = true
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Action
    
    func actionGoOnline(){
        
        isOnline = !isOnline
        apiDriverOnline(parameter: [ "is_online":  isOnline ? "1" : "0" ])
        
    }
    
    
    func actionDriverRequestAccept(){
        apiDriverRequestAcceptDecline(parameter: [ "booking_id": newRequestObj.value(forKey: "booking_id") ?? "", "request_token": newRequestObj.value(forKey: "request_token") ?? "" ], serviceName: Globs.svDriverRideAccept)
    }
    
    func actionDriverRequestDecline(){
        apiDriverRequestAcceptDecline(parameter: [ "booking_id": newRequestObj.value(forKey: "booking_id") ?? "", "request_token": newRequestObj.value(forKey: "request_token") ?? "" ], serviceName: Globs.svDriverRideDecline)
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
    
    func apiDriverRequestAcceptDecline(parameter: NSDictionary, serviceName: String) {
            
        ServiceCall.post(parameter: parameter, path: serviceName, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    
                    if( serviceName == Globs.svDriverRideAccept ) {
                        DriverViewModel.shared.showNewRequest = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            DriverRunRideViewModel.shared.apiHome()
                        }
                    }else{
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
    
    
}
