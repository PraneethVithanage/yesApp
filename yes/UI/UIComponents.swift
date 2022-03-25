//
//  UIComponents.swift
//  yes
//
//  Created by Erandra Jayasundara on 2021-07-12.
//

import SwiftUI

struct AudioProgress: View {
    @State var progress: CGFloat = 10.0
    var body: some View {
        ZStack (alignment:.leading){
            Color.bgHomeDj
                .frame(height: 4)
            Color.redMain
                .frame(width: (UIScreen.main.bounds.width / 100) * progress,height: 4)
        }
    }
}

