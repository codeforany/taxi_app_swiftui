//
//  SocketViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 14/01/24.
//

import SwiftUI
import SocketIO

class SocketViewModel: ObservableObject {
    
    static var shared = SocketViewModel()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    init() {
        self.manager = SocketManager(socketURL: URL(string: Globs.NODE_URL)!, config: [.log(false), .compress] )
        self.socket = self.manager.defaultSocket
        
        socket.on(clientEvent: .connect) { (data, ack) in
            
            print("Socket Connected")
            self.updateSocket()
        }
        
        socket.on(clientEvent: .disconnect) { (data, ack) in
            
            print("Socket Disconnect")
        }
        
        socket.onAny { (event) in
            
            let responseObj = Utils.getJson(objects: event.items!)
            print("-------------- %@\n\n", event.event, event.items as Any)
            print("-------------- %@ \n item %@", event.event, responseObj as Any)
            
        }
        
        socket.on("UpdateSocket") {  (object, ack) in
            print("Socket Response UpdateSocket  : %@", object )
            
            if( object.count > 0) {
                if let responseObj = object[0] as? NSDictionary {
                    if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                      
                        print("Sccess status")
                    }else{
                        print("Fail Status")
                    }
                }
            }
        }
        
        socket.on(clientEvent: .error) { (object, ack) in
            print("Socket error  : %@", object )
        }
        
        socket.connect(timeoutAfter: 0) {
            print(" --------- ---- %d", self.socket.status)
        }
        
        socket.connect()
        
    }
    
    func emit(event: String, with items: NSArray) {
            
        switch self.socket.status {
        case .connected:
            self.socket.emit(event, items)
            break
        case .connecting:
            print(" \n\n ------- Connecting ----- %@ \n\n", event)
            self.socket.once(clientEvent: .connect) { (object, ack) in
                
                self.socket.emit(event, items)
                print(" \n\n ------- ConnectOnce ----- %@ \n\n", event)
            }
            break
        case .notConnected:
            print(" \n\n ------- Not Connected ----- %@ \n\n", event)
            break
        case .disconnected:
            print(" \n\n ------- Disconnected ----- %@ \n\n", event)
            break
        default:
            break
        }
        
    }
    
    func updateSocket(){
        let mVM = MainViewModel.shard
        if( mVM.userlogin) {
            print("Socket ID: %@", self.socket.sid ?? " no socket id" )
            
            self.emit(event: "UpdateSocket", with: [ Utils.jsonString(obj: ["access_token": ServiceCall.userPayload.value(forKey: "auth_token") as? String ?? "" ] , prettyPrint: false) ] )
        }
    }
}


