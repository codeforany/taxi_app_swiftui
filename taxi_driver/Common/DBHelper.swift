//
//  DBHelper.swift
//  taxi_driver
//
//  Created by CodeForAny on 05/03/24.
//

import SwiftUI
import SQLite

class DBHelper {
    static let shared = DBHelper()
    
    var dbConnection: Connection?
    
    private let tbZone = Table("zone_list")
    private let tbService = Table("service_detail")
    private let tbPrice = Table("price_detail")
    private let tbDocument = Table("document")
    private let tbZoneDocument = Table("zone_document")
    
    private let zoneId = Expression<String>("zone_id")
    private let zoneName = Expression<String>("zone_name")
    private let zoneJson = Expression<String>("zone_json")
    private let city = Expression<String>("city")
    private let tax = Expression<String>("tax")
    private let status = Expression<String>("status")
    private let createdDate = Expression<String>("created_date")
    private let modifyDate = Expression<String>("modify_date")
    
    
    private let serviceId = Expression<String>("service_id")
    private let serviceName = Expression<String>("service_name")
    private let seat = Expression<String>("seat")
    private let color = Expression<String>("color")
    private let icon = Expression<String>("icon")
    private let topIcon = Expression<String>("top_icon")
    private let gender = Expression<String>("gender")
    private let description = Expression<String>("description")
    
    
    private let priceId = Expression<String>("price_id")
    private let baseCharge = Expression<String>("base_charge")
    private let perKmCharge = Expression<String>("per_km_charge")
    private let perMinCharge = Expression<String>("per_min_charge")
    private let bookingCharge = Expression<String>("booking_charge")
    private let miniFair = Expression<String>("mini_fair")
    private let miniKm = Expression<String>("mini_km")
    private let cancelCharge = Expression<String>("cancel_charge")
    
    
    private let docId = Expression<String>("doc_id")
    private let name = Expression<String>("name")
    private let type = Expression<String>("type")
    
    
    private let zoneDocId = Expression<String>("zone_doc_id")
    private let personalDoc = Expression<String>("personal_doc")
    private let carDoc = Expression<String>("car_doc")
    private let requiredPersonalDoc = Expression<String>("required_personal_doc")
    private let requiredCarDoc = Expression<String>("required_car_doc")
//    private let  = Expression<String>("")
    
    private init(){
        do {
            let dbPath = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("app_data.sqlits3").path
            
            print("DB SAVE Path: \(dbPath)")
            
            dbConnection = try Connection(dbPath)
            
            createTable()
        }
        catch {
            dbConnection = nil
            print("Error init Database: \( error.localizedDescription )")
        }
    }
    
    func createTable(){
        do {
            try dbConnection?.run(tbZone.create(ifNotExists: true, block: { table in
                    
                table.column(zoneId, primaryKey: true)
                table.column(zoneName)
                table.column(zoneJson)
                table.column(city)
                table.column(tax)
                table.column(status)
                table.column(createdDate)
                table.column(modifyDate)
                
            }))
            
            try dbConnection?.run(tbService.create(ifNotExists: true, block: { table in
                    
                table.column(serviceId, primaryKey: true)
                table.column(serviceName)
                table.column(seat)
                table.column(color)
                table.column(icon)
                table.column(topIcon)
                table.column(gender)
                table.column(description)
                table.column(status)
                table.column(createdDate)
                table.column(modifyDate)
                
            }))
            
            try dbConnection?.run(tbPrice.create(ifNotExists: true, block: { table in
                
                    
                table.column(priceId, primaryKey: true)
                table.column(zoneId)
                table.column(serviceId)
                table.column(baseCharge)
                table.column(perKmCharge)
                table.column(perMinCharge)
                table.column(bookingCharge)
                table.column(miniFair)
                table.column(miniKm)
                table.column(cancelCharge)
                table.column(tax)
                table.column(status)
                table.column(createdDate)
                table.column(modifyDate)
                
            }))
            
            try dbConnection?.run(tbDocument.create(ifNotExists: true, block: { table in
                
                    
                table.column(docId, primaryKey: true)
                table.column(name)
                table.column(type)
                table.column(status)
                table.column(createdDate)
                table.column(modifyDate)
                
            }))
            
            try dbConnection?.run(tbZoneDocument.create(ifNotExists: true, block: { table in
                
                    
                table.column(zoneDocId, primaryKey: true)
                table.column(zoneId)
                table.column(serviceId)
                table.column(personalDoc)
                table.column(carDoc)
                table.column(requiredPersonalDoc)
                table.column(requiredCarDoc)
                table.column(status)
                table.column(createdDate)
                table.column(modifyDate)
                
            }))
            print("DB Table Create Done")
        } catch {
            print("DB Table Error: \( error.localizedDescription )")
        }
    }
    
