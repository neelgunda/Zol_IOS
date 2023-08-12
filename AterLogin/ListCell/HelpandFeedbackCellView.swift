//
//  HelpandFeedbackCellView.swift
//  Zol
//
//  Created by apple on 01/09/22.
//

import Foundation
import SwiftUI
struct HelpandFeedbackCellView: View {
    var cellImage = String()
    var tileText = String()

    var body: some View {
        HStack (spacing: 20){
            Image(self.cellImage).resizable().scaledToFit()
                .frame(width: 30, height: 30)
            Text(self.tileText).font(Font.custom("Poppins-Medium", size: 20))
        }.frame(height: 40)
    }
}
