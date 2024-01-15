//
//  TitleSubtitleRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 12/10/23.
//

import SwiftUI

struct TitleSubtitleRow: View {
    var title: String = "Title"
    var subtitle: String = "Subtitle"
    var color: Color = .primaryText
    var fontWeight: NunitoSans = .regular
    
    var body: some View {
        HStack{
          
            Text(title)
                .font(.customfont(fontWeight, fontSize: 15))
                .foregroundColor(color)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
            Text(subtitle)
                .font(.customfont(fontWeight, fontSize: 15))
                .foregroundColor(color)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 2)
        
    }
}

#Preview {
    TitleSubtitleRow()
}
