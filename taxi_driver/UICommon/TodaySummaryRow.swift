//
//  TodaySummaryRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 14/10/23.
//

import SwiftUI

struct TodaySummaryRow: View {
    @State var sObj: NSDictionary = [
        "time": "6:32",
        "am_pm": "AM",
        "name": "Pembroke Dock",
        "detail": "Paid by card",
        "price": "$40"
      ]
    
    var body: some View {
        
        VStack {
            HStack(spacing:15) {
                VStack(spacing:4){
                  
                    Text(sObj.value(forKey: "time") as? String ?? "" )
                        .font(.customfont(.regular, fontSize: 15))
                        .foregroundColor(Color.primaryText)
                    
                    Text(sObj.value(forKey: "am_pm") as? String ?? "")
                        .font(.customfont(.bold, fontSize: 11))
                        .foregroundColor(Color.secondaryText)
                        .padding(.horizontal, 8)
                        .background(Color.lightWhite)
                        .cornerRadius(5)
                }
                
                VStack(alignment: .leading, spacing:8){
                  
                    Text(sObj.value(forKey: "name") as? String ?? "")
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(Color.primaryText)
                    
                    Text(sObj.value(forKey: "detail") as? String ?? "")
                        .font(.customfont(.regular, fontSize: 15))
                        .foregroundColor(Color.secondaryText)
                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                
                Text(sObj.value(forKey: "price") as? String ?? "" )
                    .font(.customfont(.regular, fontSize: 15))
                    .foregroundColor(Color.primaryText)
            }
            
            Divider()
        }
    }
        
}

#Preview {
    TodaySummaryRow()
}
