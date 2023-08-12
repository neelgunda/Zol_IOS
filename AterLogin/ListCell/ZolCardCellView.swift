//
//  ZolCardCellView.swift
//  Zol
//
//  Created by apple on 31/08/22.
//

import Foundation
import SwiftUI
struct ZolCardCellView: View {
    @Binding var cardCount:String
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image("Rectangle 33").resizable().minimumScaleFactor(20).frame(width: 140, height: 107, alignment: .leading).shadow(color: Color("Shadow"),radius: 20,x: 0,y: 0).padding(.leading,-10)
                VStack(alignment: .leading, spacing: 10){
                    Text("Zol Card").textCase(.none).font(Font.custom("Poppins-SemiBold", size: 21)).padding(.leading,10)
                    Text("$20").font(Font.custom("Poppins-Regular", size: 17)).padding(.leading,10)
                    HStack(alignment: .lastTextBaseline){
                        Button(action: {
                            if self.cardCount != "1"{
                                self.cardCount = "\((Int(self.cardCount) ?? 0) - 1)"
                            }
                        }) {
                            VStack(alignment: .leading, spacing: -8){
                                Text("-").font(Font.custom("Poppins-Regular", size: 22)).foregroundColor(Color("#000000"))
                            }
                        }.frame(width: 30, height: 30).overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(Color("#CDCDCD"), lineWidth: 1)
                        )
                        Text(self.$cardCount.wrappedValue).font(Font.custom("Poppins-Regular", size: 18)).padding(.horizontal, 10.0)
                        
                        Button(action: {
                            self.cardCount = "\((Int(self.cardCount) ?? 0) + 1)"
                        }) {
                            VStack(alignment: .leading, spacing: -8){
                                Text("+").font(Font.custom("Poppins-Regular", size: 22)).foregroundColor(Color("#000000"))
                            }
                        }.frame(width: 30, height: 30).overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(Color("#CDCDCD"), lineWidth: 1)
                        )
                        
                    }
                }.frame(minWidth: 100,maxWidth: .infinity,  maxHeight: 200, alignment: .leading).padding(.leading, 10)
            }.padding(.leading, 10)
        }
    }
}
