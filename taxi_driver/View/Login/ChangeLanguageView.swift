//
//  ChangeLanguageView.swift
//  taxi_driver
//
//  Created by CodeForAny on 17/09/23.
//

import SwiftUI

struct ChangeLanguageView: View {
    
    
    @State var listArr = ["Arabic", "Chinese", "English", "Korean", "Hindi"]
    @State var selectIndex = 2
    @State var showWelcome = false
   

    
    var body: some View {
        ZStack{
            
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Change language")
                        .font(.customfont(.extraBold, fontSize: 25))
                    
                    
                    ForEach(0..<listArr.count, id: \.self) { index in
                        
                        Button {
                            selectIndex = index
                            showWelcome = true
                        } label: {
                            HStack {
                                Text(listArr[index])
                                    .font(.customfont(.regular  , fontSize: 16))
                                    .foregroundColor( selectIndex == index ? Color.primaryApp : Color.primaryText )
                                
                                Spacer()
                                
                                if(index == selectIndex) {
                                    Image("check_tick")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                }
                            }
                            .frame(maxWidth: .infinity, minHeight: 40 , alignment: .leading)
                        }
                    }
                }
                .foregroundColor(Color.primaryText)
                .padding(.top, .topInsets + 46)
                .padding(.horizontal, 20)
                
            }
        }
        .background( NavigationLink(destination: WelcomeView() , isActive: $showWelcome, label: {
            EmptyView()
        }))
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            ChangeLanguageView()
        }
        
    }
}
