//
//  MyProfileDetailsView.swift
//  taxi_driver
//
//  Created by CodeForAny on 17/10/23.
//

import SwiftUI

struct MyProfileDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image("back_temp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .foregroundColor(.white)
                
                Spacer()
                
                NavigationLink {
                    EditProfileView()
                } label: {
                    Image("edit")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                
                .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.top, .topInsets)
            .background( Color(hex: "282F39" ) )
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color(hex: "282F39" ) )
                    .frame(width: .infinity, height: 150)
                
                
                    ZStack(alignment: .top){
                                                
                        VStack {
                            
                            Text("James Smith")
                                .font(.customfont(.extraBold, fontSize: 25))
                                .foregroundColor(.primaryText)
                                .padding(.top, 80)
                            
                            
                            
                            VStack(spacing: 0) {
                                Divider()
                                HStack {
                                    TitleSubtitleButton(title: "3250", subtitle: "Total Trips")
                                    
                                    Rectangle()
                                        .fill(Color.lightGray)
                                        .frame(width: 1, height: 70)
                                    
                                    TitleSubtitleButton(title: "2.5", subtitle: "Years")
                                    
                                }
                            }
                            
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(15)
                        .padding(.top, 30)
                       
                        
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
                            
                            }
                        })
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                 
            }
            
            
            ScrollView {
                VStack{
                    Text("RERSONAL INFO")
                        .font(.customfont(.extraBold, fontSize: 15))
                        .foregroundColor(.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
                    
                    VStack(spacing: 15) {
                        HStack {
                            Image("phone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            Text("+1 987 321 6540")
                                .font(.customfont(.semiBold, fontSize: 16))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .padding(.horizontal, 20)
                        
                        HStack {
                            Image("email")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            Text("codeforany@gmail.com")
                                .font(.customfont(.semiBold, fontSize: 16))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accentColor(.primaryText)
                            
                        }
                        .padding(.horizontal, 20)
                        
                        
                        HStack {
                            Image("language")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            Text("English and Spanish")
                                .font(.customfont(.semiBold, fontSize: 16))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .padding(.horizontal, 20)
                        
                        
                        HStack {
                            Image("home")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            Text("RM6 NL, PO 2452, New York")
                                .font(.customfont(.semiBold, fontSize: 16))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .padding(.horizontal, 20)
                        
                        
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
                        .padding(.horizontal, 20)
                        
                       
                    }
                    .padding(.vertical, 15)
                    .background(Color.white)
                }
            }
        }
        .background( Color.lightWhite )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        MyProfileDetailsView()
    }
    
}
