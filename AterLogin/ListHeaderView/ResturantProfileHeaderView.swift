//
//  ResturantProfileHeaderView.swift
//  Zol
//
//  Created by apple on 13/10/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ResturantProfileHeaderView: View {
    var userModel:UserModel
    @State private var willMoveToMyCardView: Bool = false
    var body: some View {
        VStack{
            Button(action: {
                print("sf")
                self.willMoveToMyCardView = true
            }) {
                WebImage(url: URL(string: self.userModel.image ?? ""),options: .continueInBackground).placeholder(Image("ic_profile_ph").resizable()).resizable().scaledToFill().frame(width: 155, height: 155, alignment: .center).cornerRadius(77.5, antialiased: true).padding(.bottom, 7)
            }
            Text(self.userModel.name ?? "").font(Font.custom("Poppins-SemiBold", size: 22)).foregroundColor(Color.black).textCase(.none)
            Divider()
        }.padding(.bottom,5).background(
            NavigationLink(destination: OurPartnerDetailView(partnerId: AppDefaults.userID ?? "0"), isActive: self.$willMoveToMyCardView) {EmptyView()}.opacity(0)
        )
    }
}


