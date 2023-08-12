//
//  DashBoaderView.swift
//  Zol
//
//  Created by apple on 02/09/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BrCodeView: View {
    @Binding var outletModel:OutletModel
    var body: some View {
        
        ZStack{
            VStack(spacing:10){
                if self.outletModel.bar_code != nil{
                    Image(uiImage: UIImage(data: self.getQRCodeDate(text: "\(self.outletModel.bar_code ?? "")-\(self.outletModel.user_id.unsafelyUnwrapped)")!)!).resizable().scaledToFit().frame(width: 150, height: 150).padding(.vertical,10.0)
                }
                Divider().padding(.horizontal, 40)
                Text("VOUCHER ID").font(Font.custom("Poppins-Regular", size: 11)).foregroundColor(Color("#C6C6C6"))
                Text(self.outletModel.bar_code ?? "").font(Font.custom("Poppins-SemiBold", size: 14)).foregroundColor(Color.black).padding(.top, -5.0)
            }
        }
        .frame(height: 250)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 0.7, dash: [6])).foregroundColor(Color("#E1E1E1"))
        ).padding(.horizontal, 10)
    }
    
    func getQRCodeDate(text: String) -> Data? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let data = text.data(using: .ascii, allowLossyConversion: false)
        filter.setValue(data, forKey: "inputMessage")
        guard let ciimage = filter.outputImage else { return nil }
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledCIImage = ciimage.transformed(by: transform)
        let uiimage = UIImage(ciImage: scaledCIImage)
        return uiimage.pngData()!
    }
    
}
