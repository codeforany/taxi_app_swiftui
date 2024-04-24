//
//  MenuView.swift
//  taxi_driver
//
//  Created by CodeForAny on 11/10/23.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0){
            
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("close_temp")
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
                    .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                
                HStack(alignment: .bottom, spacing: 15, content: {
                    Button(action: {
                        
                    }, label: {
                        VStack{
                            
                            Image("earnings")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Text("Earnings")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(.white)
                        }
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button(action: {
                        
                    }, label: {
                        VStack{
                            
                            ZStack(alignment: .bottom){
                                Image("ride_user_profile")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .overlay( RoundedRectangle(cornerRadius: 50).stroke(Color.white, lineWidth: 2) )
                                    .cornerRadius(50)
                                    .clipped()
                                
                                
                                HStack(spacing: 8){
                                    Image("rate_profile")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15, height: 15)
                                    
                                    Text("4.89")
                                        .font(.customfont(.regular, fontSize: 16))
                                        .foregroundColor(.primaryText)
                                }
                                .padding(.horizontal, 8)
                                .background( Color.white )
                            }
                            
                            
                            Text("James Smith")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(.white)
                        }
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    
                    Button(action: {
                        
                    }, label: {
                        VStack{
                            
                            Image("wallet")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Text("Wallet")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(.white)
                        }
                    })
                    .frame(maxWidth: .infinity, alignment: .center)
                })
                .padding(.bottom, 15)
                
                
            }
            .background( Color(hex: "282F39" ) )
            
            ScrollView {
                VStack{
                    HStack {
                        Image("service")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        VStack {
                            Text("Switch Service Type")
                                .font(.customfont(.extraBold, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Change your service type")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(.secondaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image("next")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.secondaryText)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background( Color.lightGray.opacity(0.4) )
                    
                    
                    HStack {
                        Image("home")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        Text("Home")
                            .font(.customfont(.semiBold, fontSize: 16))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
                    NavigationLink {
                        SummaryView()
                    } label: {
                        HStack {
                            Image("summary")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            Text("Summary")
                                .font(.customfont(.semiBold, fontSize: 16))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
                    
                    HStack {
                        Image("my_subscription")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        Text("My Subscription")
                            .font(.customfont(.semiBold, fontSize: 16))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
                    
                    HStack {
                        Image("notification")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        Text("Notifications")
                            .font(.customfont(.semiBold, fontSize: 16))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
                    
                    NavigationLink {
                        SettingsView()
                    } label: {
                        HStack {
                            Image("setting")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            Text("Settings")
                                .font(.customfont(.semiBold, fontSize: 16))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
                    HStack {
                        Image("logout")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        Text("Logout")
                            .font(.customfont(.semiBold, fontSize: 16))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
                    
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
    MenuView()
}
