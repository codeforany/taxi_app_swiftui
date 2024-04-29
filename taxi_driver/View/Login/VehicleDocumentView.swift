//
//  VehicleDocumentView.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/09/23.
//

import SwiftUI

struct VehicleDocumentView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var listArr = [
        [
              "name": "RC Book",
              "detail": "Vehicle Registration",
              "info": "",
              "status": "uploaded"
            ],
            [
              "name": "Insurance policy",
              "detail": "A driving license is an official do...",
              "info": "",
              "status": "uploading"
            ] ,
            [
              "name": "Owner certificate",
              "detail": "A passport is a travel document...",
              "info": "",
              "status": "upload"
            ],
            [
              "name": "PUC",
              "detail": "Incorrect document type",
              "info": "",
              "status": "upload"
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
                    
                    Text("Vehicle Document")
                        .font(.customfont(.extraBold, fontSize: 25))
                       
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(width: 30, height: 30)

                }
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    
//                    ForEach(0..<listArr.count, id: \.self ) { index in
//                        
//                        var dObj = listArr[index] ?? [:]
//                        
//                        if( dObj["status"] as? String ?? "" == "uploaded" ) {
//                            DocumentRow(dObj: dObj,  type: .uploaded )
//                         
//                        }else if ( dObj["status"] as? String ?? "" == "uploading" ) {
//                            DocumentRow(dObj: dObj,  type: .uploading )
//                        }else{
//                            DocumentRow(dObj: dObj,  type: .upload )
//                        }
//                        
//                        
//                    }
//                    .padding(.bottom, 15)
                    
                    
                    VStack(alignment: .leading, spacing: 0){
                        Text("By continuing, I confirm that i have read & agree to the")
                            .font(.customfont(.regular, fontSize: 11))
                            .foregroundColor(Color.secondaryText)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack{
                            Text("Terms & conditions")
                                .font(.customfont(.regular, fontSize: 11))
                                .foregroundColor(Color.primaryText)
                            
                            Text("and")
                                .font(.customfont(.regular, fontSize: 11))
                                .foregroundColor(Color.secondaryText)
                            
                            Text("Privacy policy")
                                .font(.customfont(.regular, fontSize: 11))
                                .foregroundColor(Color.primaryText)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 15)
                        
                        NavigationLink {
                            SubscriptionPlanView()
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

struct VehicleDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDocumentView()
    }
}
