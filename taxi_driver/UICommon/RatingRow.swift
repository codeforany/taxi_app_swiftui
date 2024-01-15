//
//  RatingRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 18/10/23.
//

import SwiftUI

struct RatingRow: View {
    @State var rate: Int = 1
    @State var message: String = "Thank you"
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(1...5, id: \.self) { i in
                    Image(systemName: "star.fill")
                        .foregroundColor( i <= rate ? Color.primaryApp : Color.lightGray )
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if(message != "") {
                Text(message)
                    .font(.customfont(.regular, fontSize: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
                .padding(.top, 10)
        }
    }
}

#Preview {
    RatingRow()
}
