//
//  DocumentRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 19/09/23.
//

import SwiftUI


struct DocumentRow: View {
        
    @State var dObj: DocumentModel = DocumentModel(obj: [:])
    var didInfo: ( ()->() )?
    var didAction: ( ()->() )?
    
    var body: some View {
        
        let status = dObj.data.value(forKey: "status") as? Int ?? -1
        
        VStack{
            
            
            HStack(alignment: .top){
                
                VStack{
                    HStack{
                        Text(dObj.data.value(forKey: "name") as? String ?? "" )
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
                    
//                    Text(dObj["detail"] as? String ?? "" )
//                        .font(.customfont(.regular, fontSize: 15))
//                        .foregroundColor(.secondaryText)
//                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if(status == 2) {
                    Image("check_tick")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
//                    Button {
////                        didAction?()
//                    } label: {
//                        Image("more")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 20, height: 20)
//                    }
                    
                }else if (status == -1) {
                    Button {
                        didAction?()
                    } label: {
                        Text("UPLOAD" )
                            .font(.customfont(.semiBold, fontSize: 16))
                            .foregroundColor(.primaryApp)
                    }
                }else if (status == 0){
                    Text("Peding" )
                        .font(.customfont(.semiBold, fontSize: 16))
                        .foregroundColor(.blue)
                }else{
                    Text(status == 3 ? "Unapproved" : status == 4 ? "Expiry in 15 days"  : "Expired" )
                        .font(.customfont(.semiBold, fontSize: 16))
                        .foregroundColor(.red)
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