    func addZone(arr: [NSDictionary]) {
        if(arr.isEmpty) {
            print(" add Zone is empty")
            return
        }
        
        do {
            let iSQl = tbZone.insertMany(or: .replace, arr.map({ obj in
                
                return [
                    zoneId <- "\( obj.value(forKey: "zone_id") ?? "")",
                    zoneName <- "\( obj.value(forKey: "zone_name") ?? "")",
                    zoneJson <- "\( obj.value(forKey: "zone_json") ?? "")",
                    city <- "\( obj.value(forKey: "city") ?? "")",
                    tax <- "\( obj.value(forKey: "tax") ?? "")",
                    status <- "\( obj.value(forKey: "status") ?? "")",
                    createdDate <- "\( obj.value(forKey: "created_date") ?? "")",
                    modifyDate <- "\( obj.value(forKey: "modify_date") ?? "")"
                ]
            }))
            
            try dbConnection?.run(iSQl)
            
            print("DB Table Insert Done")
        }
        catch {
            print("DB Table Insert addZone Error: \( error.localizedDescription )")
        }
    }
    
    func addService(arr: [NSDictionary]) {
        if(arr.isEmpty) {
            print(" add Service is empty")
            return
        }
        
        do {
            let iSQl = tbService.insertMany(or: .replace, arr.map({ obj in
                
                return [
                    serviceId <- "\( obj.value(forKey: "service_id") ?? "")",
                    serviceName <- "\( obj.value(forKey: "service_name") ?? "")",
                    seat <- "\( obj.value(forKey: "seat") ?? "")",
                    color <- "\( obj.value(forKey: "color") ?? "")",
                    icon <- "\( obj.value(forKey: "icon") ?? "")",
                    topIcon <- "\( obj.value(forKey: "top_icon") ?? "")",
                    gender <- "\( obj.value(forKey: "gender") ?? "")",
                    description <- "\( obj.value(forKey: "description") ?? "")",
                    status <- "\( obj.value(forKey: "status") ?? "")",
                    createdDate <- "\( obj.value(forKey: "created_date") ?? "")",
                    modifyDate <- "\( obj.value(forKey: "modify_date") ?? "")"
                ]
            }))
            
            try dbConnection?.run(iSQl)
            
            print("DB Table Service Insert Done")
        }
        catch {
            print("DB Table Insert addZone Error: \( error.localizedDescription )")
        }
    }
    
    func addPrice(arr: [NSDictionary]) {
        if(arr.isEmpty) {
            print(" add Price is empty")
            return
        }
        
        do {
            let iSQl = tbPrice.insertMany(or: .replace, arr.map({ obj in
                
                return [
                    priceId <- "\( obj.value(forKey: "price_id") ?? "")",
                    zoneId <- "\( obj.value(forKey: "zone_id") ?? "")",
                    serviceId <- "\( obj.value(forKey: "service_id") ?? "")",
                    baseCharge <- "\( obj.value(forKey: "base_charge") ?? "")",
                    perKmCharge <- "\( obj.value(forKey: "per_km_charge") ?? "")",
                    perMinCharge <- "\( obj.value(forKey: "per_min_charge") ?? "")",
                    bookingCharge <- "\( obj.value(forKey: "booking_charge") ?? "")",
                    miniFair <- "\( obj.value(forKey: "mini_fair") ?? "")",
                    miniKm <- "\( obj.value(forKey: "mini_km") ?? "")",
                    cancelCharge <- "\( obj.value(forKey: "cancel_charge") ?? "")",
                    tax <- "\( obj.value(forKey: "tax") ?? "")",
                    status <- "\( obj.value(forKey: "status") ?? "")",
                    createdDate <- "\( obj.value(forKey: "created_date") ?? "")",
                    modifyDate <- "\( obj.value(forKey: "modify_date") ?? "")"
                ]
            }))
            
            try dbConnection?.run(iSQl)
            
            print("DB Table Price Insert Done")
        }
        catch {
            print("DB Table Insert addZone Error: \( error.localizedDescription )")
        }
    }
    
