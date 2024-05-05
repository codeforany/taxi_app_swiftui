//
//  ContactUsView.swift
//  taxi_driver
//
//  Created by CodeForAny on 06/05/24.
//

import SwiftUI

struct ContactUsView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var cVM = ContactUsViewModel.shared
    
    var body: some View {
        ZStack{
            
            VStack{
                ZStack{
                    Text("Contact Us")
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
                    
                    VStack(spacing: 15){
                        LineTextField(title: "Name", placholder: "Enter Name", txt: $cVM.txtName)
                        LineTextField(title: "Email", placholder: "Enter Email Address", txt: $cVM.txtEmail)
                        LineTextField(title: "Subject", placholder: "Enter Subject", txt: $cVM.txtSubject)
                        LineTextField(title: "Message", placholder: "Enter Message", txt: $cVM.txtMessage)
                        
                        Button {
                            cVM.actionSubmit()
                        } label: {
                            Text("Submit")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45, alignment: .center)
                        .background( Color.primaryApp )
                        .cornerRadius(25)
                        .padding(.bottom, 15)

                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal, 20)
                    
                }
            }
        }
        .alert(isPresented: $cVM.showError, content: {
            Alert(title: Text(Globs.AppName), message:  Text(cVM.errorMessage), dismissButton: .default(Text("Ok")){
                
            })
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ContactUsView()
}
