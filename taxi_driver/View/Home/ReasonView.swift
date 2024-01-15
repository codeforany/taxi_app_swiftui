//
//  ReasonView.swift
//  taxi_driver
//
//  Created by CodeForAny on 10/10/23.
//

import SwiftUI

struct ReasonView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var reasonArr = [
            "Rider isn't here",
            "Wrong address shown",
            "Don't change rider"
        ]

    @State var selectIndex = 0;
    
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                    Text("Cancel Trip")
                        .font(.customfont(.extraBold, fontSize: 18))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(width: 30, height: 30)
                }
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                Divider()
                
                ScrollView {
                    LazyVStack {
                        ForEach(0..<reasonArr.count, id: \.self) { index in
                            var reasonText = reasonArr[index] as? String ?? ""
                            VStack {
                                HStack {
                                    Image( selectIndex == index ? "check_list" : "uncheck_list"  )
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30, alignment: .center)
                                    
                                    Text(reasonText)
                                        .font(.customfont(.regular, fontSize: 16))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                Divider()
                                    .padding(.leading, 40)
                            }
                            .frame( height: 50)
                            .background(Color.white)
                            .onTapGesture {
                                selectIndex = index
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Text("DONE")
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                .background( Color.primaryApp )
                .cornerRadius(25)
                .padding(.horizontal, 20)
                .padding(.bottom, .bottomInsets + 8)
            }
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    ReasonView()
}
