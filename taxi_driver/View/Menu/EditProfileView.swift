//
//  EditProfileView.swift
//  taxi_driver
//
//  Created by CodeForAny on 17/10/23.
//

import SwiftUI
import CountryPicker

struct EditProfileView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var countryObj: Country?
    @State private var showCountryPicker = false
    
    @State private var txtFirst = ""
    @State private var txtLast = ""
    @State private var txtEmail = ""
    @State private var txtMobile = ""
    
    var body: some View {
        ZStack{
            ScrollView {
                
                ZStack{
                    Text("Edit profile")
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
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    LineTextField( title: "First name" , placholder: "Ex: Aelx" , txt: $txtFirst)
                        .padding(.bottom, 8)
                    
                    LineTextField( title: "Last name" , placholder: "Ex: Patel" , txt: $txtLast)
                        .padding(.bottom, 8)
                    
                    Text("Mobile")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.placeholder)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
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
                        
                        TextField("Enter Mobile", text: $txtMobile)
                            .font(.customfont(.medium, fontSize: 16))
                            .frame(maxWidth: .infinity)
                    }
                    
                    Divider()
                        .padding(.bottom, 15)
                    
                    LineTextField( title: "Email Address" , placholder: "Ex: aaaa@gmail.com" , txt: $txtEmail)
                        .padding(.bottom, 8)
                    
                    Button {
                        
                    } label: {
                        Text("SAVE")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                    .background( Color.primaryApp )
                    .cornerRadius(25)
                    .padding(.vertical, 20)
                }
                .foregroundColor(Color.primaryText)
                .padding(.horizontal, 20)
                
            }
        }
        .onAppear{
            self.countryObj = Country(phoneCode: "91", isoCode: "IN")
        }
        .sheet(isPresented: $showCountryPicker) {
            CountryPickerUI(country: $countryObj)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

#Preview {
    EditProfileView()
}
