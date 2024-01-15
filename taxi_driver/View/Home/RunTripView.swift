//
//  RunTripView.swift
//  taxi_driver
//
//  Created by CodeForAny on 09/10/23.
//

import SwiftUI
import MapKit

struct RunTripView: View {
    @State var pickupLocation = CLLocationCoordinate2D(latitude: 42.6619, longitude: 21.1501)
    @State var dropLocation = CLLocationCoordinate2D(latitude: 42.6619, longitude: 21.1701)
    @State var isOpen = true
    @State var showCancel = false
    @State var showCancelReason = false 
    @State var rideStatus: Int = 0
    
    @State var rateUser: Int = 4
    @State var showToll = false
    @State var txtToll = ""
    
    var body: some View {
        ZStack{
            
            MyMapView(requestLocation: $pickupLocation, destinationLocation: $dropLocation)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack {
                    Spacer()
                    
                    HStack{
                        Image("pickup_pin_1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        Text ("1 Ash Park, Pembroke Dock, SA7254, Drury Lane, Oldham, OL9 7PH")
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
                
                if(rideStatus == 1 || rideStatus == 2) {
                    
               
                HStack {
                    Spacer()
                    
                    VStack {
                        Text("01:59")
                            .font(.customfont(.extraBold, fontSize: 25))
                            .foregroundColor(.secondaryApp)
                        
                        Text( rideStatus == 1 ?  "Waiting for rider" : "Arrived at dropoff")
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
                                        .foregroundColor( i <= rateUser ? Color.orange : Color.lightGray )
                                        .onTapGesture {
                                            rateUser = i
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
                                    isOpen.toggle()
                                }
                            }, label: {
                                Image( !isOpen ? "open_btn" : "close_btn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                            })
                            
                            VStack( spacing: 8) {
                                Spacer()
                                    .frame(height: 10)
                                
                                HStack{
                                    Text("25 Min")
                                        .font(.customfont(.extraBold, fontSize: 18))
                                        .foregroundColor(Color.primaryText)
                                    
                                    Image(  "ride_user_profile")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:30)
                                    
                                    Text("0.5 mi")
                                        .font(.customfont(.extraBold, fontSize: 18))
                                        .foregroundColor(Color.primaryText)
                                }
                                
                                Text("Picking uo James smith")
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
                        
                        if(isOpen) {
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
                                    showCancel = true
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
                            if(rideStatus == 2) {
                                showToll = true
                            }else{
                                rideStatus += 1
                            }
                            
                        } label: {
                            Text( rideStatus == 0 ? "ARRIVED" : rideStatus == 1 ? "START" : rideStatus == 2 ? "COMPLETE" : "" )
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
        .fullScreenCover(isPresented: $showCancel, content: {
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
                            self.showCancelReason = true
                            self.showCancel = false
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
                            self.showCancel = false
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
        .fullScreenCover(isPresented: $showToll, content: {
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
                            
                            TextField("", text: $txtToll)
                        }
                        
                        Divider()
                        
                        HStack(spacing: 20) {
                            Spacer()
                            Button {
                                self.rideStatus = 3
                                self.showToll = false
                            } label: {
                                Text("CANCEL")
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(Color.primaryApp)
                            }
                            
                            Button {
                                self.rideStatus = 3
                                self.showToll = false
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
        .fullScreenCover(isPresented: $showCancelReason, content: {
            ReasonView()
                .background(Color.white)
                .ignoresSafeArea()
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    RunTripView()
}
