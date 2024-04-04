//
//  MobileNumberView.swift
//  taxi_driver
//
//  Created by CodeForAny on 17/09/23.
//

import SwiftUI
import CountryPicker

struct MobileNumberView: View {
    
    @StateObject var loginVM = LoginViewModel.shared
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var countryObj: Country?
    @State private var showCountryPicker = false
    
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
                    Text("Enter mobile number")
                        .font(.customfont(.extraBold, fontSize: 25))
                        .padding(.bottom, 30)
                    
                    
                    HStack {
                        
                        Button {
                                        showCountryPicker = true
                        } label: {
                            if let  countryObj = countryObj {
                                
                                Text("\( countryObj.isoCode.getFlag() )")
                                    .font(.customfont(.medium, fontSize: 35))
                                
                                Text("+\( countryObj.phoneCode )")
                                    .font(.customfont(.medium, fontSize: 16))
                            }
                        }
                        
                        TextField("Enter Mobile", text: $loginVM.txtMobile)
                            .font(.customfont(.medium, fontSize: 16))
                            .frame(maxWidth: .infinity)
                    }
                    
                    Divider()
                        .padding(.bottom, 15)
                    
                    
                    Text("By continuing, I confirm that i have read & agree to the")
                        .font(.customfont(.regular, fontSize: 11))
                        .foregroundColor(Color.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack{
                        Text("Terms & conditions")
                            .font(.customfont(.regular, fontSize: 11))
                            .foregroundColor(Color.primaryText)
                        
                        Text("and")
                            .font(.customfont(.regular, fontSize: 11))
                            .foregroundColor(Color.secondaryText)
                        
                        Text("Privacy policy")
                            .font(.customfont(.regular, fontSize: 11))
                            .foregroundColor(Color.primaryText)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 15)
                    
                    Button {
                        if let countryObj = countryObj {
                            loginVM.submitMobileNumber(cObj: countryObj)
                        }
                    } label: {
                        Text("Login as Driver")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                    .background( Color.primaryApp )
                    .cornerRadius(25)
                    .padding(.bottom, 15)
                    
                    Button {
                        if let countryObj = countryObj {
                            loginVM.submitMobileNumber(cObj: countryObj, isDriver: false)
                        }
                    } label: {
                        Text("Login as User")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                    .background( Color.primaryApp )
                    .cornerRadius(25)
                    
                }
                .foregroundColor(Color.primaryText)
                .padding(.horizontal, 20)
                
            }
        }
        .onAppear{
            self.countryObj = Country(phoneCode: "91", isoCode: "IN")
        }
        .alert(isPresented: $loginVM.showError, content: {
            
            Alert(title: Text("Driver App"), message: Text(loginVM.errorMessage), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .background(
            
            NavigationLink(destination: OTPView(), isActive: $loginVM.showOTP) {
                EmptyView()
            }
        )
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerUI(country: $countryObj)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct MobileNumberView_Previews: PreviewProvider {
    static var previews: some View {
        MobileNumberView()
    }
}
