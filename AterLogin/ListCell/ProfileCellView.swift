//
//  ProfileCellView.swift
//  Zol
//
//  Created by apple on 30/08/22.
//

import Foundation
import SwiftUI
struct ProfileCellView: View {
    var cellImage = String()
    var tileText = String()

    var body: some View {
        HStack (spacing: 20){
            Image(self.cellImage).resizable().scaledToFit()
                .frame(width: 22, height: 22)
            Text(self.tileText).font(Font.custom("Poppins-Medium", size: 20))
        }.frame(height: 45)
    }
}
