//
//  HelpRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 20/10/23.
//

import SwiftUI

struct HelpRow: View {
    @State var title: String = "title"
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.customfont(.regular, fontSize: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.blue)
                
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            
            Divider()
        }
        
        .padding(.vertical, 15)
    }
}

#Preview {
    HelpRow()
}
