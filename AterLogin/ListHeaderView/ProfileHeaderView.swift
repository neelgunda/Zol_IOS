//
//  ProfileHeaderView.swift
//  Zol
//
//  Created by apple on 30/08/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeaderView: View {
    var userModel:UserModel
    @Binding  var willMoveToEditProfileView: Bool
    var body: some View {
        VStack{
            WebImage(url: URL(string: self.userModel.image ?? ""),options: .continueInBackground).placeholder(Image("ic_profile_ph").resizable()).resizable().scaledToFill().frame(width: 155, height: 155, alignment: .center).cornerRadius(77.5, antialiased: true).padding(.bottom, 7)
            Text(self.userModel.name ?? "").font(Font.custom("Poppins-SemiBold", size: 22)).foregroundColor(Color.black).textCase(.none)
            Text(self.userModel.email ?? "").accentColor(Color("#ABABAB")).font(Font.custom("Poppins-Regular", size: 16)).textCase(.none)
            Button(action: {
                self.willMoveToEditProfileView = true
            }) {
                HStack(alignment: .center, spacing: -8){
                    Text("Edit Profile").font(Font.custom("Poppins-SemiBold", size: 13)).font(Font.custom("Poppins-Medium", size: 14)).foregroundColor(Color("#000000")).frame(width: 100, height: 40).textCase(.none)
                    Image("Vector-7").frame(width: 10, height: 14).padding(.trailing,13).padding(.leading,5)
                }
                
            }.background(Color("#3DEE98")).cornerRadius(20, antialiased: true).frame(maxWidth: .infinity, alignment: .center).padding(.bottom,15)
            Divider()
            
        }.padding(.bottom,5)
    }
}


