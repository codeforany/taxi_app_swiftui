//
//  VehicleDocumentRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/10/23.
//

import SwiftUI

struct VehicleDocumentRow: View {
    @State var dObj: NSDictionary = [:]
    
    var body: some View {
        
        
            VStack(alignment: .leading, spacing:4){
                
                let color = dObj.value(forKey: "status_color") as? Color ?? Color.redApp
                HStack(spacing:15) {
                    Text(dObj.value(forKey: "name") as? String ?? "")
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(Color.primaryText)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                    
                    Text(dObj.value(forKey: "status") as? String ?? "")
                        .font(.customfont(.semiBold, fontSize: 10))
                        .foregroundColor(color)
                    
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background( color.opacity(0.3) )
                        .overlay( RoundedRectangle(cornerRadius: 5).stroke(color, lineWidth: 1) )
                        .cornerRadius(5)
                }
                
                Text(dObj.value(forKey: "descrition") as? String ?? "")
                    .font(.customfont(.regular, fontSize: 15))
                    .foregroundColor(Color.secondaryText)
                    .padding(.bottom, 8)
                
                Divider()
            }
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            
        
    }
}

#Preview {
    VehicleDocumentRow(dObj: [
        
        "name": "Vehicle Loan EMI Details",
        "descrition": "Incorrect document type",
        "status":"NOT APPROVED",
        "status_color": Color.redApp
        
    ])
}
