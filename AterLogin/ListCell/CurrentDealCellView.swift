//
//  CurrentDealCellView.swift
//  Zol
//
//  Created by apple on 02/09/22.
//

import SwiftUI
import SDWebImageSwiftUI
struct CurrentDealCellView: View {
    @State var detailModel : DealModel
    
    var body: some View {
        HStack (spacing: 20,content: {
            VStack(alignment:.leading,spacing: 8){
                Text(self.detailModel.deal_title ?? "").font(Font.custom("Poppins-SemiBold", size: 17))
                
                Text("").font(Font.custom("Poppins-SemiBold", size: 12)) + Text(self.detailModel.deal_description ?? "").font(Font.custom("Poppins-Regula", size: 12))
                
                Button(action: {
                    
                }) {
                    Text("Lets Chill").font(Font.custom("Poppins-SemiBold", size: 10)).foregroundColor(Color("#000000")).padding(5.0).frame(width: 74.0, height: 26.0).background(Color("#3DEE98")).cornerRadius(9, antialiased: true)
                }.padding(.top, 5.0)
                
            }.frame(minWidth: 90,maxWidth: .infinity,minHeight:  50,maxHeight: .infinity,alignment: .leading).padding([.top, .leading, .bottom])
            
            WebImage(url: URL(string: self.detailModel.deal_image ?? ""),options: .continueInBackground).placeholder(Image("istockphoto-1147544807-612x612").resizable()).resizable().scaledToFit().frame(width: 120,height: 120).cornerRadius(10)
            
        }).background(Color.white).cornerRadius(10).shadow(color: Color("Shadow"),radius: 14,x: 0,y: 0).padding(.horizontal,13).background(
            Group{
                if AppDefaults.role == "1"{
                    NavigationLink(destination:BrCodeDetailView(id: self.$detailModel.deal_id.toUnwrapped(defaultValue: "0"), backIsHome: false)) {EmptyView()}.opacity(0.0)
                }
            }
        )
    }
}
