//
//  MessageModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/01/24.
//

import SwiftUI

struct MessageModel: Identifiable, Equatable {
        
        var id: Int = 0
        var senderId: Int = 0
        var receiverId: Int = 0
        var message: String = ""
        var createdDate: Date = Date()
        
        init(mObj: NSDictionary) {
            id = mObj.value(forKey: "chat_id") as? Int ?? 0
            senderId = mObj.value(forKey: "sender_id") as? Int ?? 0
            receiverId = mObj.value(forKey: "receiver_id") as? Int ?? 0
            message = mObj.value(forKey: "message") as? String ?? ""
            createdDate = (mObj.value(forKey: "created_date") as? String ?? "").date
        }
        
        static func == (lhs: MessageModel, rhs: MessageModel) -> Bool {
            return lhs.id == rhs.id
        }
}
