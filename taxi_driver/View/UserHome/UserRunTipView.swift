//
//  UserRunTipView.swift
//  taxi_driver
//
//  Created by CodeForAny on 12/04/24.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI


struct UserRunTipView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var rVM = UserRunRideViewModel.shared
    @StateObject var sVM = SupportViewModel.shared
    
    var body: some View {
        ZStack{
            MyMapView(requestLocation: $rVM.pickupLocation, destinationLocation: $rVM.dropLocation, pickupIcon: $rVM.pickUpPinIcon, dropIcon: $rVM.dropPinIcon)
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                HStack {
                    Spacer()
                    
                    HStack{
                        Image(rVM.displayAddressIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Text (rVM.displayAddress)
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(35)
                    .shadow(radius: 3, y:-1)
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 8)
                
                Spacer()
                
                let rideStatusId = rVM.rideObj.value(forKey: "booking_status") as? Int ?? 0
                
                if(rideStatusId == BStatus.bsWaitUser || rideStatusId == BStatus.bsStart) {
                    
               
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("01:59")
                            .font(.customfont(.extraBold, fontSize: 25))
                            .foregroundColor(.secondaryApp)
                        
                        Text( rideStatusId == BStatus.bsWaitUser ?  "Waiting for rider" : "Arrived at dropoff")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.secondaryText)
                        
                    }
                    .padding(15)
                    .frame(minWidth: 140, minHeight: 80, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(50)
                    .shadow(radius: 2, y:2)
                }
                .padding(15)
                }
                
                VStack{
                    
                    if(rideStatusId == BStatus.bsComplete) {
                        VStack {
                            Text("How was your rider?")
                                .font(.customfont(.regular, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 15)
                            
                            Text("\( rVM.rideObj.value(forKey: "name") as? String ?? "" )")
                                .font(.customfont(.extraBold, fontSize: 25))
                                .foregroundColor(.primaryText)
                                .frame(maxWidth: .infinity, alignment: .center)
                                
                            HStack(spacing: 15) {
                                ForEach(1...5, id: \.self) { i in
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor( i <= rVM.rateUser ? Color.orange : Color.lightGray )
                                        .onTapGesture {
                                            rVM.rateUser = i
                                        }
                                        
                                }
                            }
                            .padding(.vertical, 20)
                            
                            Button {
                                rVM.actionRating()
                            } label: {
                                Text( "RATE RIDER" )
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(Color.white)
                            }
                            .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                            .background( Color.primaryApp )
                            .cornerRadius(25)
                            .padding(.horizontal, 20)
                            
                        }
                       
                        
                    }else{
                        HStack {
                            Button(action: {
                                withAnimation {
                                    rVM.isOpen.toggle()
                                }
                            }, label: {
                                Image( !rVM.isOpen ? "open_btn" : "close_btn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                            })
                            
                            VStack( spacing: 8) {
                                Spacer()
                                    .frame(height: 10)
                                
                                HStack{
                                    Text("\( rVM.estDuration, specifier: "%.0f" ) Min")
                                        .font(.customfont(.extraBold, fontSize: 18))
                                        .foregroundColor(Color.primaryText)
                                    
                                    WebImage(url: URL(string: rVM.rideObj.value(forKey: "image") as? String ?? "" ))
                                        .resizable()
                                        .indicator(.activity)
                                        .scaledToFit()
                                        .frame(width:30)
                                        .cornerRadius(15)
                                    
                                    Text("\( rVM.estDistance, specifier: "%.0f" ) KM")
                                        .font(.customfont(.extraBold, fontSize: 18))
                                        .foregroundColor(Color.primaryText)
                                }
                                
                                Text(rVM.rideStatusName)
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(Color.secondaryText)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            Button(action: {
                              
                            }, label: {
                                Image(  "call")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:30)
                            })
                        }
                        .padding(.horizontal, 20)
                        
                        if(rVM.isOpen) {
                                
                            Divider()
                            HStack(spacing: 15){
                                
                                WebImage(url: URL(string: rVM.rideObj.value(forKey: "image") as? String ?? "" ))
                                    .resizable()
                                    .indicator(.activity)
                                    .scaledToFit()
                                    .frame(width:50, height: 50)
                                    .cornerRadius(25)
                                
                                VStack{
                                    
                                    HStack{
                                        Text(rVM.rideObj.value(forKey: "name") as? String ?? "" )
                                            .font(.customfont(.bold, fontSize: 16))
                                            .foregroundColor(Color.primaryText)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        
                                        Text(rVM.rideStatusText )
                                            .font(.customfont(.bold, fontSize: 17))
                                            .foregroundColor( rVM.rideStatusColor )
                                    }
                                    
                                    
                                    HStack{
                                        Text( "\( rVM.rideObj.value(forKey: "mobile_code") as? String ?? "" ) \(rVM.rideObj.value(forKey: "mobile") as? String ?? "")"  )
                                            .font(.customfont(.regular, fontSize: 14))
                                            .foregroundColor(Color.secondaryText)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        
                                        Text(rVM.rideObj.value(forKey: "payment_type") as? Int ?? 0 == 1 ? "COD" : "Online" )
                                            .font(.customfont(.bold, fontSize: 17))
                                            .foregroundColor( .secondaryText)
                                    }
                                    
                                }
                                
                            }
                            .padding(.horizontal, 20)
                            
                            Divider()
                            HStack(spacing: 15){
                                
                                WebImage(url: URL(string: rVM.rideObj.value(forKey: "icon") as? String ?? "" ))
                                    .resizable()
                                    .indicator(.activity)
                                    .scaledToFit()
                                    .frame(width:50, height: 50)
                                    .cornerRadius(25)
                                
                                VStack{
                                    
                                    Text("\( rVM.rideObj.value(forKey: "brand_name") as? String ?? "" ) - \(rVM.rideObj.value(forKey: "model_name") as? String ?? "") - \(rVM.rideObj.value(forKey: "series_name") as? String ?? "")"  )
                                        .font(.customfont(.regular, fontSize: 14))
                                        .foregroundColor(Color.primaryText)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack{
                                       
                                        Text( "No Plat: \( rVM.rideObj.value(forKey: "car_number") as? String ?? "" )"  )
                                            .font(.customfont(.regular, fontSize: 14))
                                            .foregroundColor(Color.secondaryText)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        if(rideStatusId == BStatus.bsWaitUser) {
                                            Text("OTP: \( rVM.rideObj.value(forKey: "otp_code") as? String ?? "" )" )
                                                .font(.customfont(.bold, fontSize: 14))
                                                .foregroundColor( Color.secondaryText )
                                        }
                                        
                                    }
                                }
                                
                            }
                            .padding(.horizontal, 20)
                            
                            Divider()
                            
                            HStack(spacing:0){
                                
                                Button {
                                    sVM.selectSupportUser = SupportUserModel(uObj: [
                                        "user_id": Int("\( rVM.rideObj.value(forKey: "driver_id") ?? "" )") ?? 0,
                                        "name":  rVM.rideObj.value(forKey: "name") ?? "",
                                        "image": rVM.rideObj.value(forKey: "image") ?? ""
                                    ])
                                } label: {
                                    VStack(spacing: 0){
                                        Image("chat")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 45)
                                        
                                        Text("Chat")
                                            .font(.customfont(.regular, fontSize: 18))
                                            .foregroundColor(Color.secondaryText)
                                            
                                    }
                                }

                               
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                                
                                VStack(spacing: 0){
                                    Image("message")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45)
                                    
                                    Text("Message")
                                        .font(.customfont(.regular, fontSize: 18))
                                        .foregroundColor(Color.secondaryText)
                                        
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                                
                                Button {
                                    rVM.showCancel = true
                                } label: {
                                    VStack(spacing: 0){
                                        Image("cancel_trip")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 45)
                                        
                                        Text("Cancel Trip")
                                            .font(.customfont(.regular, fontSize: 18))
                                            .foregroundColor(Color.secondaryText)
                                            
                                    }
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                                
                                    
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                        }
                        
                    }
                    
                }
                .padding(.bottom, .bottomInsets + 8)
                .background(Color.white)
                .cornerRadius(20, corner: [.topLeft, .topRight])
                .shadow(radius: 3, y: -3)
                
            }
        }
        .fullScreenCover(isPresented: $rVM.showCancel, content: {
            ZStack {
                
                VisualEffectView(blurRadius: 15)
                    .ignoresSafeArea()
                    .offset(y: -3)
                
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        Text("Cancel \(rVM.rideObj.value(forKey: "name") ?? "")'s trip?")
                            .font(.customfont(.extraBold, fontSize: 18))
                            .foregroundColor(Color.primaryText)
                            .padding(.top, 15)
                        
                        Divider()
                        
                        Button {
                            rVM.actionDriverRideCancel()
                        } label: {
                            Text("YES, CANCEL")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                        .background( Color.redApp )
                        .cornerRadius(25)
                        .padding(.horizontal, 20)
                        .padding(.top)
                        
                        Button {
                            rVM.showCancel = false
                        } label: {
                            Text("NO")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.secondaryText,lineWidth: 1))
                        .cornerRadius(25)
                        .padding(.horizontal, 20)
                        .padding(.bottom, .bottomInsets)
                    }
                    .background(Color.white )
                    .cornerRadius(10, corner: [.topLeft, .topRight])
                    .shadow(radius: 2, y: -3)
                }
            }
            .alert(isPresented: $rVM.showError){
                Alert(title: Text(Globs.AppName), message: Text(rVM.errorMessage), dismissButton: .default(Text("Ok")) {
                    if(rVM.isAlertOkBack) {
                        rVM.isAlertOkBack = false
                        rVM.showRunningRide = false
                    }
                } )
            }
            .background(BackgroundCleanerView())
        })
        .fullScreenCover(isPresented: $rVM.showRideComplete, content: {
            ZStack {
                
                VisualEffectView(blurRadius: 15)
                    .ignoresSafeArea()
                    .offset(y: -3)
                
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        Text("Ride Completed")
                            .font(.customfont(.extraBold, fontSize: 18))
                            .foregroundColor(Color.primaryText)
                            .padding(.top, 15)
                        
                        Divider()
                        let distance = Double("\(rVM.rideObj.value(forKey: "total_distance") ?? "0" )") ?? 0.0
                        let payableAmount = Double("\(rVM.rideObj.value(forKey: "amt") ?? "0" )") ?? 0.0
                        let tollAmount = Double("\(rVM.rideObj.value(forKey: "toll_tax") ?? "0" )") ?? 0.0
                        let taxAmount = Double("\(rVM.rideObj.value(forKey: "tax_amt") ?? "0" )") ?? 0.0
                        let totalAmount = payableAmount - tollAmount - taxAmount
                        
                        HStack{
                            Text("Payment Model:")
                                .font(.customfont(.regular, fontSize: 18))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(rVM.rideObj.value(forKey: "payment_type") as? Int ?? 0 == 1 ? "COD" : "ONLINE" )
                                .font(.customfont(.extraBold, fontSize: 18))
                                .foregroundColor(Color.primaryApp)
                        }
                        .padding(.bottom, 15)
                        
                        
                        HStack{
                            Text("Total Distance:")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("\(distance, specifier: "%.2f") KM" )
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                        }

                        
                        HStack{
                            Text("Total Duration:")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(rVM.rideObj.value(forKey: "duration") as?  String ?? "00:00" )
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                        }
                            
                        Divider()
                        
                        HStack{
                            Text("Total Amount:")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("$\(totalAmount, specifier: "%.2f")" )
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                        }
                        
                        HStack{
                            Text("Tax Amount:")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("+$\(taxAmount, specifier: "%.2f")" )
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                        }
                        
                        HStack{
                            Text("Toll Tax Amount:")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("+$\(tollAmount, specifier: "%.2f")" )
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                        }
                        
                        HStack{
                            Spacer()
                            
                            Rectangle()
                                .fill(Color.primaryText)
                                .frame(width: 120, height: 2)
                        }
                        
                        HStack{
                            Text("Payable Amount:")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("+$\(payableAmount, specifier: "%.2f")" )
                                .font(.customfont(.extraBold, fontSize: 18))
                                .foregroundColor(Color.primaryText)
                        }
                        
                        Button {
                            rVM.showRideComplete = false
                        } label: {
                            Text("YES, Accept Toll Tax")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                        .background( Color.redApp )
                        .cornerRadius(25)
                        
                        .padding(.vertical)
                        
                        Button {
                            rVM.showRideComplete = false
                        } label: {
                            Text("NO")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.primaryTextW)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                        .background(Color.primaryApp)
                        .cornerRadius(25)
                        .padding(.bottom, .bottomInsets)
                    }
                    .padding(.horizontal, 20)
                    .background(Color.white )
                    .cornerRadius(10, corner: [.topLeft, .topRight])
                    .shadow(radius: 2, y: -3)
                }
                
            }
            .background(BackgroundCleanerView())
        })
        .background( NavigationLink(destination: SupportMessageView(), isActive: $sVM.showMessage,  label: {
            EmptyView()
        }) )
        .alert(isPresented: $rVM.showError){
            Alert(title: Text(Globs.AppName), message: Text(rVM.errorMessage), dismissButton: .default(Text("Ok")) {
                if(rVM.isAlertOkBack) {
                    rVM.isAlertOkBack = false
                    rVM.showRunningRide = false
                }
            } )
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    RunTripView()
}

