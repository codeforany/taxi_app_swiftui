//
//  SupportUserView.swift
//  taxi_driver
//
//  Created by CodeForAny on 15/01/24.
//

import SwiftUI

struct SupportUserView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var sVM = SupportViewModel.shared
    
    @State var txtMessage = ""
    
    var body: some View {
        ZStack{
            
            VStack( spacing: 0 ,content: {
                
                ZStack{
                    
                    HStack{
                        Button(action: {
                            mode.wrappedValue.dismiss()
                        }, label: {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        })
                        
                        Spacer()
                       
                    }
                    
                    Text("Supports")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(maxWidth: .infinity, alignment : .center)
                }
                
                .padding(.bottom , 8)
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                Rectangle()
                    .fill(Color.lightWhite)
                    .frame(height: 2)
                
                ScrollView {
                    
                    LazyVStack( content: {
                        ForEach(0..<sVM.userArr.count, id: \.self) { index in
                            
                            let uObj = sVM.userArr[index]
                            
                            Button(action: {
                                sVM.selectSupportUser = uObj
                            }, label: {
                                HStack {
                                        
                                    Image("u1")
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(25)
                                        .frame(width: 50, height: 50)
                                        .clipped()
                                    
                                    VStack( spacing: 0) {
                                        
                                        HStack {
                                            Text(uObj.name)
                                                .font(.customfont(.bold, fontSize: 17))
                                                .foregroundColor(.primaryText )
                                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                            Text(uObj.createdDate.string)
                                                .font(.customfont(.regular, fontSize: 13))
                                                .foregroundColor(.secondaryText)
                                               
                                        }
                                        
                                        HStack {
                                            Text(uObj.message)
                                                .font(.customfont(.regular, fontSize: 15))
                                                .foregroundColor(.secondaryText )
                                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                            
                                            if( uObj.baseCount > 0 ) {
                                                Text( "\( uObj.baseCount )" )
                                                .font(.customfont(.semiBold, fontSize: 11))
                                                .foregroundColor(.white)
                                                .frame(minWidth: 15)
                                                .padding(4)
                                                .background( Color.primaryApp)
                                                .cornerRadius(20)
                                            }
                                               
                                               
                                        }
                                        
                                    }
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                .padding()
                                .background(Color.white)
                            
                                .cornerRadius(10)
                            })
                            
                            
                        }
                    })
                    .padding()
                    .padding(.bottom , .bottomInsets)
                    
                    
                }
                .background( Color.lightWhite )
            })
        }
        .onAppear(){
            sVM.supportUserApi()
        }
        .background( NavigationLink(destination: SupportMessageView(), isActive: $sVM.showMessage , label: {
            EmptyView()
        }))
        .alert(isPresented: $sVM.showError, content: {
            
            Alert(title: Text("Driver App"), message: Text(sVM.errorMessage), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    SupportUserView()
}
