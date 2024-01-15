//
//  DocumentRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 19/09/23.
//

import SwiftUI

enum DocumentStatus {
case upload
case uploading
case uploaded
}

struct DocumentRow: View {
        
    @State var dObj: [String:Any] = [:]
    @State var type: DocumentStatus = .upload
    var didInfo: ( ()->() )?
    var didAction: ( ()->() )?
    
    var body: some View {
        VStack{
            
            
            HStack(alignment: .top){
                
                VStack{
                    HStack{
                        Text(dObj["name"] as? String ?? "" )
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Button {
                            didInfo?()
                        } label: {
                            Image("info")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(dObj["detail"] as? String ?? "" )
                        .font(.customfont(.regular, fontSize: 15))
                        .foregroundColor(.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if(type == .uploaded) {
                    Image("check_tick")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Button {
                        didAction?()
                    } label: {
                        Image("more")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                }else if (type == .uploading) {
                    ZStack{
                        Circle()
                            .stroke( Color.lightGray, lineWidth: 4)
                        
                        Circle()
                            .trim(from: 0, to: 0.25)
                            .stroke( Color.primaryApp, lineWidth: 4)
                    }
                    .frame(width: 30, height: 30)
                }else{
                    Button {
                        didAction?()
                    } label: {
                        Text("UPLOAD" )
                            .font(.customfont(.semiBold, fontSize: 16))
                            .foregroundColor(.primaryApp)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
        }
    }
}

struct DocumentRow_Previews: PreviewProvider {
    static var previews: some View {
        DocumentRow()
    }
}
