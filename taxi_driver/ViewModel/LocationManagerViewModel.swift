//
//  LocationManagerViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 05/04/24.
//

import SwiftUI
import CoreLocation

class LocationManagerViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        
    static var shared = LocationManagerViewModel()
    
    var locationManager: CLLocationManager?
    
    @Published var location: CLLocation = CLLocation(latitude: 0, longitude: 0)
    @Published var degree: Double = 0.0
    
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.distanceFilter = 20.0
        locationManager?.requestWhenInUseAuthorization()
        
    }
    
    func start(){
        locationManager?.startUpdatingLocation()
    }
    
    func stop(){
        locationManager?.stopUpdatingLocation()
    }
    
    func speed() -> Double {
        
        let sp = location.speed
        
        if( sp < 0) {
            return 0.0
        }else{
            // 2.237 Mile Per Hours
            // 3.6 KM per Hours
            
            return sp * 3.6
            
        }
        
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            if self.location.coordinate.latitude == location.coordinate.latitude && self.location.coordinate.longitude == location.coordinate.longitude {
                
                print(" Location is Not Change Same Postion")
                return
            }
            self.degree = getDirectionFormCoordinate(fromLoc: self.location, toLoc: location)
            self.location = location
            
            debugPrint(" Location : \( location.coordinate.latitude ), \( location.coordinate.longitude ) ")
            debugPrint(" Degree : \( self.degree ) ")
            debugPrint(" Update Speed : \( self.speed() ) ")
            
            if( MainViewModel.shard.userlogin && ServiceCall.userType == 2 ) {
                apiDriverUpdateLocation(parameter: ["latitude": self.location.coordinate.latitude ,"longitude": self.location.coordinate.longitude,"socket_id": SocketViewModel.shared.socket.sid ?? ""] )
            }
        }
    }
    
    func  degressToRadians(value: Double) -> Double {
        return Double.pi * value / 180.0
    }
    
    func  radiansToDegress(value: Double) -> Double {
        return value * 180.0 / Double.pi
    }
    
    func getDirectionFormCoordinate(fromLoc: CLLocation, toLoc: CLLocation) -> Double {
        
        let fLat = degressToRadians(value: fromLoc.coordinate.latitude)
        let fLng = degressToRadians(value: fromLoc.coordinate.longitude)
        let tLat = degressToRadians(value: toLoc.coordinate.latitude)
        let tLng = degressToRadians(value: toLoc.coordinate.longitude)
        
        var degree = radiansToDegress(value:  atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLng - fLng) ) )
        
        if(degree < 0) {
            degree = 360.0 * degree;
        }
        
        return degree
    }
    
    //Mark: ApiCalling
    func apiDriverUpdateLocation(parameter: NSDictionary) {
        
        
        ServiceCall.post(parameter: parameter, path: Globs.svUpdateLocation, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                print("Location Manager apiUpdateLocation " )
                print(responseObj)
            }
        } failure: { error in
            print("Location Manager Error \( error?.localizedDescription ?? "Error" )" )
        }

        
    }
    
}
