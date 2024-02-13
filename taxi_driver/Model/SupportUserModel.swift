//
//  SupportUserModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/01/24.
//

import SwiftUI

struct SupportUserModel: Identifiable, Equatable {
    
    
    
    var id: Int = 0
    var name: String = ""
    var image: String = ""
    var message: String = ""
    var createdDate: Date = Date()
    var baseCount: Int = 0
    
    init(uObj: NSDictionary) {
        id = uObj.value(forKey: "user_id") as? Int ?? 0
        baseCount = uObj.value(forKey: "base_count") as? Int ?? 0
        name = uObj.value(forKey: "name") as? String ?? ""
        image = uObj.value(forKey: "image") as? String ?? ""
        message = uObj.value(forKey: "message") as? String ?? ""
        createdDate = (uObj.value(forKey: "created_date") as? String ?? "").date
    }
    
    static func == (lhs: SupportUserModel, rhs: SupportUserModel) -> Bool {
        return lhs.id == rhs.id
    }
}

