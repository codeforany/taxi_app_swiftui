//
//  AddVehicleView.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/09/23.
//

import SwiftUI

struct AddVehicleView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var carVM = CarViewModel.shared
    
    
    @State var showImagePicer = false
    @State var showPhotoLibrary = false
    @State var showCamera = false
    
    

    
    
    
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
                    
                    Text("Add Vehcle")
                        .font(.customfont(.extraBold, fontSize: 25))
                       
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(width: 30, height: 30)

                }
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    
                    VStack(spacing:4){
                        Text("Brand")
                            .font(.customfont(.regular, fontSize: 14))
                            .foregroundColor(.placeholder)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Menu {
                            
                            ForEach(0..<carVM.brandList.count, id: \.self ) {
                                index in
                                if let cObj = carVM.brandList[index] as? NSDictionary {
                                    Button(action: {
                                        carVM.selectBrand = cObj
                                        carVM.selectModel = nil
                                        carVM.selectSeries = nil
                                        if cObj.value(forKey: "brand_id") as? Int ?? -1 == 0 {
                                            
                                            carVM.selectOtherFlag = 1
                                        }
                                        
                                        carVM.getModelList()
                                    }, label: {
                                        
                                        Text( cObj.value(forKey: "brand_name") as? String ?? "")
                                    })
                                }
                                
                            }
                            
                        } label: {
                            
                            let brandName = carVM.selectBrand?.value(forKey: "brand_name") as? String ?? ""
                            
                            HStack {
                                Text( brandName == "" ? "Select Brand" : brandName )
                                    .font(.customfont(.medium, fontSize: 17))
                                    .foregroundColor( brandName == "" ? .placeholder : .primaryText)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Image(systemName: "arrowtriangle.down.fill")
                                    .font(.system(size: 12))
                            }
                            
                        }
                        
                        Divider()
                    }
                    .padding(.bottom, 8)
                    
                    

                    
                    if( carVM.selectBrand?.value(forKey: "brand_id") as? Int ?? -1 == 0 ) {
                        LineTextField( title: "Enter Brand" , placholder: "Ex: BMW" , txt: $carVM.txtBrandName)
                            .padding(.bottom, 8)
                    }
                    
                    
                    
                    if !(carVM.selectBrand?.value(forKey: "brand_id") as? Int ?? -1 == 0 ) {
                        VStack(spacing:4){
                            Text("Model")
                                .font(.customfont(.regular, fontSize: 14))
                                .foregroundColor(.placeholder)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Menu {
                                ForEach(0..<carVM.modelList.count, id: \.self ) {
                                    index in
                                    if let cObj = carVM.modelList[index] as? NSDictionary {
                                        Button(action: {
                                            carVM.selectModel = cObj
                                            carVM.selectSeries = nil
                                            if cObj.value(forKey: "model_id") as? Int ?? -1 == 0 {
                                                
                                                carVM.selectOtherFlag = 2
                                            }
                                            carVM.getSeriesList()
                                            
                                        }, label: {
                                            
                                            Text( cObj.value(forKey: "model_name") as? String ?? "")
                                        })
                                    }
                                    
                                }
                            } label: {
                                
                                let modelName = carVM.selectModel?.value(forKey: "model_name") as? String ?? ""
                                
                                HStack {
                                    Text( modelName == "" ? "Select Model" : modelName)
                                        .font(.customfont(.medium, fontSize: 17))
                                        .foregroundColor( modelName == "" ? .placeholder : .primaryText )
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 12))
                                }
                                
                            }
                            
                            Divider()
                        }
                        .padding(.bottom, 8)
                    }
                    
                    if( carVM.selectBrand?.value(forKey: "brand_id") as? Int ?? -1 == 0 || carVM.selectModel?.value(forKey: "model_id") as? Int ?? -1 == 0 ) {
                        LineTextField( title: "Enter Model" , placholder: "Ex: ABC" , txt: $carVM.txtModelName)
                            .padding(.bottom, 8)
                        
                    }
                    
                    if !(carVM.selectBrand?.value(forKey: "brand_id") as? Int ?? -1 == 0 || carVM.selectModel?.value(forKey: "model_id") as? Int ?? -1 == 0 ) {
                        VStack(spacing:4){
                            Text("Series")
                                .font(.customfont(.regular, fontSize: 14))
                                .foregroundColor(.placeholder)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Menu {
                                ForEach(0..<carVM.seriesList.count, id: \.self ) {
                                    index in
                                    if let cObj = carVM.seriesList[index] as? NSDictionary {
                                        Button(action: {
                                            carVM.selectSeries = cObj
                                            if cObj.value(forKey: "series_id") as? Int ?? -1 == 0 {
                                                
                                                carVM.selectOtherFlag = 3
                                            }
                                            
                                        }, label: {
                                            
                                            Text( cObj.value(forKey: "series_name") as? String ?? "")
                                        })
                                    }
                                    
                                }
                                
                            } label: {
                                
                                let seriesName = carVM.selectSeries?.value(forKey: "series_name") as? String ?? ""
                                
                                HStack {
                                    Text( seriesName == "" ?  "Select Series" : seriesName )
                                        .font(.customfont(.medium, fontSize: 17))
                                        .foregroundColor( seriesName == "" ? .placeholder : .primaryText )
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Image(systemName: "arrowtriangle.down.fill")
                                        .font(.system(size: 12))
                                }
                                
                            }
                            
                            Divider()
                        }
                        .padding(.bottom, 8)
                    }
                    
                    
                    if( carVM.selectBrand?.value(forKey: "brand_id") as? Int ?? -1 == 0 || carVM.selectModel?.value(forKey: "model_id") as? Int ?? -1 == 0 || carVM.selectSeries?.value(forKey: "series_id") as? Int ?? -1 == 0 ) {
                        LineTextField( title: "Enter Series", placholder: "Ex: x1",  txt: $carVM.txtManufacturer)
                            .padding(.bottom, 15)
                    }
                    
                    LineTextField( title: "Number Plat" , placholder: "Ex: YT12346" , txt: $carVM.txtNumberPlat)
                        .padding(.bottom, 8)
                    
                    
                    LineTextField( title: "Seat", placholder: "Ex Person: 4 ",  txt: $carVM.txtSeat)
                        .padding(.bottom, 15)
                    
                    
                    Button {
                        showImagePicer = true
                    } label: {
                        ZStack {
                            
                            RoundedCorner(radius: 15, corner: .allCorners)
                                .fill(Color.white)
                                .frame(width: .screenWidth - 40, height: .screenWidth - 40 , alignment: .center)
                                .shadow(radius: 2)
                            
                            if let image = carVM.selectImage {
                                Image(uiImage: image)
                                    .scaledToFill()
                                    .frame(width: .screenWidth - 40, height: .screenWidth - 40 , alignment: .center)
                                    .cornerRadius(15)
                                    .clipped()
                            }else{
                                Image(systemName: "car.fill")
                                    .font(.system(size: 100))
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            }
                        }
                    }
                    .padding(.vertical, 15 )
                    .padding(.bottom, 15)
                    
                
                    
                    VStack(alignment: .leading, spacing: 0){
                                                
                        Button {
                            carVM.addNewVehicleAction()
                        } label: {
                            Text("ADD")
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
        .onAppear() {
            carVM.getBrandList()
        }
        .alert(isPresented: $carVM.showError, content: {
            
            Alert(title: Text("Driver App"), message: Text(carVM.errorMessage), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .sheet(isPresented: $showCamera, content: {
            ImagePicker(sourceType: .camera) {
                sImage in
                
                carVM.selectImage = sImage
            }
        })
        
        .sheet(isPresented: $showPhotoLibrary, content: {
            ImagePicker(sourceType: .photoLibrary) {
                sImage in
                carVM.selectImage = sImage
                
            }
        })
        
        .actionSheet(isPresented: $showImagePicer, content: {
            ActionSheet(title: Text("Select"), buttons: [
                .default(Text("Photo Library")) {
                    showPhotoLibrary = true
                    
                },
                
                .default(Text("Camera")) {
                    showCamera = true
                    
                }
                ,
                .destructive(Text("Cancel"), action: {
                    
                })
            ])
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct AddVehicleView_Previews: PreviewProvider {
    static var previews: some View {
        AddVehicleView()
    }
}