    func addDocument(arr: [NSDictionary]) {
        if(arr.isEmpty) {
            print(" add Document is empty")
            return
        }
        
        do {
            let iSQl = tbDocument.insertMany(or: .replace, arr.map({ obj in
                
                return [
                    docId <- "\( obj.value(forKey: "doc_id") ?? "")",
                    name <- "\( obj.value(forKey: "name") ?? "")",
                    type <- "\( obj.value(forKey: "type") ?? "")",
                    
                    status <- "\( obj.value(forKey: "status") ?? "")",
                    createdDate <- "\( obj.value(forKey: "created_date") ?? "")",
                    modifyDate <- "\( obj.value(forKey: "modify_date") ?? "")"
                ]
            }))
            
            try dbConnection?.run(iSQl)
            
            print("DB Table Document Insert Done")
        }
        catch {
            print("DB Table Insert addZone Error: \( error.localizedDescription )")
        }
    }
    
    func addZoneDocument(arr: [NSDictionary]) {
        if(arr.isEmpty) {
            print(" add Zone Document is empty")
            return
        }
        
        do {
            let iSQl = tbZoneDocument.insertMany(or: .replace, arr.map({ obj in
                
                return [
                    zoneDocId <- "\( obj.value(forKey: "zone_doc_id") ?? "")",
                    zoneId <- "\( obj.value(forKey: "zone_id") ?? "")",
                    serviceId <- "\( obj.value(forKey: "service_id") ?? "")",
                    personalDoc <- "\( obj.value(forKey: "personal_doc") ?? "")",
                    carDoc <- "\( obj.value(forKey: "car_doc") ?? "")",
                    requiredPersonalDoc <- "\( obj.value(forKey: "required_personal_doc") ?? "")",
                    requiredCarDoc <- "\( obj.value(forKey: "required_car_doc") ?? "")",
                    status <- "\( obj.value(forKey: "status") ?? "")",
                    createdDate <- "\( obj.value(forKey: "created_date") ?? "")",
                    modifyDate <- "\( obj.value(forKey: "modify_date") ?? "")"
                ]
            }))
            
            try dbConnection?.run(iSQl)
            
            print("DB Table Zone Document Insert Done")
        }
        catch {
            print("DB Table Insert addZone Error: \( error.localizedDescription )")
        }
    }
    
    func getActiveZone() -> [ZoneModel] {
        
        do {
            
            let dataSQL = tbZone.select(tbZone[*]).join(tbPrice, on: tbZone[zoneId] == tbPrice[zoneId]).filter(tbPrice[status] == "1" && tbZone[status] == "1").group(tbZone[zoneId])
            
            var dataArr: [ZoneModel] = []
            if let  dbConnection = dbConnection {
                for user in try dbConnection.prepare(dataSQL) {
                    dataArr.append(ZoneModel(zoneId: "\( user[zoneId] )", zoneName: "\( user[zoneName] )", zoneJson: "\( user[zoneJson] )"))
                }
            }
            
            return dataArr
            
        }
        catch {
            print("DB Table Zone List Get Data Error")
        }
        
        
        return []
        
    }
    
    func getZoneWiseServicePriceList(zObj: ZoneModel, estKM: Double, estTime: Double) -> [ServicePriceModel] {
        do {
            
            let dataSQL = tbService.select(tbService[*], tbPrice[*]).join(tbPrice, on: tbService[serviceId] == tbPrice[serviceId]).filter(tbPrice[status] == "1" && tbService[status] == "1" && tbPrice[zoneId] == zObj.zoneId)
            
            var dataArr: [ServicePriceModel] = []
            if let  dbConnection = dbConnection {
                for spObj in try dbConnection.prepare(dataSQL) {
                    
                    let pObj = ServicePriceModel(serviceId: "\( spObj[ tbService[serviceId]] )", priceId: "\( spObj[ tbPrice[serviceId]] )", baseCharge: Double( "\( spObj[ tbPrice[baseCharge]] )" ) ?? 0.0, perKmCharge: Double( "\( spObj[ tbPrice[perKmCharge]] )" ) ?? 0.0, perMinCharge: Double( "\( spObj[ tbPrice[perMinCharge]] )" ) ?? 0.0, bookingCharge: Double( "\( spObj[ tbPrice[bookingCharge]] )" ) ?? 0.0, miniFair: Double( "\( spObj[ tbPrice[miniFair]] )" ) ?? 0.0, miniKm: Double( "\( spObj[ tbPrice[miniKm]] )" ) ?? 0.0, serviceName: "\( spObj[ tbService[serviceName]] )", color: "\( spObj[ tbService[color]] )", icon: "\( spObj[ tbService[icon]] )")
                    
                    pObj.getEstValue(estKM: estKM, estTime: estTime)                    
                    dataArr.append(pObj)
                }
            }
            
            return dataArr
            
        }
        catch {
            print("DB Table Zone List Get Data Error")
        }
        
        
        return []
        
    }
    
}
