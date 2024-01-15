//
//  MyRatingView.swift
//  taxi_driver
//
//  Created by CodeForAny on 18/10/23.
//

import SwiftUI

struct MyRatingView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    
    
    var body: some View {
        ZStack {
            VStack{
                
                
                ZStack{
                    Text("Ratings")
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
                    
                    HStack {
                        VStack {
                            Text("4.5")
                                .font(.customfont(.extraBold, fontSize: 25))
                                .foregroundColor(Color.primaryText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(spacing: 0) {
                                ForEach(1...5, id: \.self) { i in
                                    Image(systemName: "star.fill")
                                        .foregroundColor( i <= 4 ? Color.primaryApp : Color.lightGray )
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Image("user")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12)
                                Text("1415 users")
                                    .font(.customfont(.regular, fontSize: 14))
                                    .foregroundColor(Color.secondaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .center) {
                            
                            Circle()
                                .stroke(Color.lightGray, lineWidth: 15 )
                            
                            
                            Circle()
                                .trim(from: 0, to: 0.3)
                                .stroke(Color.primaryApp, lineWidth: 15 )
                                .rotationEffect(.degrees(-90))
                            
                            VStack {
                                Text("2547")
                                    .font(.customfont(.extraBold, fontSize: 18))
                                    .foregroundColor(Color.primaryText)
                                Text("Total Trips")
                                    .font(.customfont(.regular, fontSize: 16))
                                    .foregroundColor(Color.secondaryText)
                            }
                        }
                        .frame(width: 130, height: 130, alignment: .leading)
                    }
                    .padding(25)
                    
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.lightWhite)
                            .frame(height: 20)
                        Text("OCT'23")
                            .font(.customfont(.extraBold, fontSize: 15))
                            .foregroundColor(Color.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 8)
                            .background(Color.lightWhite)
                    }
                        
                       
                    VStack(spacing: 15){
                        RatingRow(rate: 5, message: "Your service is very good. the experience that I had was incredible.")
                        RatingRow(rate: 4, message: "Your service is very good. the experience that I had was incredible.")
                        RatingRow(rate: 3, message: "")
                        RatingRow(rate: 5, message: "")
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
    MyRatingView()
}
