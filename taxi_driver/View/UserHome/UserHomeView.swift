//
//  UserHomeView.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/01/24.
//

import SwiftUI
import MapKit


struct UserHomeView: View {
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @State private var isOpen = false
    
    @State private var isSelectPickup = true
    @State private var isCarService = true
    
    @State private var serviceList = [
        [
            "icon":"car_1",
            "name":"Economy",
            "price":"$10-$20"
        ],
        
        [
            "icon":"car_1",
            "name":"Luxury",
            "price":"$13-$23"
        ],
        
        [
            "icon":"car_1",
            "name":"First Class",
            "price":"$25-$30"
        ],
    ]
    
    @State var selectServiceIndex = 0
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack(spacing: 0){
                    
                    Spacer()
                        .frame(width: 60, alignment: .center)
                    
                    Spacer()
                    
                    HStack{
                        Text("$")
                            .font(.customfont(.extraBold, fontSize: 14))
                            .foregroundColor(Color.secondaryApp)
                        
                        Text("157.57")
                            .font(.customfont(.extraBold, fontSize: 25))
                            .foregroundColor(Color.primaryText)
                    }
                    
                    .frame(width: 140, alignment: .center)
                    .padding(8)
                    .background(Color.white)
                    
                    .cornerRadius(35)
                    .shadow(radius: 3, x:0, y:-1)
                    
                    Spacer()
                    
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        ZStack(alignment: .bottomLeading) {
                            
                            Image("u1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                                .overlay( RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 1.5 ))
                                .cornerRadius(20)
                                .clipped()
                            
                            Text("3")
                                .font(.customfont(.regular, fontSize: 10))
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 5)
                                .background(Color.red)
                                .cornerRadius(20)
                                .overlay( RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 1.5 ))
                        }
                        .frame(width: 60)
                    }

                   
                    
                    
                    
                }
                .padding(.horizontal , 15)
                .padding(.top, .topInsets )
                
                Spacer()
                
                
                HStack {
                    
                   

                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image("current_location")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                    })
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                
                VStack(alignment:.leading){
                    Text("Pickup")
                        .font(.customfont(.extraBold, fontSize: 18))
                        .foregroundColor(Color.primaryApp)
                    
                    Button {
                        
                        isSelectPickup = true
                        
                    } label: {
                        HStack(spacing: 15){
                                
                            RoundedRectangle(cornerRadius: 10)
                                .fill( Color.primaryApp )
                                .frame(width: 20, height: 20)
                            
                            Text("Select Pickup Location")
                                .font(.customfont(.regular, fontSize: 17))
                               
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "arrow.forward")
                                
                        }
                    }
                    .foregroundColor(Color.placeholder)
                    .padding(15)
                    .background( Color.white )
                    .cornerRadius( 10 )
                    .shadow(color: isSelectPickup  ? Color.primaryApp : Color.black.opacity(0.2) , radius: 2 )
                    .padding(.bottom, 15)
                    
                    Text("Drop Off")
                        .font(.customfont(.extraBold, fontSize: 18))
                        .foregroundColor(Color.redApp)
                    
                    Button {
                        
                        isSelectPickup = false
                        
                    } label: {
                        HStack(spacing: 15){
                                
                            RoundedRectangle(cornerRadius: 10)
                                .fill( Color.redApp )
                                .frame(width: 20, height: 20)
                            
                            Text("Select Pickup Location")
                                .font(.customfont(.regular, fontSize: 17))
                               
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "arrow.forward")
                                
                        }
                    }
                    .foregroundColor(Color.placeholder)
                    .padding(15)
                    .background( Color.white )
                    .cornerRadius( 10 )
                    .shadow(color: !isSelectPickup  ? Color.redApp : Color.black.opacity(0.2) , radius: 2 )
                    .padding(.bottom, 25)

                    
                    
                    NavigationLink {
                    } label: {
                        Text("CONTINUE")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                    .background( Color.primaryApp )
                    .cornerRadius(25)
                    .padding(.bottom, 15)
                    
                        
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20, corner: [.topLeft, .topRight])
                .shadow(radius: 3, x:0, y:-3)
                
            }
        }
        .fullScreenCover(isPresented: $isCarService, content: {
            
                
            VStack{
                
                Spacer()
                VStack{
                    Text("Select Car Service")
                        .font(.customfont(.extraBold, fontSize: 18))
                        .foregroundColor(Color.primaryText)
                        .padding(20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        LazyHStack (spacing: 15) {
                            
                            ForEach( 0 ..< serviceList.count , id: \.self) { index in
                                
                                let cObj = serviceList[index]
                                
                                Button {
                                    selectServiceIndex = index
                                } label: {
                                    ZStack(alignment: .leading) {
                                        
                                        VStack {
                                            Text(cObj["name"] as? String ?? "")
                                                .font(.customfont(.semiBold, fontSize: 17))
                                                .foregroundColor( Color.primaryText )
                                            
                                            Text(cObj["price"] as? String ?? "")
                                                .font(.customfont(.semiBold, fontSize: 17))
                                                .foregroundColor( Color.primaryApp )
                                        }
                                        .padding(.leading, 50)
                                        .padding(20)
                                        .frame(width: 200, height: 120, alignment: .leading)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .shadow( color: selectServiceIndex == index ? Color.primaryApp : Color.black.opacity(0.2) , radius: 2)
                                        .padding(.leading, 70)
                                        
                                        
                                        Image( cObj["icon"] as? String ?? "" )
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 130,  height: 100 )
                                        
                                    }
                                    
                                }

                                
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    .frame(height: 160, alignment: .leading)
                    
                    
                    NavigationLink {
                    } label: {
                        Text("Send Request")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                    .background( Color.primaryApp )
                    .cornerRadius(25)
                    .padding(.bottom, 15)
                    .padding(20)
                }
                
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20, corner: [.topLeft, .topRight])
                .shadow(radius: 3, x: 0, y: -3)
            }
            .background(BackgroundCleanerView())
            .ignoresSafeArea()
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
        
        
    }
}

#Preview {
    UserHomeView()
}

