//
//  OTPTextField.swift
//  taxi_driver
//
//  Created by CodeForAny on 18/09/23.
//

import SwiftUI

struct OTPTextField: View {
    
    @Binding var txtOTP: String
    @State var placeholder = "-"
    
    var body: some View {
        ZStack{
            
            
            HStack{
                
                Spacer()
                var otpCode = txtOTP.map{ String($0) }
                
                ForEach(0..<6) { index in
                    VStack{
                        
                        if( index < otpCode.count ) {
                            Text(otpCode[index])
                                .font(.customfont(.bold, fontSize: 16))
                                .padding(15)
                        }else {
                            Text(placeholder)
                                .font(.customfont(.bold, fontSize: 16))
                                .padding(15)
                        }
                        Divider()
                    }
                    .frame(width: 45, height: 50)
                }
                Spacer()
                
            }
            
            TextField("", text: $txtOTP)
                .keyboardType(.numberPad)
                .foregroundColor(.clear)
                .accentColor(.clear)
            
        }
    }
}

struct OTPTextField_Previews: PreviewProvider {
    
    @State static var txtCode = ""
    static var previews: some View {
        OTPTextField( txtOTP: $txtCode)
    }
}
