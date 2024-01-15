//
//  WalletView.swift
//  taxi_driver
//
//  Created by CodeForAny on 15/10/23.
//

import SwiftUI

struct WalletView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @State var listArr = [
        
        [
          "icon": "wallet_add",
          "name": "Added to Wallet",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ],
        [
          "icon": "trips_cut",
          "name": "Trip Deducted",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ],
        [
          "icon": "withdraw",
          "name": "Withdraw to Wallet",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ],
            [
          "icon": "wallet_add",
          "name": "Added to Wallet",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ],
        [
          "icon": "trips_cut",
          "name": "Trip Deducted",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ],
        [
          "icon": "withdraw",
          "name": "Withdraw to Wallet",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ],
        [
          "icon": "wallet_add",
          "name": "Added to Wallet",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ],
        [
          "icon": "trips_cut",
          "name": "Trip Deducted",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ],
        [
          "icon": "withdraw",
          "name": "Withdraw to Wallet",
          "time": "1 Feb'19 • #123467",
          "price": "$40"
        ]
    
    ]
    
    var body: some View {
        ZStack {
            VStack{
                
                
                ZStack{
                    Text("Wallet")
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
                        
                        Text("Total balance")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.secondaryText)
                            .padding(.top, 25)
                        HStack(alignment: .top,spacing: 8) {
                            Text("$")
                                .font(.customfont(.extraBold, fontSize: 14))
                                .foregroundColor(Color.primaryApp)
                            Text("154.75")
                                .font(.customfont(.extraBold, fontSize: 25))
                                .foregroundColor(Color.primaryText)
                        }
                        .padding(.bottom, 25)
                        
                        
                        VStack(spacing: 0) {
                            Divider()
                            
                            HStack {
                                
                                Button {
                                    
                                } label: {
                                    Text("WITHDRAW")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(Color.primaryApp)
                                        
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                
                                Rectangle()
                                    .fill(Color.lightGray)
                                    .frame( width: 1 , height: 50)
                                
                                Button {
                                    
                                } label: {
                                    Text("ADD MONEY")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(Color.primaryApp)
                                        
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                
                                
                            }
                            Divider()
                            
                            Rectangle()
                                .fill(Color.lightWhite)
                                .frame(height: 20)
                            
                            Text("OCT 2023")
                                .font(.customfont(.extraBold, fontSize: 15))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.bottom, 8)
                                .background(Color.lightWhite)
                            
                        }
                        
                        
                    }
                   
                    
                    LazyVStack{
                        ForEach(0..<listArr.count, id: \.self, content:  { index in
                            WalletRow(wObj: listArr[index] as NSDictionary ?? [:] )
                        })
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
    WalletView()
}
