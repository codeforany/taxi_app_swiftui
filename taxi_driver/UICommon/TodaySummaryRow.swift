//
//  TodaySummaryRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 14/10/23.
//

import SwiftUI

struct TodaySummaryRow: View {
    @State var sObj: NSDictionary = [:]
    
    var body: some View {
        
        VStack {
            HStack(spacing:15) {
                VStack(spacing:4){
                    
                    let rideDate = (sObj.value(forKey: "start_time" ) as? String ?? "" ).date
                  
                    Text(rideDate.timeOnly)
                        .font(.customfont(.regular, fontSize: 15))
                        .foregroundColor(Color.primaryText)
                    
                    Text(rideDate.ampmOnly)
                        .font(.customfont(.bold, fontSize: 11))
                        .foregroundColor(Color.secondaryText)
                        .padding(.horizontal, 8)
                        .background(Color.lightWhite)
                        .cornerRadius(5)
                }
                
                VStack(alignment: .leading, spacing:8){
                  
                    Text(sObj.value(forKey: "pickup_address") as? String ?? "")
                        .lineLimit(1)
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(Color.primaryText)
                    
                    Text("Paid by \( sObj.value(forKey: "payment_type") as? Int ?? 0 == 1 ? "cash" : "online"  )")
                        .font(.customfont(.regular, fontSize: 15))
                        .foregroundColor(Color.secondaryText)
                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                
                Text("$\( Double( "\( sObj.value(forKey: "amt") ?? "0.0" )" )  ?? 0.0 , specifier: "%.2f" )" )
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
