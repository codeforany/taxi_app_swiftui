//
//  DriverEditProfileView.swift
//  taxi_driver
//
//  Created by CodeForAny on 31/12/23.
//

import SwiftUI
import CountryPicker

struct DriverEditProfileView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var proVM = ProfileViewModel.shared
   
    @State private var showCountryPicker = false
    
    
    @State private var txtName = ""
    @State private var txtEmail = ""
    @State private var txtMobile = ""
    
    @State private var serviceArr: [ServiceModel] = []
    
    
    var body: some View {
        ZStack {
            
            ScrollView {
                ZStack {
                    Text("Edit profile")
                        .font(.customfont(.extraBold, fontSize: 25))
                    
                    HStack {
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }, label: {
                            Image("close")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        })
                        .foregroundColor(.white)
                        
                        Spacer()
                    }
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                
                Rectangle()
                    .fill(Color.lightWhite)
                    .frame(height: 8)
                    .padding(.bottom, 15)
                
                VStack(alignment: .leading, spacing: 0, content: {
                        
                    LineTextField(title: "Name", placholder: "Ex: Aelx Patel" , txt: $proVM.txtName)
                        .padding(.bottom , 8)
                    
                    LineTextField(title: "Email", placholder: "Ex: aelxpatel@mail.com" , txt: $proVM.txtEmail, keyboardType: .emailAddress)
                        .padding(.bottom , 8)
                    
                    
                    Text("Mobile")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.placeholder)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        
                        
                        Button(action: {
                            
                            showCountryPicker = true
                            
                        }, label: {
                            if let countryObj = proVM.countryObj {
                                Text("\(  countryObj.isoCode.getFlag() )")
                                    .font(.customfont(.medium, fontSize: 35))
                                
                                Text("+\(  countryObj.phoneCode )")
                                    .font(.customfont(.medium, fontSize: 16))
                            }
                        })
                        
                        
                        TextField("Enter Mobile", text: $proVM.txtMobile)
                            .keyboardType(.namePhonePad)
                            .font(.customfont(.medium, fontSize: 16))
                            .frame(maxWidth: .infinity)
                        
                    }
                    
                    Divider()
                        .padding(.bottom, 15)
                    
                    
                    Text("Gender")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.placeholder)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    HStack {
                        Button(action: {
                            proVM.isMale = true
                        }, label: {
                            Image(systemName: proVM.isMale ? "record.circle" : "circle")
                            Text("Male")
                        })
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        
                        Button(action: {
                            proVM.isMale = false
                        }, label: {
                                
                            Image(systemName: !proVM.isMale ? "record.circle" : "circle")
                            
                            Text("Female")
                        })
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }
                    
                    Text("Zone")
                        .font(.customfont(.regular, fontSize: 14))
                        .foregroundColor(.placeholder)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    
                    Menu {
                        
                        
                        ForEach(0..<proVM.zoneArr.count, id: \.self) {
                            index in
                            
                            Button(action: {
                                proVM.selectZone = proVM.zoneArr[index] as? NSDictionary
                            }, label: {
                                Text( (proVM.zoneArr[index] as? NSDictionary ?? [:]).value(forKey: "zone_name") as? String ?? "" )
                            })
                            
                        }
                                                
                    } label: {
                        
                        
                        Text( proVM.selectZone?.value(forKey: "zone_name") as? String ?? "Select Zone")
                            .font(.customfont(.medium, fontSize: 16))
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        
                        Text("▼")
                            .font(.customfont(.medium, fontSize: 16))
                    }

                    
                    Divider()
                        .padding(.bottom, 15)
                    
                    Text("Service List")
                        .font(.customfont(.bold, fontSize: 22))
                    
                    
                    VStack {
                        
                        ForEach(0..<proVM.serviceArr.count, id: \.self) {
                            index in
                            
                            Toggle(isOn: $proVM.serviceArr[index].value , label: {
                                Text(proVM.serviceArr[index].serviceName)
                                    .font(.customfont(.medium, fontSize: 16))
                            })
                            
                        }
                    }
                    
                    
                    Button(action: {
                        proVM.updateAction()
                    }, label: {
                        Text("SAVE")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.white)
                    })
                    .frame(maxWidth: .infinity, minHeight: 45, alignment: .center)
                    .background(Color.primaryApp)
                    .cornerRadius(25)
                    .padding(.vertical, 20)
                
                    
                })
                .foregroundColor(.primaryText)
                .padding(.horizontal, 20)
            }
            
        }
        .onAppear() {
            
            proVM.getServiceZoneApi()
        }
        .alert(isPresented: $proVM.showError, content: {
            
            Alert(title: Text("Driver App"), message: Text(proVM.errorMessage), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .sheet(isPresented: $showCountryPicker, content: {
            CountryPickerUI(country: $proVM.countryObj)
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    DriverEditProfileView()
}
