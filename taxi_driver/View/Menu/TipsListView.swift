//
//  TipsListView.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/10/23.
//

import SwiftUI

struct TipsListView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var weeklyArr = [
        ["time": "Mon, 28 Sep", "trips": "25", "price": "$40"],
           ["time": "Mon, 27 Sep", "trips": "15", "price": "$30"],
           ["time": "Mon, 26 Sep", "trips": "40", "price": "$120"],
           ["time": "Mon, 24 Sep", "trips": "30", "price": "$100"],
        ["time": "Mon, 28 Sep", "trips": "25", "price": "$40"],
           ["time": "Mon, 27 Sep", "trips": "15", "price": "$30"],
           ["time": "Mon, 26 Sep", "trips": "40", "price": "$120"],
           ["time": "Mon, 24 Sep", "trips": "30", "price": "$100"],
        
    ]
    
    var body: some View {
        ZStack {
            
            VStack{
                
                
                ZStack{
                    Text("Trips")
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
                
                ScrollView {
                    LazyVStack{
                 
                            ForEach(0..<weeklyArr.count, id: \.self, content:  { index in
                                
                                WeeklySummaryRow(sObj: weeklyArr[index] as NSDictionary ?? [:] )
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
    TipsListView()
}
