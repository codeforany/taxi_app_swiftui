//
//  RunTripView.swift
//  taxi_driver
//
//  Created by CodeForAny on 09/10/23.
//

import SwiftUI
import MapKit

struct RunTripView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var rVM = DriverRunRideViewModel.shared
    
    @State var rideStatus: Int = 0
    
    
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
                    
                    if(rideStatus == 3) {
                        VStack {
                            Text("How was your rider?")
                                .font(.customfont(.regular, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 15)
                            
                            Text("Rockdean")
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
                                    
                                    Image(  "ride_user_profile")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:30)
                                    
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
                            
                            HStack(spacing:0){
                                VStack(spacing: 0){
                                    Image("chat")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45)
                                    
                                    Text("Chat")
                                        .font(.customfont(.regular, fontSize: 18))
                                        .foregroundColor(Color.secondaryText)
                                        
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
                        
                        
                     
                        
                        Button {
                            rVM.actionStatusChange()
                            
                        } label: {
                            Text( rVM.btnName )
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                        .background( Color.primaryApp )
                        .cornerRadius(25)
                        .padding(.horizontal, 20)
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
                        Text("Cancel Rickdean's trip?")
                            .font(.customfont(.extraBold, fontSize: 18))
                            .foregroundColor(Color.primaryText)
                            .padding(.top, 15)
                        
                        Divider()
                        
                        Button {
                            rVM.showCancelReason = true
                            rVM.showCancel = false
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
            
            .background(BackgroundCleanerView())
        })
        .fullScreenCover(isPresented: $rVM.showToll, content: {
            ZStack {
                
                VisualEffectView(blurRadius: 15)
                    .ignoresSafeArea()
                    .offset(y: -3)
                
                VStack {
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Enter Toll Amount")
                            .font(.customfont(.extraBold, fontSize: 18))
                            .foregroundColor(Color.primaryText)
                        
                        Text("Please enter toll amount")
                            .font(.customfont(.regular, fontSize: 14))
                            .foregroundColor(Color.secondaryText)
                            .padding(.top, 1)
                        
                        HStack{
                            Text("$")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.primaryText)
                            
                            TextField("", text: $rVM.txtToll)
                        }
                        
                        Divider()
                        
                        HStack(spacing: 20) {
                            Spacer()
                            Button {
                                self.rideStatus = 3
                                rVM.showToll = false
                            } label: {
                                Text("CANCEL")
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(Color.primaryApp)
                            }
                            
                            Button {
                                rideStatus = 3
                                rVM.showToll = false
                            } label: {
                                Text("DONE")
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(Color.primaryApp)
                            }
                            
                        }
                        
                    }
                    .padding(20)
                    .background(Color.white )
                    .cornerRadius(10)
                    .shadow(radius: 2, y: -3)
                    .padding(15)
                    
                    Spacer()
                }
            }
            
            .background(BackgroundCleanerView())
            .ignoresSafeArea()
        })
        .fullScreenCover(isPresented: $rVM.showCancelReason, content: {
            ReasonView()
                .background(Color.white)
                .ignoresSafeArea()
        })
        .alert(isPresented: $rVM.showError){
            Alert(title: Text(Globs.AppName), message: Text(rVM.errorMessage), dismissButton: .default(Text("Ok")) {
                
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
