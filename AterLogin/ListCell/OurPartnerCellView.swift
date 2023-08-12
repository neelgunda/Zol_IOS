//
//  OurPartnersView.swift
//  Zol
//
//  Created by apple on 31/08/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct OurPartnersView: View {
    @Binding var partnerDetailDict : PartnerModel
    var body: some View {
        HStack(alignment: .center,spacing:20){
            WebImage(url: URL(string: self.partnerDetailDict.image ?? ""),options: .continueInBackground).placeholder(Image("istockphoto-1147544807-612x612").resizable()).resizable().scaledToFill().frame(width: 70, height: 70, alignment: .trailing).cornerRadius(10, antialiased: true).padding([.top, .leading, .bottom], 14.0)
            VStack (alignment: .leading, spacing: 2){
                Text(self.partnerDetailDict.name ?? "").font(Font.custom("Poppins-SemiBold", size: 20))
                Text(self.partnerDetailDict.description ?? "").font(Font.custom("Poppins-Regula", size: 12)).foregroundColor(Color("#818181")).padding(.trailing, 10.0).lineLimit(3)
            }.frame(minWidth: 100,  maxWidth: .infinity, minHeight: 50, maxHeight: .infinity, alignment: .leading)
        }.background(Color.white).cornerRadius(17, antialiased: false).padding(.bottom,10).shadow(color: Color("Shadow"),radius: 14,x: 0,y: 0).background(
            NavigationLink(destination:OurPartnerDetailView(partnerId: self.partnerDetailDict.id ?? "0")) {EmptyView()}.opacity(0.0)
        )
    }
}
