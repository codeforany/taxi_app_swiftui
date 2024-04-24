//
//  SummaryView.swift
//  taxi_driver
//
//  Created by CodeForAny on 14/10/23.
//

import SwiftUI

struct SummaryView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var sVM = SummaryViewModel.shared
    
    
    
    
    var body: some View {
        ZStack {
            VStack{
                
                
                ZStack{
                    Text("Summary")
                        .font(.customfont(.extraBold, fontSize: 25))
                    
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(.white)
                        
                        Spacer()
//                        
//                        Button(action: {
//                            
//                        }, label: {
//                                                        
//                            Text("Normal")
//                                .font(.customfont(.regular, fontSize: 16))
//                        })
//                        .foregroundColor(.primaryApp)
                    }
                }
                
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                VStack(spacing: 0) {
                    VStack(alignment: sVM.isToday ? .leading : .trailing ){
                        HStack {
                            Button(action: {
                                withAnimation {
                                    sVM.isToday = true
                                }
                                
                            }, label: {
                                Text("TODAY")
                                    .font(.customfont(.extraBold, fontSize: 16))
                                    .foregroundColor( sVM.isToday ? .primaryApp : .lightGray )
                            })
                            .frame(maxWidth: .infinity, alignment: .center)
                            Button(action: {
                                withAnimation {
                                    sVM.isToday = false
                                }
                                
                            }, label: {
                                Text("WEEKLY")
                                    .font(.customfont(.extraBold, fontSize: 16))
                                    .foregroundColor( !sVM.isToday ? .primaryApp : .lightGray )
                            })
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .frame(height: 40)
                        
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.primaryApp)
                            .frame(width: (.screenWidth * 0.5) - 25, height: 4 )
                        
                        
                    }
                    .padding(.horizontal, 25)
                    Rectangle()
                        .fill(Color.lightWhite)
                        .frame(height: 8)
                        .padding(.bottom, 10)
                }
                
                
                ScrollView{
                    VStack {
                        
                        Text(sVM.todayDate.dayString)
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.secondaryText)
                            .padding(.top, 25)
                        HStack(alignment: .top,spacing: 8) {
                            Text("$")
                                .font(.customfont(.extraBold, fontSize: 14))
                                .foregroundColor(Color.primaryApp)
                            Text("\( sVM.isToday ? sVM.todayTotal : sVM.weekTotal, specifier: "%.2f" )")
                                .font(.customfont(.extraBold, fontSize: 25))
                                .foregroundColor(Color.primaryText)
                        }
                        .padding(.bottom, 25)
                        
                        if(!sVM.isToday) {
                            
                            let maxHeight: Double = (  .screenWidth * 0.4 ) -  50.0
                            
                            HStack {
                                
                                
                                ForEach(0 ..< sVM.weekTripsArr.count, id: \.self ) {
                                    index in
                                    
                                    let obj = sVM.weekTripsArr[index]
                                    
                                    let barHeight = maxHeight * ( obj.value(forKey: "total_amt") as? Double ?? 0.0 ) / sVM.maxWeekDayAmt
                                    VStack {
                                        
                                        Spacer()
                                        
                                        Rectangle()
                                            .fill(Color.primaryApp)
                                            .frame( width: 40, height: barHeight)
                                            .cornerRadius(10, corner: [.topLeft, .topRight])
                                        
                                        Text( (obj.value(forKey: "date") as? String ?? "").date.dauNameOnly)
                                            .font(.customfont(.regular, fontSize: 16))
                                            .foregroundColor(Color.secondaryText)
                                    }
                                    
                                }
                            }
                            .frame(width: .infinity, height: .screenWidth * 0.4, alignment:   .bottom  )
                        }
                       
                        
                        VStack(spacing: 0) {
                            Divider()
                            
                            HStack{
                                TitleSubtitleButton(title: "\( sVM.isToday ? sVM.todayTrips : sVM.weekTrips )", subtitle: "Trips")
                                
                                Rectangle().fill(Color.lightGray)
                                    .frame(width: 1, height: 80)
                                TitleSubtitleButton(title: String(format: "$%.2f", sVM.isToday ? sVM.todayOnlineTotal : sVM.weekOnlineTotal ), subtitle: "Online Trip")
                                
                                
                                Rectangle().fill(Color.lightGray)
                                    .frame(width: 1, height: 80)
                                TitleSubtitleButton(title:  String(format: "$%.2f", sVM.isToday ? sVM.todayCashTotal : sVM.weekCashTotal ), subtitle: "Cash Trip")
                            }
                            
                            Divider()
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.lightWhite)
                                    .frame(height: 20)
                                
                                Text("TRIPS")
                                    .font(.customfont(.extraBold, fontSize: 15))
                                    .foregroundColor(Color.primaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 8)
                                    .background(Color.lightWhite)
                                
                            }
                            .padding(.bottom, 8)
                        }
                    }
                    
                    
                   
                        if(sVM.isToday) {
                            LazyVStack{
                                ForEach(0..<sVM.todatTripsArr.count, id: \.self, content:  { index in
                                    
                                    TodaySummaryRow(sObj: sVM.todatTripsArr[index] )
                                })
                                //
                            }
                            .padding(.horizontal, 20)
                        }else{
                            LazyVStack{
                                ForEach(0..<sVM.weekTripsArr.count, id: \.self, content:  { index in
                                    
                                    WeeklySummaryRow(sObj: sVM.weekTripsArr[index] )
                                })
                                //
                            }
                            .padding(.horizontal, 20)
                        }
                       
                        
                        
                        
                   
                }
            }
            
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    SummaryView()
}
