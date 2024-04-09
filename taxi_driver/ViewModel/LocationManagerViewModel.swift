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
    
    var isSaveFileLocation = false
    var bookingId: Int = 0
    
    
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
                
                if(isSaveFileLocation && bookingId != 0) {
                    writeLocationToFile(loc: location, bookingId: bookingId)
                }
                
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
    
    //MARK: Location Save In File
    func writeLocationToFile(loc: CLLocation, bookingId: Int) {
        
        do {
            if let file = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                let filePath = file.appendingPathComponent("\(bookingId).txt")
                
                print("File Save: \( filePath.path )")
                
                if FileManager.default.fileExists(atPath: filePath.path) {
                    //Append Text Inside File
                    
                    let fileHandle = try FileHandle(forWritingTo: filePath)
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(",{\"latitude\":\( loc.coordinate.latitude ),\"longitude\":\(loc.coordinate.longitude),\"time\":\"\( Date().string )\"}".data(using: .utf8)!)
                    fileHandle.closeFile()
                    
                }else{
                    //New File Create
                    try "{\"latitude\":\( loc.coordinate.latitude ),\"longitude\":\(loc.coordinate.longitude),\"time\":\"\( Date().string )\"}".data(using: .utf8)!.write(to: filePath)
                }
            }
        }
        catch {
            print ("\(bookingId).txt File Save Error: \( error.localizedDescription )")
        }
        
    }
    
    func getRideSaveLocationJsonString(bookingId: Int) -> String {
        do {
            if let file = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                let filePath = file.appendingPathComponent("\(bookingId).txt")
                
                print("File Save: \( filePath.path )")
                
                if FileManager.default.fileExists(atPath: filePath.path) {
                    let text = try String(contentsOfFile: filePath.path, encoding: .utf8 )
                    return "[\(text)]"
                }else{
                    return "[]"
                }
            }else{
                return "[]"
            }
        }
        catch {
            print ("\(bookingId).txt File Read Error: \( error.localizedDescription )")
            return "[]"
        }
    }
    
    func startRideLocationSave(loc: CLLocation, bookingId: Int) {
        self.writeLocationToFile(loc: loc, bookingId: bookingId)
        self.bookingId = bookingId
        self.isSaveFileLocation = true
    }
    
    func stopRideLocationSave(){
        self.bookingId = 0
        self.isSaveFileLocation = false
    }
    
}
