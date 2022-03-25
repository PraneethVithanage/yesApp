
//  EventPromoRawView.swift
//  yes
//
//  Created by MacBook on 2021-12-21.
//

import SwiftUI
import Kingfisher

struct EventPromoRawView: View {
    
    var imageUrl : String
    var title : String
    
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.top)
            
            VStack  {
                
                let url = URL(
                    string: imageUrl
                )
                
                KFImage(url)
                    .resizable()
                    .scaledToFit()
                
                HStack () {
                    
                    Text(title)
                        .foregroundColor(.white)
                        .font(Font.body)
                        .fixedSize(horizontal: false, vertical: true)
                    
//                    Spacer()
//                    Button("Promote") {
//                        print("Button tapped!")
//                    }
//                    .frame(width:UIScreen.main.bounds.width/5,alignment: .center)
//                    .padding(10)
//                    .font(Font.body)
//                    .foregroundColor(.black)
//                    .background(Color.white)
//                    .font(Font.body.weight(.medium))
                    
                }.padding(10)
            }
        }
    }
}



