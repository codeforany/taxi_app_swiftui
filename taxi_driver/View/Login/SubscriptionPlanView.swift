//
//  SubscriptionPlanView.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/09/23.
//

import SwiftUI

struct SubscriptionPlanView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State var planArr = [
        [
              "name": "Basic plan",
              "time": "1 Month",
              "rides": "• 10 rides Everyday",
              "cash_rides": "• 2 Cash rides",
              "km": "• 50 km travel rides",
              "price": "TRY FREE"
        ],
            [
              "name": "Classic plan",
              "time": "3 Month",
              "rides": "• 10 rides Everyday",
              "cash_rides": "• 2 Cash rides",
              "km": "• 50 km travel rides",
              "price": "BUY AT $20.50"
            ]
    ]
    
    
    var body: some View {
        ZStack{
            ScrollView {
                
                HStack(alignment: .center) {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Text("Subscription Plan")
                        .font(.customfont(.extraBold, fontSize: 25))
                       
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(width: 30, height: 30)

                }
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    
                    ForEach(0..<planArr.count, id: \.self) {
                        index in
                        
                        var pObj = planArr[index]
                        
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text( pObj["name"] ?? ""  )
                                .font(.customfont(.regular, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text( pObj["time"] ?? ""  )
                                .font(.customfont(.regular, fontSize: 15))
                                .foregroundColor(.secondaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text( pObj["rides"] ?? ""  )
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(.secondaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text( pObj["cash_rides"] ?? ""  )
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(.secondaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text( pObj["km"] ?? ""  )
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(.secondaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                
                            } label: {
                                Text( pObj["price"] ?? ""  )
                                    .font(.customfont(.bold, fontSize: 16))
                                    .foregroundColor(.primaryApp)
                                    .frame(maxWidth: .infinity, alignment: .trailing )
                            }

                        }
                        .padding(15)
                        .background( RoundedRectangle(cornerRadius: 5).fill(Color.white).shadow(radius: 1) )
                        .padding(.vertical, 4)
                                                
                    }
                    .padding(.bottom, 15)
                    
                    
                    VStack(alignment: .leading, spacing: 0){
                                                
                        NavigationLink {
                            
                        } label: {
                            Text("NEXT")
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor(Color.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                        .background( Color.primaryApp )
                        .cornerRadius(25)
                        .padding(.bottom, 30)
                    }
                    
                }
                .foregroundColor(Color.primaryText)
                .padding(.horizontal, 20)
                
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct SubscriptionPlanView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionPlanView()
    }
}
