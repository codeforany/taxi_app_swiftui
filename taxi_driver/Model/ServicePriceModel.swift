//
//  ServicePriceModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 03/04/24.
//

import SwiftUI

class ServicePriceModel: Identifiable, Equatable {
  
    
    var serviceId: String = ""
    var priceId: String = ""
    var baseCharge:  Double = 0.0
    var perKmCharge:  Double = 0.0
    var perMinCharge:  Double = 0.0
    var bookingCharge:  Double = 0.0
    var miniFair:  Double = 0.0
    var miniKm:  Double = 0.0
    var serviceName:  String = ""
    var color:  String = ""
    var icon:  String = ""
    
    var estPriceMin: Double = 0.0
    var estPriceMax: Double = 0.0
    
    
    init(serviceId: String, priceId: String, baseCharge: Double, perKmCharge: Double, perMinCharge: Double, bookingCharge: Double, miniFair: Double, miniKm: Double, serviceName: String, color: String, icon: String) {
        self.serviceId = serviceId
        self.priceId = priceId
        self.baseCharge = baseCharge
        self.perKmCharge = perKmCharge
        self.perMinCharge = perMinCharge
        self.bookingCharge = bookingCharge
        self.miniFair = miniFair
        self.miniKm = miniKm
        self.serviceName = serviceName
        self.color = color
        self.icon = icon
    }
    
    func getEstValue(estKM: Double, estTime: Double) {
        
        var amount = self.baseCharge + (self.perKmCharge * estKM) + (self.perMinCharge * estTime) + bookingCharge
        
        if(self.miniKm >= estKM) {
            amount = miniFair
        }
        
        var minPrice = amount
        
        if(miniFair >= minPrice) {
            minPrice = miniFair
        }
        
        // 100
        self.estPriceMin = minPrice
        
        // 130
        self.estPriceMax = minPrice * 1.3
        
    }
    
    static func == (lhs: ServicePriceModel, rhs: ServicePriceModel) -> Bool {
        return lhs.serviceId == rhs.serviceId && lhs.priceId == rhs.priceId
    }
    
}
