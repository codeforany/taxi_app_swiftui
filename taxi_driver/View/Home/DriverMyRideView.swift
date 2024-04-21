//
//  DriverMyRideView.swift
//  taxi_driver
//
//  Created by CodeForAny on 15/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct DriverMyRideView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var hVM = MyRideViewModel.shared
    @State var showDetail = false
    
    var body: some View {
        ZStack{
            VStack{
                
                ZStack{
                    
                    Text("My Rides")
                        .font(.customfont(.bold, fontSize: 17))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack{
                        
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }, label: {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            
                            Text("$\(hVM.driverAmount, specifier: "%.2f")")
                                .font(.customfont(.bold, fontSize: 17))
                                .foregroundColor(.primaryApp)
                        })
                    }
                    
                }
                .padding(.bottom, 8)
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(radius: 2)
                
                
                ScrollView{
                    LazyVStack(spacing: 15) {
                            
                        ForEach(0 ..< hVM.myRideArr.count, id:\.self) {
                            index in
                            
                            let rideObj = hVM.myRideArr[index]
                            
                            Button {
                                TipDetailViewModel.shared.loadRide(obj: rideObj)
                                showDetail = true
                            } label: {
                                
                                VStack{
                                    
                                    HStack(spacing: 15){
                                        
                                        WebImage(url: URL(string: rideObj.value(forKey: "icon") as? String ?? "" ))
                                            .resizable()
                                            .indicator(.activity)
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        
                                        VStack{
                                            
                                            HStack{
                                                
                                                Text( rideObj.value(forKey: "service_name") as? String ?? "")
                                                    .font(.customfont(.bold, fontSize: 17))
                                                    .foregroundColor(Color.primaryText)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                Text( hVM.statusText(rideObj: rideObj))
                                                    .font(.customfont(.bold, fontSize: 17))
                                                    .foregroundColor(hVM.statusColor(rideObj: rideObj))
                                                
                                            }
                                            
                                            Text( hVM.statusWiseDateTime(rideObj: rideObj))
                                                .font(.customfont(.regular, fontSize: 12))
                                                .foregroundColor(Color.secondaryText)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    }
                                    
                                    
                                    HStack(spacing: 15){
                                        
                                        Rectangle()
                                            .fill(Color.secondaryApp)
                                            .frame(width: 8, height: 8)
                                            .cornerRadius(4)
                                        
                                        Text( rideObj.value(forKey: "pickup_address") as? String ?? "")
                                            .font(.customfont(.regular, fontSize: 15))
                                            .foregroundColor(Color.primaryText)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    }
                                    
                                    let rideStatusId = rideObj.value(forKey: "booking_status") as? Int ?? 0
                                    
                                    if( rideStatusId >= BStatus.bsStart ) {
                                        HStack(spacing: 15){
                                            
                                            Rectangle()
                                                .fill(Color.primaryApp)
                                                .frame(width: 8, height: 8)
                                                .cornerRadius(4)
                                            
                                            Text( rideObj.value(forKey: "drop_address") as? String ?? "")
                                                .font(.customfont(.regular, fontSize: 15))
                                                .foregroundColor(Color.primaryText)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        }
                                    }
                                    
                                    
                                    if(rideStatusId == BStatus.bsComplete) {
                                        
                                        Divider()
                                        
                                        let km = Double("\( rideObj.value(forKey: "total_distance") ?? "0.0" )") ?? 0.0
                                        let rideTotalAmount = Double("\( rideObj.value(forKey: "amount") ?? "0.0" )") ?? 0.0
                                        let driverAmount = Double("\( rideObj.value(forKey: "driver_amt") ?? "0.0" )") ?? 0.0
                                        
                                        HStack(spacing: 8) {
                                            
                                            Text("Distance:")
                                                .font(.customfont(.bold, fontSize: 15))
                                                .foregroundColor(.primaryText)
                                            
                                            Text("\(km, specifier: "%.2f")KM")
                                                .font(.customfont(.regular, fontSize: 15))
                                                .foregroundColor(.primaryText)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            
                                            
                                            Text("Duration:")
                                                .font(.customfont(.bold, fontSize: 15))
                                                .foregroundColor(.primaryText)
                                            
                                            Text(rideObj.value(forKey: "duration") as? String ?? "00:00" )
                                                .font(.customfont(.regular, fontSize: 15))
                                                .foregroundColor(.primaryText)
                                            
                                        }
                                        .padding(.bottom, 8)
                                        
                                        HStack(spacing: 8) {
                                            
                                            Text("Driver Amount:")
                                                .font(.customfont(.bold, fontSize: 15))
                                                .foregroundColor(.primaryText)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Text("$\(driverAmount, specifier: "%.2f")")
                                                .font(.customfont(.bold, fontSize: 17))
                                                .foregroundColor(.secondaryApp)
                                            
                                            
                                        }
                                        
                                        HStack(spacing: 8) {
                                            
                                            Text("Total Amount:")
                                                .font(.customfont(.bold, fontSize: 15))
                                                .foregroundColor(.primaryText)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            Text("$\(rideTotalAmount, specifier: "%.2f")")
                                                .font(.customfont(.bold, fontSize: 17))
                                                .foregroundColor(.secondaryApp)
                                            
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                                }
                            }
                            
                        }
                        .padding(15)
                        .background( Color.white )
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        
                        
                    }
                    .padding(20)
                }
                
            }
        }
        .onAppear(){
            hVM.apiDriverRideAll()
        }
        .background( NavigationLink(destination: TripDetailsView(), isActive: $showDetail, label: {
            EmptyView()
        }) )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    DriverMyRideView()
}
