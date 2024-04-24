//
//  WeeklySummaryRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 14/10/23.
//

import SwiftUI

struct WeeklySummaryRow: View {
    @State var sObj: NSDictionary = [:]
    
    var body: some View {
        
        VStack {
            HStack(spacing:15) {
                
                
                VStack(alignment: .leading, spacing:8){
                  
                    Text((sObj.value(forKey: "date") as? String ?? "").date.dayString)
                        .font(.customfont(.regular, fontSize: 16))
                        .foregroundColor(Color.primaryText)
                    
                    Text("Trips \(sObj.value(forKey: "trips_count") as? Int ?? 0)")
                        .font(.customfont(.regular, fontSize: 15))
                        .foregroundColor(Color.secondaryText)
                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                
                Text( "$\( Double( "\( sObj.value(forKey: "total_amt") ?? "0.0" )" )  ?? 0.0, specifier: "%.2f" )"  )
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
