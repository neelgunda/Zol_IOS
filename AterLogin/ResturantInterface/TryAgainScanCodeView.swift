//
//  TryAgainScanCodeView.swift
//  Zol
//
//  Created by apple on 03/11/22.
//

import SwiftUI

struct TryAgainScanCodeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var scanAgain:Bool
    var body: some View {
        Spacer()
        VStack(spacing:40 ){
            Text("").frame(width: 70,height: 10).background(Color("#ABABAB")).cornerRadius(5).padding(.top,16)
            ZStack{
                VStack(spacing:20){
                    Image("bi_upc-scan 1").frame(width: 60,height: 60)
                    Text("INVALID QR CODE").font(Font.custom("Poppins-Medium", size: 18)).foregroundColor(Color("#FF0000"))
                }
            }
            .frame(minWidth: 80, maxWidth: .infinity, minHeight: 170)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(style: StrokeStyle(lineWidth: 0.7, dash: [6])).foregroundColor(Color("#E1E1E1"))
            ).padding(.horizontal, 10)
            
            Button(action: {
                self.scanAgain = true
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Scan Again").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).frame(minWidth: 80, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
            }
        }.padding([.trailing,.leading,.bottom],36).background(Color.white).cornerRadius(40, corners: [.topLeft, .topRight])
    }
}

