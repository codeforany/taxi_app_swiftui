//
//  UserHomeView.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/01/24.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI


struct UserHomeView: View {
    
    @StateObject var uVM = UserHomeViewModel.shared
    @StateObject var rVM = UserRunRideViewModel.shared
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $uVM.region, annotationItems: uVM.pinArr, annotationContent: { pinObj in
                
                MapAnnotation(coordinate: pinObj.location) {
                    Image(pinObj.isPickup ? "pickup_pin" : "drop_pin" )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .offset(y: -13)
                    
                }
                
            })
            .edgesIgnoringSafeArea(.all)
            .onChange(of: uVM.selectReion, perform: { value in
                
                uVM.getAddressForLatLong(location: value.center, isPickup: uVM.isSelectPickup)
                
            })
         
            VStack{
                
                Image(uVM.isSelectPickup ? "pickup_pin" : "drop_pin" )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
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
                        .foregroundColor(Color.secondaryApp)
                    
                    Button {
                        withAnimation {
                            uVM.showMapLocation(isPickup: true)
                        }
                       
                        
                    } label: {
                        HStack(spacing: 15){
                                
                            RoundedRectangle(cornerRadius: 10)
                                .fill( Color.secondaryApp )
                                .frame(width: 20, height: 20)
                            
                            Text( uVM.selectPickupAddress == "" ? "Select Pickup Location" :  uVM.selectPickupAddress)
                                .lineLimit(1)
                                .font(.customfont(.regular, fontSize: 17))
                               
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "arrow.forward")
                                
                        }
                    }
                    .foregroundColor(Color.placeholder)
                    .padding(15)
                    .background( Color.white )
                    .cornerRadius( 10 )
                    .shadow(color: uVM.isSelectPickup  ? Color.secondaryApp : Color.black.opacity(0.2) , radius: 2 )
                    .padding(.bottom, 15)
                    
                    Text("Drop Off")
                        .font(.customfont(.extraBold, fontSize: 18))
                        .foregroundColor(Color.primaryApp)
                    
                    Button {
                        withAnimation {
                            uVM.showMapLocation(isPickup: false)
                        }
                        
                    } label: {
                        HStack(spacing: 15){
                                
                            RoundedRectangle(cornerRadius: 10)
                                .fill( Color.primaryApp )
                                .frame(width: 20, height: 20)
                            
                            Text( uVM.selectDropOffAddress == "" ? "Select DropOff Location" : uVM.selectDropOffAddress )
                                .lineLimit(1)
                                .font(.customfont(.regular, fontSize: 17))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(systemName: "arrow.forward")
                                
                        }
                    }
                    .foregroundColor(Color.placeholder)
                    .padding(15)
                    .background( Color.white )
                    .cornerRadius( 10 )
                    .shadow(color: !uVM.isSelectPickup  ? Color.primaryApp : Color.black.opacity(0.2) , radius: 2 )
                    .padding(.bottom, 25)

                    
                    
                    Button {
                        uVM.actionContinue()
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
        .fullScreenCover(isPresented: $uVM.isCarService, content: {
            
                
            VStack{
                
                Spacer()
                VStack{
                    Text("Select Car Service")
                        .font(.customfont(.extraBold, fontSize: 18))
                        .foregroundColor(Color.primaryText)
                        .padding(20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        LazyHStack (spacing: 15) {
                            
                            ForEach( 0 ..< uVM.avaiableServicePriceArr.count , id: \.self) { index in
                                
                                let cObj = uVM.avaiableServicePriceArr[index]
                                
                                Button {
                                    uVM.selectServiceIndex = index
                                } label: {
                                    ZStack(alignment: .leading) {
                                        
                                        VStack {
                                            Text(cObj.serviceName)
                                                .font(.customfont(.semiBold, fontSize: 17))
                                                .foregroundColor( Color.primaryText )
                                            
                                            Text("$\( cObj.estPriceMin, specifier:  "%.2f" ) - $\(cObj.estPriceMax, specifier: "%.2f")")
                                                .font(.customfont(.semiBold, fontSize: 17))
                                                .foregroundColor( Color.primaryApp )
                                        }
                                        .padding(.leading, 50)
                                        .padding(20)
                                        .frame(width: 200, height: 120, alignment: .leading)
                                        .background(Color.white)
                                        .cornerRadius(15)
                                        .shadow( color: uVM.selectServiceIndex == index ? Color.primaryApp : Color.black.opacity(0.2) , radius: 2)
                                        .padding(.leading, 70)
                                        
                                        
                                        WebImage(url: URL(string: cObj.icon))
                                            .resizable()
                                            .indicator(.activity)
                                            .scaledToFit()
                                            .frame(width: 130,  height: 100 )
                                        
                                    }
                                    
                                }
                            }
                            
                        }
                    }
                    .frame(height: 160, alignment: .leading)
                    
                    
                    Button {
                        uVM.actionBooking()
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
            .alert(isPresented: $uVM.showError, content: {
                
                Alert(title: Text(Globs.AppName), message: Text( uVM.errorMessage ), dismissButton: .default(Text("Ok")) {
                    
                })
            })
        })
        .background( NavigationLink(
            destination: UserRunTipView(),
            isActive: $rVM.showRunningRide,
            label: {
                EmptyView()
            }))
        .alert(isPresented: $uVM.showError, content: {
            
            Alert(title: Text(Globs.AppName), message: Text( uVM.errorMessage ), dismissButton: .default(Text("Ok")) {
                
            })
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

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        
        if( lhs.center.latitude == rhs.center.latitude && lhs.span.latitudeDelta == rhs.span.latitudeDelta && lhs.center.longitude == rhs.center.longitude  ) {
            return true
        }else{
            return false
        }
        
    }
    
        
    
}
