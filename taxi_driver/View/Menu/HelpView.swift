//
//  HelpView.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/10/23.
//

import SwiftUI

struct HelpView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
   
    
    var body: some View {
        ZStack {
            
            VStack{
                
                
                ZStack{
                    Text("Help")
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
                    LazyVStack(spacing: 0){
                 
                        HelpRow(title: "I Forgot my password")
                        HelpRow(title: "How to withdraw balance")
                        HelpRow(title: "What is summay")
                        HelpRow(title: "How to earn extra money")
                        
                        
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
    HelpView()
}
