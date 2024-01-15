//
//  AddMoneyWalletView.swift
//  taxi_driver
//
//  Created by CodeForAny on 15/10/23.
//

import SwiftUI

struct AddMoneyWalletView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @State var txtAdd = "48"
    var body: some View {
        ZStack {
            VStack{
                
                
                ZStack{
                    Text("Add money to wallet")
                        .font(.customfont(.extraBold, fontSize: 25))
                    
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image("back")
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
                    VStack {
                        
                        HStack {
                            Text("Avilable balance")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.secondaryText)
                            
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("$54.75")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.secondaryText)
                            
                            
                        }
                        .padding(.top, 15)
                        .padding(.horizontal, 25)
                        
                        
                        HStack{
                            Text("$")
                                .font(.customfont(.regular, fontSize: 22))
                                .foregroundColor(Color.secondaryText)
                            TextField("Add Money", text: $txtAdd)
                                .font(.customfont(.regular, fontSize: 22))
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 50)
                        
                        HStack{
                            
                            Button(action: {
                                
                            }, label: {
                                Text("+10")
                            })
                            .foregroundColor(Color.primaryApp)
                            .frame(width: 70, height: 44, alignment: .center)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primaryApp, lineWidth: 1) )
                            Button(action: {
                                
                            }, label: {
                                Text("+20")
                            })
                            .foregroundColor(Color.primaryApp)
                            .frame(width: 70, height: 44, alignment: .center)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primaryApp, lineWidth: 1) )
                            
                            Button(action: {
                                
                            }, label: {
                                Text("+50")
                            })
                            .foregroundColor(Color.primaryApp)
                            .frame(width: 70, height: 44, alignment: .center)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.primaryApp, lineWidth: 1) )
                            
                            Spacer()
                        }
                        .padding(.bottom, 15)
                        .padding(.horizontal, 25)
                        
                        Rectangle()
                            .fill(Color.lightWhite)
                            .frame(  height: 8)
                        
                        Text("From Bank Account")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.primaryText)
                            .padding(.horizontal, 25)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)
                        
                        
                        VStack {
                            HStack(spacing:15) {
                                
                                Image( "bank_logo"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                
                                VStack(alignment: .leading, spacing:8){
                                  
                                    Text("Standard Chartered Bank")
                                        .font(.customfont(.regular, fontSize: 16))
                                        .foregroundColor(Color.primaryText)
                                    
                                    Text("****3315")
                                        .font(.customfont(.regular, fontSize: 15))
                                        .foregroundColor(Color.secondaryText)
                                }
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                                
                                
                            }
                        }
                        .padding(.bottom, 15)
                        
                        Button {
                           
                        } label: {
                            Text("SUBMIT REQUEST")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                        .background( Color.primaryApp )
                        .cornerRadius(25)
                        .padding(.horizontal, 25)
                        .padding(.bottom, 30)
                        
                    }
                    
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
    AddMoneyWalletView()
}
