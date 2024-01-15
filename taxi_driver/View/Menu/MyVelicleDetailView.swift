//
//  MyVelicleDetailView.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/10/23.
//

import SwiftUI

struct MyVelicleDetailView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @State var listArr = [
        
        [
            
            "name": "Vehicle Registration",
            "descrition": "Vehicle Registration",
            "status":"APPROVED",
            "status_color": Color.primaryApp
            
        ],
        
        [
            
            "name": "Vehicle Insurance",
            "descrition": "Expires: 22 Nov 2025",
            "status":"APPROVED",
            "status_color": Color.primaryApp
            
        ],
        
        [
            
            "name": "Vehicle Permit",
            "descrition": "Expires: 22 Nov 2025",
            "status":"APPROVED",
            "status_color": Color.primaryApp
            
        ],
        
        [
            
            "name": "Vehicle Loan EMI Details",
            "descrition": "Incorrect document type",
            "status":"NOT APPROVED",
            "status_color": Color.redApp
            
        ],
        
        
        
        
    ]
    
    var body: some View {
        ZStack {
            VStack{
                
                
                ZStack{
                    
                    VStack{
                        Text("Toyota Prius")
                            .font(.customfont(.extraBold, fontSize: 20))
                        Text("AB 1234")
                            .font(.customfont(.regular, fontSize: 15))
                            .foregroundColor(Color.secondaryText)
                    }
                    
                    
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
                    
                    LazyVStack(spacing:20){
                        ForEach(0..<listArr.count, id: \.self, content:  { index in
                            VehicleDocumentRow(dObj: listArr[index] as NSDictionary ?? [:] )
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
    MyVelicleDetailView()
}
