//
//  ProfileImageView.swift
//  taxi_driver
//
//  Created by CodeForAny on 29/12/23.
//

import SwiftUI

struct ProfileImageView: View {
        
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = LoginViewModel.shared
    
    @State var showImagePicer = false
    @State var showPhotoLibrary = false
    @State var showCamera = false
    @State var selectImage: UIImage?
    
    
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
                    
                    Text("Profile Image")
                        .font(.customfont(.extraBold, fontSize: 25))
                       
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(width: 30, height: 30)

                }
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                
                VStack(alignment: .center, spacing: 0) {
                    
                    
                    ZStack {
                        
                        RoundedCorner(radius: 100, corner: .allCorners)
                            .fill(Color.white)
                            .frame(width: 200, height: 200 , alignment: .center)
                            .shadow(radius: 2)
                        
                        if let image = selectImage {
                            Image(uiImage: image)
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .cornerRadius(100)
                                .clipped()
                        }else{
                            Image(systemName: "person.fill")
                                .font(.system(size: 100))
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                       
                            
                        
                        
                    }.padding(.vertical, 30 )
                        .onTapGesture {
                            showImagePicer = true
                        }
                    
                    Button {
                       
                    } label: {
                        Text("Next")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 45 , alignment: .center)
                    .background( Color.primaryApp )
                    .cornerRadius(25)
                    .padding(.bottom, 30)
                   
                }
                .foregroundColor(Color.primaryText)
                .padding(.horizontal, 20)
                
            }
        }
        .alert(isPresented: $loginVM.showError, content: {
            
            Alert(title: Text("Driver App"), message: Text(loginVM.errorMessage), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .sheet(isPresented: $showCamera, content: {
            ImagePicker(sourceType: .camera) {
                sImage in
                
                selectImage = sImage
                loginVM.userProfileImageUpload(image: sImage)
            }
        })
        
        .sheet(isPresented: $showPhotoLibrary, content: {
            ImagePicker(sourceType: .photoLibrary) {
                sImage in
                
                selectImage = sImage
                loginVM.userProfileImageUpload(image: sImage)
                
                
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

#Preview {
    ProfileImageView()
}
