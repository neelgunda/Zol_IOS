//
//  WelComeHomeView.swift
//  Zol
//
//  Created by apple on 31/08/22.
//

import Foundation
import SwiftUI
struct WelComeHomeView: View {    
    var body: some View {
        VStack {
            HStack(spacing: 7) {
                Text("Welcome").font(Font.custom("Poppins-Regular", size: 30)).foregroundColor(Color("#A8A8A8"))
                Text("James !").font(Font.custom("Poppins-SemiBold", size: 30))
            }.padding([.top,.leading], 30.0).frame(minWidth: 100, maxWidth: .infinity,alignment: .leading)
            Spacer()
            Image("Group 31").resizable().scaledToFit()
            Button(action: {}) {
                Text("Buy Zol Card").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
            }.padding([.leading, .trailing], 30.0)
            Spacer()
        }
    }
}
