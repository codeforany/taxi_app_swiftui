//
//  LineTextField.swift
//  taxi_driver
//
//  Created by CodeForAny on 18/09/23.
//

import SwiftUI

struct LineTextField: View {
    @State var title: String = "Title"
    @State var placholder = "Placholder"
    @Binding var txt: String
    @State var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(spacing:4){
            Text(title)
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.placeholder)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(placholder, text: $txt)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .frame(height: 30)
            
            Divider()
        }
    }
}

struct LineTextField_Previews: PreviewProvider {
    @State static var txt = ""
    static var previews: some View {
        LineTextField( txt: $txt)
    }
}


struct LineSecureField: View {
    @State var title: String = "Title"
    @State var placholder = "Placholder"
    @Binding var txt: String
    @Binding var isShowPassword: Bool
    
    var body: some View {
        VStack(spacing:4){
            Text(title)
                .font(.customfont(.regular, fontSize: 14))
                .foregroundColor(.placeholder)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if(isShowPassword) {
                TextField(placholder, text: $txt)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .frame(height: 30)
            }else{
                SecureField(placholder, text: $txt)
                    .autocapitalization(.none)
                    .modifier(ShowButton(isShow: $isShowPassword))
                    .frame(height: 30)
            }
            Divider()
        }
    }
}

struct LineSecure_Previews: PreviewProvider {
    @State static var txt = ""
    @State static var isShow = false
    static var previews: some View {
        LineSecureField( txt: $txt, isShowPassword: $isShow)
    }
}
