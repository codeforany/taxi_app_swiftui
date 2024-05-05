//
//  SettingsView.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/10/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    
    
    var body: some View {
        ZStack {
            VStack{
                ZStack{
                    Text("Settings")
                        .font(.customfont(.extraBold, fontSize: 25))
                    
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image("close")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(.white)
                        Spacer()
                   }
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                Rectangle()
                    .fill(Color.lightWhite)
                    .frame(height: 8)
                
                ScrollView{
                    LazyVStack(spacing: 20){
                        
                        NavigationLink {
                            DriverEditProfileView()
                        } label: {
                            SettingRow(icon: "sm_profile", title: "My Profile")
                        }

                        if( ServiceCall.userType == 1 ) {
                            NavigationLink {
                                UserMyRidesView()
                            } label: {
                                SettingRow(icon: "sm_my_vehicle", title: "My Rides")
                            }
                        }else{
                            NavigationLink {
                                DriverMyRideView()
                            } label: {
                                SettingRow(icon: "sm_my_vehicle", title: "My Rides")
                            }
                        }
                        
                        
                        NavigationLink {
                            MyVehicleView()
                        } label: {
                            SettingRow(icon: "sm_my_vehicle", title: "My Vehicle")
                        }

                        
                        NavigationLink {
                            DocumentUploadView()
                        } label: {
                            SettingRow(icon: "sm_document", title: "Personal Document")
                        }
                        
                       
                        
                        NavigationLink {
                            BankDetailsView()
                        } label: {
                            SettingRow(icon: "sm_bank", title: "Bank details")
                        }

                        
                        NavigationLink {
                            ChangePasswordView()
                        } label: {
                            SettingRow(icon: "sm_password", title: "Change Password")
                        }
                        
                       
                    }
                    .padding(.horizontal, 20)
                    
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.lightWhite)
                            .frame(height: 20)
                        Text("HELP")
                            .font(.customfont(.extraBold, fontSize: 15))
                            .foregroundColor(Color.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 8)
                            .background(Color.lightWhite)
                    }
                       
                    VStack(spacing: 20){
                        SettingRow(icon: "sm_document", title: "Terms & Conditions")
                        SettingRow(icon: "sm_document", title: "Privacy policies")
                        SettingRow(icon: "sm_document", title: "About")
                        
                        NavigationLink(destination: ContactUsView()) {
                            SettingRow(icon: "sm_profile", title: "Contact us")
                        }
                        
                        
                        
                        NavigationLink(destination: SupportUserView()) {
                            SettingRow(icon: "sm_profile", title: "Support")
                        }
                    }
                    .padding(.horizontal, 20)
                    
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
    
    NavigationView {
        SettingsView()
    }
    
}
