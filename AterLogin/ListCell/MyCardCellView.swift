//
//  MyCardCellView.swift
//  Zol
//
//  Created by apple on 01/09/22.
//

import Foundation
import SwiftUI

struct MyCardCellView: View {
    @Binding var cardModel : CardModel
    
    var body: some View {
        HStack(alignment: .top,spacing:20){
            Image("ic_card_dummy").resizable().scaledToFit().frame(width: 70, height: 70, alignment: .trailing).cornerRadius(10, antialiased: true).padding([.top, .leading, .bottom], 14.0)
            VStack (alignment: .leading, spacing: 10){
                Text(self.cardModel.brand ?? "").font(Font.custom("Poppins-Medium", size: 18))
                Text("**** **** **** ***\(self.cardModel.last_four_digits ?? "")  \(self.cardModel.expiration_month ?? "")/\(self.cardModel.expiration_year ?? "")").font(Font.custom("Poppins-Regular", size: 13)).foregroundColor(Color("#818181")).padding(.trailing, 10.0)
            }.frame(minWidth: 100,  maxWidth: .infinity, minHeight: 4, maxHeight: .infinity, alignment: .leading)
        }
    }
}
