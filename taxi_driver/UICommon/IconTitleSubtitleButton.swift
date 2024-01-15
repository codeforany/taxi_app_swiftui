//
//  IconTitleSubtitleButton.swift
//  taxi_driver
//
//  Created by CodeForAny on 07/10/23.
//

import SwiftUI

struct IconTitleSubtitleButton: View {
    var icon: String = "acceptance"
    var title: String = "Title"
    var subtitle: String = "Subtitle"
    
    var body: some View {
        VStack{
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20, alignment: .center)
            
            Text(title)
                .font(.customfont(.extraBold, fontSize: 18))
                .foregroundColor(Color.primaryText)
            
            Text(subtitle)
                .font(.customfont(.regular, fontSize: 16))
                .foregroundColor(Color.secondaryText)
        }
        .frame(maxWidth: .infinity,
               alignment: .center)
    }
}

#Preview {
    IconTitleSubtitleButton()
}
