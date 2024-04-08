//
//  MyMapView.swift
//  taxi_driver
//
//  Created by CodeForAny on 08/10/23.
//

import Foundation
import SwiftUI
import MapKit

struct MyMapView: UIViewRepresentable {
    
    @Binding var requestLocation: CLLocationCoordinate2D
    @Binding var destinationLocation: CLLocationCoordinate2D
    @Binding var pickupIcon: String
    @Binding  var dropIcon: String
    
    var bottomPadding: Double = 300.0
   
    
    private let mapView = WrappableMapView()
    
    func makeUIView(context: UIViewRepresentableContext<MyMapView>) -> WrappableMapView {
        mapView.delegate = mapView
        mapView.pickUpIconName = pickupIcon
        mapView.dropOffIconName = dropIcon
        return mapView
    }
    
    func updateUIView(_ uiView: WrappableMapView, context: UIViewRepresentableContext<MyMapView>) {
        
        
        uiView.pickUpIconName = pickupIcon
        uiView.dropOffIconName = dropIcon
        
        //Clean Map
        uiView.removeOverlays(uiView.overlays)
        uiView.removeAnnotations(uiView.annotations)
        
        // Draw Pickup Pin
        let requestAnnotation = MKPointAnnotation()
        requestAnnotation.coordinate = requestLocation
        requestAnnotation.title = "pickup"
        uiView.addAnnotation(requestAnnotation)
        
        // Draw DropOFF Pin
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = destinationLocation
        destinationAnnotation.title = "dropoff"
        uiView.addAnnotation(destinationAnnotation)
        
        //Draw path
        
        let requestPlacemark = MKPlacemark(coordinate: requestLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
        
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: requestPlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            
            guard let response = response else {
                return
            }
            
            let route =  response.routes[0]
            uiView.addOverlay(route.polyline,  level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            uiView.setRegion(MKCoordinateRegion(rect), animated: true)
            
            uiView.setVisibleMapRect(rect, edgePadding: .init(top: 10.0, left: 50.0, bottom: bottomPadding, right: 50), animated: true)
        }
        
    }
    
    func setMapRegion(_ region: CLLocationCoordinate2D) {
        mapView.region = MKCoordinateRegion(center: region, latitudinalMeters: 60000, longitudinalMeters: 60000)
    }
    
    
}

class WrappableMapView: MKMapView, MKMapViewDelegate {
    
    var pickUpIconName = "pickup_pin"
    var dropOffIconName = "drop_pin"
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = Color.primaryText.uiColor()
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        }else{
            annotationView?.annotation = annotation
        }
        
        switch annotation.title {
        case "pickup":
            annotationView?.image = UIImage(named: pickUpIconName)
        case "dropoff":
            annotationView?.image = UIImage(named: dropOffIconName)
        default:
            break
        }
        
        return annotationView
    }
}

