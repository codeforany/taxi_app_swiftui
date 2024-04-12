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
    
    @Published var selectZone: ZoneModel?
    @Published var selectRoad: Road?
    @Published var estDistance: Double = 0
    @Published var estDuration: Double = 0
    @Published var avaiableServicePriceArr: [ServicePriceModel] = []
    
    @Published var showError  = false
    @Published var errorMessage = ""
    
    
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
    
    func actionContinue(){
        
        if selectPickUp == nil {
            errorMessage = "Please select pickup location"
            showError = true
            return
        }
        
        if selectDropOff == nil {
            errorMessage = "Please select drop off location"
            showError = true
            return
        }
        
        if selectZone == nil || avaiableServicePriceArr.isEmpty {
            errorMessage = "Not Provide any service in this area"
            showError = true
            return
        }
        
        isCarService = true
        
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
                    
                    self.selectZone = obj
                    
                }else{
                    self.selectDropOffAddress = addressString
                }
                
                if(self.selectPickUp != nil && self.selectDropOff != nil) {
                    
                    let rm = RoadManager()
                    rm.getRoad(wayPoints: [ "\(self.selectPickUp!.longitude),\(self.selectPickUp!.latitude)", "\(self.selectDropOff!.longitude),\(self.selectDropOff!.latitude)"  ], typeRoad: .bike) { roadData in
                        
                            
                        DispatchQueue.main.async {
                            
                            self.selectRoad = roadData
                            print(self.selectRoad)
                            
                            if let roadData = roadData {
                                self.estDistance = roadData.distance // in Km
                                self.estDuration = roadData.duration / 60.0 // in min
                                
                                if let selectZone = self.selectZone {
                                    // found zone price
                                    self.avaiableServicePriceArr = DBHelper.shared.getZoneWiseServicePriceList(zObj: selectZone, estKM: self.estDistance, estTime: self.estDuration)
                                }else{
                                    // not data
                                    self.avaiableServicePriceArr = []
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                print(addressString)
                
            }
        
        }
    }
    
    func actionBooking(){
        
        apiBookingRequest(parameter: [
            "pickup_latitude": "\(selectPickUp?.latitude ?? 0.0)",
            "pickup_longitude": "\(selectPickUp?.longitude ?? 0.0)",
            "pickup_address": selectPickupAddress,
            "drop_latitude": "\(selectDropOff?.latitude ?? 0.0)",
            "drop_longitude": "\(selectDropOff?.longitude ?? 0.0)",
            "drop_address": selectDropOffAddress,
            "pickup_date": Date().string,
            "payment_type": "1",
            "card_id": "",
            "price_id": avaiableServicePriceArr[selectServiceIndex].priceId,
            "service_id": avaiableServicePriceArr[selectServiceIndex].serviceId,
            "est_total_distance": estDistance,
            "est_duration": estDuration,
            "amount": avaiableServicePriceArr[selectServiceIndex].estPriceMax,
        ])
    }
    
    func allClear(){
        self.selectDropOff = nil
        self.selectDropOffAddress = ""
        selectServiceIndex = 0
        avaiableServicePriceArr = []
        pinArr = []
        selectRoad = nil
        estDuration = 0
        estDistance = 0
        showMapLocation(isPickup: true)
    }
    
    //MARK: ApiCalling
    
    func apiBookingRequest(parameter: NSDictionary) {
        
        
        ServiceCall.post(parameter: parameter, path: Globs.svBookingRequest, isTokenApi: true) { responseObj in
            if let responseObj = responseObj {
                
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    self.isCarService = false
                    self.allClear()
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.success
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.showError = true
                    }
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError = true
                }
                
            }
        } failure: { error in
            self.errorMessage =  error?.localizedDescription ?? MSG.fail
            self.showError = true
        }

        
    }
    
}
