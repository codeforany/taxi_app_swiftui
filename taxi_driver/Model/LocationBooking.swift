//
//  LocationBooking.swift
//  taxi_driver
//
//  Created by CodeForAny on 31/03/24.
//

import SwiftUI
import MapKit

struct LocationBooking: Identifiable, Equatable {
    let id: UUID = UUID()
    var name = ""
    var isPickup: Bool = false
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var location : CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

