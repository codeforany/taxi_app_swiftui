//
//  WeeklySummaryRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 14/10/23.
//

import SwiftUI

struct WeeklySummaryRow: View {
    @State var sObj: NSDictionary = ["time": "Mon, 28 Sep", "trips": "25", "price": "$40"]
    
    var body: some View {
        
        VStack {
            HStack(spacing:15) {
                
                
                VStack(alignment: .leading, spacing:8){
                  
                    Text(sObj.value(forKey: "time") as? String ?? "")
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(Color.primaryText)
                    
                    Text("\(sObj.value(forKey: "trips") as? String ?? "") Trips")
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
    WeeklySummaryRow()
}
