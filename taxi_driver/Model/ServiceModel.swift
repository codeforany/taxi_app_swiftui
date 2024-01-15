//
//  ServiceModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 31/12/23.
//

import SwiftUI

class ServiceModel : Identifiable, Equatable, ObservableObject {
    
    
    
    var id: Int = 0
    var serviceName: String = ""
    @Published var value: Bool = false
    
    init(sObj: NSDictionary, isTrue: Bool) {
        id = sObj.value(forKey: "service_id") as? Int ?? 0
        serviceName = sObj.value(forKey: "service_name") as? String ?? ""
        value = isTrue
    }
    
    static func == (lhs: ServiceModel, rhs: ServiceModel) -> Bool {
        return lhs.id == rhs.id
    }
}
