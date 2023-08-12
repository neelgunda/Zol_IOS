//
//  HomeCell.swift
//  Zol
//
//  Created by apple on 07/10/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct HomeCell: View {
    @Binding var outlet:OutletModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("")
                Text(self.outlet.deal_title ?? "").font(Font.custom("Poppins-SemiBold", size: 18)).foregroundColor(Color.black).padding(.leading,15)
                HStack(spacing: 6){
                    Text("@\(self.outlet.name ?? "0")").font(Font.custom("Poppins-Medium", size: 14)).foregroundColor(Color.black).padding(.leading,15)
                }
                HStack(spacing: 6){
                    Image("offer 2").padding(.leading,15)
                    if Int(self.outlet.offer_left ?? "0")! > 1{
                        Text("\(self.outlet.offer_left ?? "0") offers left").font(Font.custom("Poppins-Regular", size: 13)).foregroundColor(Color("#FF008C"))
                    }
                    else{
                        Text("\(self.outlet.offer_left ?? "0") offer left").font(Font.custom("Poppins-Regular", size: 13)).foregroundColor(Color("#FF008C"))
                    }
                }
                Text(self.outlet.deal_description ?? "").font(Font.custom("Poppins-Regular", size: 13)).foregroundColor(Color("#818181")).frame(minWidth: 100,maxWidth: .infinity,minHeight: 10,maxHeight: .infinity,alignment: .leading).padding([.leading,.bottom],15)
            })
            WebImage(url: URL(string: self.outlet.deal_image ?? ""),options: .continueInBackground).resizable().scaledToFill().frame(width: 110, height: 110, alignment: .center).cornerRadius(10).padding(.trailing, 11).background(Color.clear)
        }
        .background(Color.white).cornerRadius(10, antialiased: false).shadow(color:Color("Shadow") ,radius: 14,x: 0,y: 0).background(
            NavigationLink(destination: BrCodeDetailView(id: self.$outlet.deal_id.toUnwrapped(defaultValue: ""),backIsHome: true)) {EmptyView()}.opacity(0)
        )
    }
}
