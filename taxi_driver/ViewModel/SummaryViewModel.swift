//
//  SummaryViewModel.swift
//  taxi_driver
//
//  Created by CodeForAny on 25/04/24.
//

import SwiftUI

class SummaryViewModel: ObservableObject {
    static var shared = SummaryViewModel()
    
    
    @Published var errorMessage = ""
    @Published var showError = false
    
    @Published var todayObj: NSDictionary = [:]
    @Published var weekObj: NSDictionary  = [:]
    
    @Published var todatTripsArr: [NSDictionary] = []
    @Published var weekTripsArr: [NSDictionary] = []
    
    
    @Published var todayTrips: Int = 0
    @Published var todayTotal: Double = 0.0
    @Published var todayCashTotal: Double = 0.0
    @Published var todayOnlineTotal: Double = 0.0
    
    @Published var weekTrips: Int = 0
    @Published var weekTotal: Double = 0.0
    @Published var weekCashTotal: Double = 0.0
    @Published var weekOnlineTotal: Double = 0.0
    
    
    @Published var todayDate: Date = Date()
    @Published var isToday = true
    
    @Published var maxWeekDayAmt: Double = 0.0
    
    
    init(){
        apiData()
    }
    
    //MARK: ApiCalling
    func apiData(){
        ServiceCall.post(parameter: [:], path: Globs.svDriverSummary, isTokenApi: true) { responseObj in
            
            if let responseObj = responseObj {
                if responseObj.value(forKey: KKey.status) as? String ?? "" == "1" {
                    
                    let payloadObj = responseObj.value(forKey: KKey.payload) as? NSDictionary ?? [:]
                    
                    self.todayObj = payloadObj.value(forKey: "today") as? NSDictionary ?? [:]
                    self.weekObj = payloadObj.value(forKey: "week") as? NSDictionary ?? [:]
                    
                    
                    self.todayTrips = self.todayObj.value(forKey: "tips_count") as? Int ?? 0
                    self.todayTotal = self.todayObj.value(forKey: "total_amt") as? Double ?? 0.0
                    self.todayCashTotal = self.todayObj.value(forKey: "cash_amt") as? Double ?? 0.0
                    self.todayOnlineTotal = self.todayObj.value(forKey: "online_amt") as? Double ?? 0.0
                    
                    self.weekTrips = self.weekObj.value(forKey: "tips_count") as? Int ?? 0
                    self.weekTotal = self.weekObj.value(forKey: "total_amt") as? Double ?? 0.0
                    self.weekCashTotal = self.weekObj.value(forKey: "cash_amt") as? Double ?? 0.0
                    self.weekOnlineTotal = self.weekObj.value(forKey: "online_amt") as? Double ?? 0.0
                    
                    self.todatTripsArr = self.todayObj.value(forKey: "list") as? [NSDictionary] ?? []
                    self.weekTripsArr = self.weekObj.value(forKey: "chart") as? [NSDictionary] ?? []
                    
                    
                    let maxAmount = self.weekTripsArr.map { obj in
                        return obj.value(forKey: "total_amt") as? Double ?? 0.0
                    }.max() ?? 1.0
                    
                    self.maxWeekDayAmt = maxAmount > 0 ? maxAmount : 1
                    
                }else{
                    self.errorMessage = responseObj.value(forKey: KKey.message) as? String ?? MSG.fail
                    self.showError = true
                }
            }
            
        } failure: { error in
            self.errorMessage = error?.localizedDescription ?? MSG.fail
            self.showError = true
        }

    }
    
}

