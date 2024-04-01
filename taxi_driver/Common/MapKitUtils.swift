//
//  MapKitUtils.swift
//  taxi_driver
//
//  Created by CodeForAny on 01/04/24.
//

import SwiftUI
import MapKit

class MapKitUtils {
    
    class func isInsideZone(location: CLLocationCoordinate2D, zoneJson: String) -> Bool {
        
        let polygonPointArr = (Utils.getJson(objects: [zoneJson]) as? [NSDictionary] ?? [] )
            .map {obj in
                return MKMapPoint( CLLocationCoordinate2D(latitude: obj.value(forKey:"lat") as? Double ?? 0.0 , longitude: obj.value(forKey:"lng") as? Double ?? 0.0) )
        }
        let polygonObj = MKPolygon(points: polygonPointArr, count: polygonPointArr.count)
        return polygonObj.contain(location: location)
        
    }
}

extension MKPolygon {
    
    func contain(location: CLLocationCoordinate2D ) -> Bool {
        let polygonRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint = MKMapPoint(location)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        if polygonRenderer.path == nil {
            return false
        }else{
            return polygonRenderer.path.contains(polygonViewPoint)
        }
    }
    
}
