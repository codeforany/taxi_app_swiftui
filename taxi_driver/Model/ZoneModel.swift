//
//  ZoneModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 01/04/24.
//

import SwiftUI

class ZoneModel: Identifiable, Equatable {
    
    
        
    var zoneId: String = ""
    var zoneName: String = ""
    var zoneJson: String = ""
    
    
    init(zoneId: String, zoneName: String, zoneJson: String) {
        self.zoneId = zoneId
        self.zoneName = zoneName
        self.zoneJson = zoneJson
    }
    
    static func == (lhs: ZoneModel, rhs: ZoneModel) -> Bool {
        return lhs.zoneId == rhs.zoneId
    }
}
