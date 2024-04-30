//
//  VehicleRow.swift
//  taxi_driver
//
//  Created by CodeForAny on 16/10/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct VehicleRow: View {
    @State var vObj: NSDictionary = [:]
    var didAction: ( () ->() )?
    
    var body: some View {
        
        VStack {
            HStack(spacing:15) {
                
               
                
                VStack(alignment: .leading, spacing:8){
                  
                    HStack{ 
                        Text("\(vObj.value(forKey: "brand_name") as? String ?? "") - \(vObj.value(forKey: "model_name") as? String ?? "") - \(vObj.value(forKey: "series_name") as? String ?? "")")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(Color.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading )
                        
                        if(vObj.value(forKey: "is_set_running") as? Int ?? 0 == 1) {
                            Image(systemName: "car")
                                .foregroundColor(Color.primaryApp)
                        }
                        
                        
                    }
                    
                    Text(vObj.value(forKey: "car_number") as? String ?? "")
                        .font(.customfont(.regular, fontSize: 15))
                        .foregroundColor(Color.secondaryText)
                    
                    
                }
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                
                WebImage(url: URL(string:  vObj.value(forKey: "car_image") as? String ?? "" ))
                    .resizable()
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(5)
                    .clipped()
                
                
                    
               
            }
            .onTapGesture {
                didAction?()
            }
            
            Divider()
        }
    }
}

#Preview {
    VehicleRow()
}
