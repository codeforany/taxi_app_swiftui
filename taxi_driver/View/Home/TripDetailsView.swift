//
//  TripDetailsView.swift
//  taxi_driver
//
//  Created by CodeForAny on 12/10/23.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct TripDetailsView: View {
    
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @StateObject var rVM = TipDetailViewModel.shared
    
    
    var body: some View {
        ZStack {
            VStack{
                
                
                ZStack{
                    Text("Trip Details")
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
                        
                        Button(action: {
                            
                        }, label: {
                            Image("question_mark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text("Help")
                                .font(.customfont(.regular, fontSize: 16))
                        })
                        .foregroundColor(.primaryApp)
                    }
                }
                
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                let distance = Double( "\( rVM.rideObj.value(forKey: "total_distance") ?? "0" )" ) ?? 0.0
                let payableAmount = Double( "\( rVM.rideObj.value(forKey: "amt") ?? "0" )" ) ?? 0.0
                let taxAmount = Double( "\( rVM.rideObj.value(forKey: "tax_amt") ?? "0" )" ) ?? 0.0
                let tollAmount = Double( "\( rVM.rideObj.value(forKey: "toll_tax") ?? "0" )" ) ?? 0.0
                let totalAmount = payableAmount - tollAmount - taxAmount
                
                ScrollView{
                    VStack {
                        
                        Rectangle()
                            .fill(Color.lightWhite)
                            .frame(height: 8)
                            .padding(.bottom, 10)
                        
                        HStack(spacing: 15) {
                            Rectangle()
                                .fill(Color.secondaryApp)
                                .frame(width: 10, height: 10)
                                .cornerRadius(5)
                            
                            Text(rVM.rideObj.value(forKey: "pickup_address") as?  String ?? "" )
                                .font(.customfont(.regular, fontSize: 15))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        
                        HStack(spacing: 15) {
                            Rectangle()
                                .fill(Color.primaryApp)
                                .frame(width: 10, height: 10)
                            
                            Text(rVM.rideObj.value(forKey: "drop_address") as?  String ?? "")
                                .font(.customfont(.regular, fontSize: 15))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        
                        
                        MyMapView(requestLocation: $rVM.pickupLocation, destinationLocation: $rVM.dropLocation, pickupIcon: .constant("pickup_pin"), dropIcon: .constant("drop_pin"))
                            .frame(width: .screenWidth, height: .screenWidth)
 
                        
                        HStack(alignment: .top,spacing: 8) {
                            Text("$")
                                .font(.customfont(.extraBold, fontSize: 14))
                                .foregroundColor(Color.primaryApp)
                            Text(String(format: "%.2f", payableAmount))
                                .font(.customfont(.extraBold, fontSize: 25))
                                .foregroundColor(Color.primaryApp)
                        }
                        
                        Text("Payment made successfully by \( rVM.rideObj.value(forKey: "payment_type") as? Int ?? 0 == 1 ? "cash" : "online"  )")
                            .font(.customfont(.regular, fontSize: 18))
                            .foregroundColor(Color.secondaryText)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                            .padding(.bottom, 10)
                        
                        VStack(spacing: 0) {
                            Divider()
                            
                            HStack{
                                TitleSubtitleButton(title: rVM.rideObj.value(forKey: "duration") as? String ?? "00:00", subtitle: "Time")
                                
                                Rectangle().fill(Color.lightGray)
                                    .frame(width: 1, height: 80)
                                TitleSubtitleButton(title: String(format: "%.2f KM", distance), subtitle: "Distance")
                            }
                            
                            Divider()
                        }
                        .padding(.bottom, 8)
                        
                        TitleSubtitleRow(title: "Data & Time", subtitle: (rVM.rideObj.value(forKey: "stop_time") as? String ?? "" ).date.statusString )
                        TitleSubtitleRow(title: "Service Type", subtitle: rVM.rideObj.value(forKey: "service_name") as? String ?? "" )
//                        TitleSubtitleRow(title: "Trip Type", subtitle: "Normal")
                        
                        Divider()
                            .padding(.horizontal, 20)
                            .padding(.bottom, 8)
                        HStack {
                            Text("You rated")
                                .font(.customfont(.regular, fontSize: 15))
                                .foregroundColor(Color.secondaryText)
                            
                            Text("\"\( rVM.rideObj.value(forKey: "name") as? String ?? "" )\"")
                                .font(.customfont(.semiBold, fontSize: 15))
                                .foregroundColor(Color.primaryText)
                            
                            WebImage(url: URL(string:  rVM.rideObj.value(forKey: "image") as? String ?? "" ))
                                    
                                .resizable()
                                .indicator(.activity)
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .cornerRadius(12.5)
                            
                           
                            
                            HStack(spacing: 0) {
                                ForEach(1...5, id: \.self) { i in
                                    Image(systemName: "star.fill")
                                        .foregroundColor( i <= (  Int( "\(rVM.rideObj.value(forKey: ServiceCall.userType == 1 ? "driver_rating" : "user_rating" ) ?? "0.0")"  ) ?? 1 ) ? Color.primaryApp : Color.lightGray )
                                }
                            }
                        }
                        .padding(.bottom, 15)
                    }
                    
                    VStack {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.lightWhite)
                                .frame(height: 20)
                            
                            Text("RECEIPT")
                                .font(.customfont(.extraBold, fontSize: 15))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 8)
                                .background(Color.lightWhite)
                            
                        }
                        .padding(.bottom, 8)
                        
                        TitleSubtitleRow(title: "Trip fares", subtitle: String(format: "$%.2f", totalAmount), color: .secondaryText)
//                        TitleSubtitleRow(title: "Taxi Fee", subtitle: "$20.00", color: .secondaryText)
                        TitleSubtitleRow(title: "+ Tax", subtitle: String(format: "$%.2f", taxAmount), color: .secondaryText)
                        TitleSubtitleRow(title: "+ Tolls", subtitle: String(format: "$%.2f", tollAmount), color: .secondaryText)
//                        TitleSubtitleRow(title: "Discount", subtitle: "$40.25", color: .secondaryText)
//                        TitleSubtitleRow(title: "+ Topup Added", subtitle: "$20.75", color: .secondaryText)
                            .padding(.bottom, 4)
                        
                        Divider()
                        
                        TitleSubtitleRow(title: "You payment", subtitle: String(format: "$%.2f", payableAmount), color: .primaryApp, fontWeight: .semiBold)
                            .padding(.bottom, 8)
                        
                        
                        Text("This trip was towards your destination you received\nGuaranteed fare")
                            .font(.customfont(.regular, fontSize: 12))
                            .foregroundColor(Color.secondaryText)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, .bottomInsets)
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
    TripDetailsView()
}
