//
//  TitleSubtitleButton.swift
//  taxi_driver
//
//  Created by CodeForAny on 12/10/23.
//

import SwiftUI

struct TitleSubtitleButton: View {
    var title: String = "Title"
    var subtitle: String = "Subtitle"
    
    var body: some View {
        VStack{
          
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
    TitleSubtitleButton()
}
