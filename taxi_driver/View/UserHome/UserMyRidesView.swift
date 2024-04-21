//
//  UserMyRidesView.swift
//  taxi_driver
//
//  Created by CodeForAny on 15/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserMyRidesView: View {
    
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
            hVM.apiUserRideAll()
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
    UserMyRidesView()
}
