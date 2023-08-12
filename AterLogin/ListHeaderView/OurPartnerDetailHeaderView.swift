//
//  OurPartnerDetailHeaderView.swift
//  Zol
//
//  Created by apple on 03/09/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct OurPartnerDetailHeaderView: View {
    @Environment(\.presentationMode) var presentation
    var partnerModel:PartnerModel?
    var body: some View {
        ZStack(alignment: .topLeading, content: {
            VStack(alignment:.leading,spacing: 22){
                if UIDevice.isIPad == true{
                    WebImage(url: URL(string: self.partnerModel?.image ?? ""),options: .continueInBackground).placeholder(Image("istockphoto-1147544807-612x612").resizable()).resizable().cornerRadius(20, antialiased: true).frame(width: (UIScreen.screenWidth - 40),height: 400)
                }
                else{
                    WebImage(url: URL(string: self.partnerModel?.image ?? ""),options: .continueInBackground).placeholder(Image("istockphoto-1147544807-612x612").resizable()).resizable().scaledToFit().cornerRadius(20, antialiased: true)
                }
    
                Text(partnerModel?.name ?? "").font(Font.custom("Poppins-SemiBold", size: 30)).textCase(.none).foregroundColor(Color.black).padding(.horizontal,15).padding(.vertical, -8)
                Text(self.partnerModel?.description ?? "").font(Font.custom("Poppins-Regular", size: 15)).textCase(.none).foregroundColor(Color("#818181")).padding(.bottom, 10).padding(.horizontal,15)
                
                Label(self.partnerModel?.location ?? "",image: "Vector-14").font(Font.custom("Poppins-Medium", size: 15)).foregroundColor(Color.black).padding(.horizontal,15)
                Button(action: {
                    guard let url = URL(string:  "tel://" + (self.partnerModel?.phone ?? "")) else { return }
                    UIApplication.shared.open(url)
                }) {
                    Label(self.partnerModel?.phone ?? "",image: "Vector-13").font(Font.custom("Poppins-Medium", size: 15)).foregroundColor(Color.black).padding(.horizontal,15)
                }
                
                Button(action: {
                    if (self.partnerModel?.website_link?.contains("https://") == true){
                        if let url = URL(string: (self.partnerModel?.website_link ?? "")) {
                            UIApplication.shared.open(url)
                        }
                    }
                    else{
                        if let url = URL(string: "https://" + (self.partnerModel?.website_link ?? "")) {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                }) {
                    Label(self.partnerModel?.website_link ?? "",image: "Vector-12").font(Font.custom("Poppins-Medium", size: 15)).padding(.horizontal,15).textCase(.none).foregroundColor(.black)
                }
                
            }
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image("Vector-15").padding(.leading, 18).padding(.top, 30)
            }
        })
    }
}



