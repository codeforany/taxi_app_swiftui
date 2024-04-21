//
//  TipDetailViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/04/24.
//

import SwiftUI
import MapKit

class TipDetailViewModel: ObservableObject {
   
    static var shared = TipDetailViewModel()
    
    @Published var rideObj: NSDictionary = [:]
    @Published var pickupLocation = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @Published var dropLocation = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
   
    @Published var errorMessage = ""
    @Published var showError = false
    
    func loadRide(obj: NSDictionary) {
        rideObj = obj
        apiDetail()
    }
    
    //MAKE: ApiCalling
    func apiDetail(){
        
        ServiceCall.post(parameter: [ "booking_id": rideObj.value(forKey: "booking_id") ?? "" ], path: Globs.svBookingDetail, isTokenApi: true) { responseObj in
                
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    self.rideObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    self.pickupLocation = CLLocationCoordinate2D(latitude: Double( self.rideObj.value(forKey: "pickup_lat" ) as? String ?? "" ) ?? 0.0 , longitude: Double( self.rideObj.value(forKey: "pickup_long" ) as? String ?? "" ) ?? 0.0)
                    
                    self.dropLocation = CLLocationCoordinate2D(latitude: Double( self.rideObj.value(forKey: "drop_lat" ) as? String ?? "" ) ?? 0.0 , longitude: Double( self.rideObj.value(forKey: "drop_long" ) as? String ?? "" ) ?? 0.0)
                    
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
