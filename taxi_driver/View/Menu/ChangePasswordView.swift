//
//  ChangePasswordView.swift
//  taxi_driver
//
//  Created by CodeForAny on 04/05/24.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var pVM = ProfileViewModel.shared
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    Text("Change Password")
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
                
                
                
                ScrollView {
                    
                    VStack(spacing: 15){
                        LineSecureField( title: "Currnet Password", placholder: "*****",  txt: $pVM.txtCurrentPassword, isShowPassword: $pVM.showCurrentPassword)
                        
                        LineSecureField( title: "New Password", placholder: "*****",  txt: $pVM.txtNewPassword, isShowPassword: $pVM.showNewPassword)
                        
                        LineSecureField( title: "Confirm Password", placholder: "*****",  txt: $pVM.txtConfirmPassword, isShowPassword: $pVM.showConfirmPassword)
                        
                        Button {
                            pVM.actionChangePassword()
                        } label: {
                            Text("Change")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                        .background( Color.primaryApp )
                        .cornerRadius(25)
                        .padding(.bottom, 15)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 25 )
                    
                    
                    
                }
            }
            
        }
        .alert(isPresented: $pVM.showError, content: {
            Alert(title: Text( Globs.AppName ), message: Text( pVM.errorMessage ), dismissButton: .default(Text("Ok")) {
                
            } )
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    ChangePasswordView()
}
