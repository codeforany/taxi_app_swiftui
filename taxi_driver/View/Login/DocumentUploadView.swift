//
//  DocumentUploadView.swift
//  taxi_driver
//
//  Created by CodeForAny on 19/09/23.
//

import SwiftUI

struct DocumentUploadView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var dVM = DocumentViewModel.shared
    
    
    @State var showImagePicker = false
    @State var showPhotoLibrary = false
    @State var showCamera = false
    
    @State var selectDoc: DocumentModel  = DocumentModel(obj: [:])
        
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
                    
                    Text("Personal Document")
                        .font(.customfont(.extraBold, fontSize: 25))
                       
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                        .frame(width: 30, height: 30)

                }
                .padding(.top, .topInsets + 8)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    
                    ForEach(dVM.docArr, id: \.id ) { dObj in
                        
                        DocumentRow(dObj: dObj, didAction:  {
                            selectDoc = dObj
                            self.showImagePicker = true
                        })
                    }
                    .padding(.bottom, 15)
                    
                    
                    
                }
                .foregroundColor(Color.primaryText)
                .padding(.horizontal, 20)
                
            }
        }
        .sheet(isPresented: $showCamera, content: {
            ImagePicker(sourceType: .camera) {
                sImage in
                
                dVM.uploadDocAction(obj: selectDoc.data, img: sImage)
            }
        })
        .sheet(isPresented: $showPhotoLibrary, content: {
            ImagePicker(sourceType: .photoLibrary) {
                sImage in
                
                dVM.uploadDocAction(obj: selectDoc.data, img: sImage)
            }
        })
        .actionSheet(isPresented: $showImagePicker, content: {
            
            ActionSheet(title: Text("Select"), buttons: [
                .default(Text("Photo Library")) {
                    showPhotoLibrary = true
                },
                
                .default(Text("Camera")) {
                        showCamera = true
                }
                
            ,
                .destructive(Text("Cancel")) {
                    
                }
                
            ])
        })
        .alert(isPresented: $dVM.showError, content: {
            Alert(title: Text("Driver App"), message: Text( dVM.errorMessage ), dismissButton: .default(Text("OK")) {
                
            } )
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct DocumentUploadView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentUploadView()
    }
}
