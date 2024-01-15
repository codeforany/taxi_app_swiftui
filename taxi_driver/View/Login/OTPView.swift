//
//  OTPView.swift
//  taxi_driver
//
//  Created by CodeForAny on 18/09/23.
//

import SwiftUI

struct OTPView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var loginVM = LoginViewModel.shared
    
    
    var body: some View {
        ZStack{
            ScrollView {
                
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Spacer()

                }
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("OTP Verification")
                        .font(.customfont(.extraBold, fontSize: 25))
                        .padding(.bottom, 15)
                    
                    Text("Enter the 4-digit code sent to you at")
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(.secondaryText)
                        .padding(.bottom, 1)
                    
                    HStack{
                        Text("\(loginVM.txtMobileCode) \( loginVM.txtMobile )")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .padding(.bottom, 1)
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Text("Edit")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(.secondaryApp)
                        }

                    }
                    .padding(.bottom, 30)
                    
                    OTPTextField(txtOTP: $loginVM.txtCode)
                        .padding(.bottom, 30)
                    
                    Button {
                        loginVM.verifyCode()
                    } label: {
                        Text("SUBMIT")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                    .background( Color.primaryApp )
                    .cornerRadius(25)
                    
                    
                    Button {
                        loginVM.sendSMS()
                    } label: {
                        Text("Resend Code")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(Color.primaryApp)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)

                }
                .foregroundColor(Color.primaryText)
                .padding(.horizontal, 20)
                
            }
        }
        .alert(isPresented: $loginVM.showError, content: {
            
            Alert(title: Text("Driver App"), message: Text(loginVM.errorMessage), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}
