//
//  SettingRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/10/23.
//

import SwiftUI

struct SettingRow: View {
    var icon: String = "acceptance"
    var title: String = "Title"
    
    var body: some View {
        HStack{
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25, alignment: .center)
            
            Text(title)
                .font(.customfont(.regular, fontSize: 16))
                .foregroundColor(Color.primaryText)
            
           
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
    }
}

#Preview {
    SettingRow()
}
