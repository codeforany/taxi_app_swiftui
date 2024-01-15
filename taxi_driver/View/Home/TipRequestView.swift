//
//  TipRequestView.swift
//  taxi_driver
//
//  Created by CodeForAny on 08/10/23.
//

import SwiftUI
import MapKit

struct TipRequestView: View {
    
    
    @State var pickupLocation = CLLocationCoordinate2D(latitude: 42.6619, longitude: 21.1501)
    @State var dropLocation = CLLocationCoordinate2D(latitude: 42.6619, longitude: 21.1701)
    
    var body: some View {
        ZStack{
            
            MyMapView(requestLocation: $pickupLocation, destinationLocation: $dropLocation)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack{
                
                HStack {
                    Spacer()
                    
                    HStack{
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        
                        Text ("No Thanks")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.primaryText)
                        
                    }
                    .frame(width: 120, alignment: .center)
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(35)
                    .shadow(radius: 3, y:-1)
                    Spacer()
                }
                .padding(.top, .topInsets)
                
                Spacer()
                
                VStack{
                    
                    Text("25 Min")
                        .font(.customfont(.extraBold, fontSize: 25))
                        .foregroundColor(Color.primaryText)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .padding(.top, 15)
                    
                    HStack(spacing:0){
                        Text("$12.50")
                            .font(.customfont(.regular, fontSize: 18))
                            .foregroundColor(Color.secondaryText)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                        
                        Text("4.5 km")
                            .font(.customfont(.regular, fontSize: 18))
                            .foregroundColor(Color.secondaryText)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                        
                        HStack{
                            Image("rate_tip")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text("3.5")
                                .font(.customfont(.regular, fontSize: 18))
                                .foregroundColor(Color.secondaryText)
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                        
                            
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    HStack(spacing: 15) {
                        Rectangle()
                            .fill(Color.secondaryApp)
                            .frame(width: 10, height: 10)
                            .cornerRadius(5)
                        
                        Text("1 Ash Park, Pembroke Dock, SA72")
                            .font(.customfont(.regular, fontSize: 15))
                            .foregroundColor(Color.primaryText)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    
                    HStack(spacing: 15) {
                        Rectangle()
                            .fill(Color.primaryApp)
                            .frame(width: 10, height: 10)
                        
                        Text("54 Hollybank Rd, Southampton")
                            .font(.customfont(.regular, fontSize: 15))
                            .foregroundColor(Color.primaryText)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    
                    NavigationLink {
                        
                    } label: {
                        ZStack{
                            Text("TAP TO ACCEPT")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.white)
                            
                            HStack{
                                Text("15")
                                    .font(.customfont(.regular, fontSize: 14))
                                    .foregroundColor(Color.white)
                                    .frame(width: 36, height: 36, alignment: .center)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(25)
                                    .padding(8)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                           
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                    .background( Color.primaryApp )
                    .cornerRadius(25)
                    .padding(.horizontal, 20)
                    
                }
                .padding(.bottom, .bottomInsets + 8)
                .background(Color.white)
                .cornerRadius(20, corner: [.topLeft, .topRight])
                .shadow(radius: 3, y: -3)
                
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    TipRequestView()
}
