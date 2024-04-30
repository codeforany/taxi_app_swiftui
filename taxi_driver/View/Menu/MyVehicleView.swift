//
//  MyVehicleView.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/10/23.
//

import SwiftUI

struct MyVehicleView: View {
    @Environment(\.presentationMode) var mode:Binding<PresentationMode>
    @ObservedObject var carVM = CarViewModel.shared
    @State var showDoc = false
    
    var body: some View {
        ZStack {
            VStack{
                
                
                ZStack{
                    Text("My Vehicle")
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
                
                
                    
                    List{
                        ForEach(0..<carVM.carList.count, id: \.self, content:  { index in
                            VehicleRow(vObj: carVM.carList[index] as? NSDictionary ?? [:] , didAction: {
                                
                                DocumentViewModel.shared.selectCarGetDocList(obj:carVM.carList[index] as? NSDictionary ?? [:] )
                                self.showDoc = true
                            } )
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        carVM.deleteVehicleApi(obj: carVM.carList[index] as? NSDictionary ?? [:])
                                    } label: {
                                        VStack {
                                            Image(systemName: "trash")
                                                
                                        }
                                    }
                                    .foregroundColor(Color.white)
                                    .tint( Color.red )
                                    
                                    Button {
                                        carVM.setRunningVehicleApi(obj: carVM.carList[index] as? NSDictionary ?? [:])
                                    } label: {
                                        VStack {
                                            Image(systemName: "car.fill")
                                                
                                        }
                                    }
                                    .foregroundColor(Color.white)
                                    .tint( Color.green )

                                }
                        })
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                
                
                NavigationLink {
                    AddVehicleView()
                } label: {
                    Text("Add New")
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                .background( Color.primaryApp )
                .cornerRadius(25)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            
            
        }
        .onAppear(){
            carVM.getCarListApi()
        }
        .alert(isPresented: $carVM.showError, content: {
            
            Alert(title: Text("Driver App"), message: Text(carVM.errorMessage), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .background( NavigationLink(destination: VehicleDocumentView(), isActive: $showDoc,  label: {
            EmptyView()
        }) )
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    MyVehicleView()
}
