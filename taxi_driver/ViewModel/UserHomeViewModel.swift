//
//  UserHomeViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 31/03/24.
//

import SwiftUI
import MapKit

class UserHomeViewModel : ObservableObject {
    static var shared = UserHomeViewModel()
    
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 21.1702, longitude: 72.8311), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)) {
        
        didSet {
            print("\( region.center.latitude ), \( region.center.longitude )")
        }
    }
    
    @Published var pinArr: [LocationBooking] = []
    
    @Published var selectReion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 21.1702, longitude: 72.8311), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    
    @Published var selectPickUp: CLLocationCoordinate2D?
    @Published var selectDropOff: CLLocationCoordinate2D?
    
    
    @Published var selectPickupAddress = ""
    @Published var selectDropOffAddress = ""
    
    @Published var isLock = false
    
    @Published var isOpen = false
    
    @Published var isSelectPickup = true
    @Published var isCarService = false
    
    @Published var serviceList = [
        [
            "icon":"car_1",
            "name":"Economy",
            "price":"$10-$20"
        ],
        
        [
            "icon":"car_1",
            "name":"Luxury",
            "price":"$13-$23"
        ],
        
        [
            "icon":"car_1",
            "name":"First Class",
            "price":"$25-$30"
        ],
    ]
    
    @Published var selectServiceIndex = 0
    
    @Published var activeZoneArr: [ZoneModel] = []
    
    init(){
        setupRegionDebounce()
        activeZoneArr = DBHelper.shared.getActiveZone()
    }
    
    func setupRegionDebounce(){
        selectReion = self.region
        $region.debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .assign(to: &$selectReion)
         
    }
    
    func showMapLocation( isPickup: Bool ) {
            
        if(isSelectPickup == isPickup) {
            return
        }
        
        isSelectPickup = isPickup
        isLock = true
        
        
        if(isPickup) {
            if let selectLocation = selectPickUp {
                region.center = selectLocation
            }
            
            if let selectLocation = selectDropOff {
                pinArr = [ LocationBooking(isPickup: false, latitude: selectLocation.latitude, longitude: selectLocation.longitude) ]
            }
            
        }else{
                
            if (selectDropOff == nil) {
                selectDropOff = selectPickUp
                selectDropOffAddress = selectPickupAddress
                isLock = false
                
                if let selectLocation = selectPickUp {
                    pinArr = [ LocationBooking(isPickup: true, latitude: selectLocation.latitude, longitude: selectLocation.longitude) ]
                }
                return
                
            }else{
                if let selectLocation = selectDropOff {
                    region.center = selectLocation
                }
                
                if let selectLocation = selectPickUp {
                    pinArr = [ LocationBooking(isPickup: true, latitude: selectLocation.latitude, longitude: selectLocation.longitude) ]
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.isLock = false
        }
        
    }
    
    
    func getAddressForLatLong(location: CLLocationCoordinate2D, isPickup: Bool ) {
        
        
        if(isLock) {
            return
        }
        
        if(isPickup) {
            selectPickUp = location
        }else{
            selectDropOff = location
        }
        
        
        let ceo: CLGeocoder = CLGeocoder()
        let loc: CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        ceo.reverseGeocodeLocation(loc) { plackmarks, error in
                
            if(error != nil) {
                print("reverseGeocodeLocation fail: \( error?.localizedDescription)")
                return
            }
            
            let pm = plackmarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = plackmarks![0]
                
                var addressString: String = ""
                
                if pm.name != nil {
                    addressString = addressString + pm.name! + ","
                }
                
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ","
                }
                
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ","
                }
                
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ","
                }
                
                if pm.country != nil {
                    addressString = addressString + pm.country! + ","
                }
                
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + ""
                }
                
                if(isPickup) {
                    self.selectPickupAddress = addressString
                    
                    var isFound = false
                    var obj: ZoneModel?
                    
                    for zoneData in self.activeZoneArr {
                        if MapKitUtils.isInsideZone(location: location, zoneJson: zoneData.zoneJson) {
                            print(" Inside Zone Found: \(zoneData.zoneId), \(zoneData.zoneName ) ")
                            isFound = true
                            obj = zoneData
                        }
                    }
                    
                    
                    print(" \n \( isFound ? " Zone Found" : "Not Found" )" )
                    print(obj)
                    
                }else{
                    self.selectDropOffAddress = addressString
                }
                print(addressString)
                
            }
        
        }
    }
    
}
