//
//  HelpandFeedbackHeightView.swift
//  Zol
//
//  Created by apple on 01/09/22.
//

import Foundation
import SwiftUI

struct HelpandFeedbackHeightView: View {
    var title:String?
    var body: some View {
        VStack{
            Text(self.title ?? "").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color.black).textCase(.none)
        }.frame(height:30)
        
    }
}
