//
//  DocumentModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 27/04/24.
//

import SwiftUI

class DocumentModel: Identifiable, Equatable {
        
    let id = UUID()
    var data: NSDictionary = [:]
    
    init(obj: NSDictionary) {
        self.data = obj
    }
    
    static func == (lhs: DocumentModel, rhs: DocumentModel) -> Bool {
        return lhs.id == rhs.id
    }

}
