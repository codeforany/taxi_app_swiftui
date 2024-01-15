//
//  BankDetailsView.swift
//  taxi_driver
//
//  Created by CodeForAny on 19/09/23.
//

import SwiftUI

struct BankDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var proVM = ProfileViewModel.shared
    
    
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
                    
                    Text("Bank Details")
                        .font(.customfont(.extraBold, fontSize: 25))
                       
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(width: 30, height: 30)

                }
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    
                    
                    LineTextField( title: "Bank Name" , placholder: "Ex: SBI" , txt: $proVM.txtBankName)
                        .padding(.bottom, 8)
                    
                    LineTextField( title: "Account Holder Name" , placholder: "Ex: Amit Patel" , txt: $proVM.txtAccountHolderName)
                        .padding(.bottom, 8)
                    
                    
                    
                    LineTextField( title: "Account Number" , placholder: "Ex: A12345645564" , txt: $proVM.txtAccountNumber)
                        .padding(.bottom, 8)
                    
                    
                    LineTextField( title: "Swift/IFSC Code", placholder: "000000000",  txt: $proVM.txtSwiftCode)
                        .padding(.bottom, 15)
                    
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
                        
                        Button {
                            proVM.updateBankDetailAction()
                        } label: {
                            Text("SAVE")
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
        .onAppear(){
            proVM.getBankDetailApi()
        }
        .alert(isPresented: $proVM.showError, content: {
            
            Alert(title: Text("Driver App"), message: Text(proVM.errorMessage), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct BankDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BankDetailsView()
    }
}
