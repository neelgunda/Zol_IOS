//
//  OurPatnersView.swift
//  Zol
//
//  Created by apple on 30/08/22.
//

import UIKit
import SwiftUI
import ActivityIndicatorView
import SDWebImageSwiftUI

struct OurPatnersView: View {
    @StateObject var ourPatnersViewModel = OurPatnersViewModel()
    
    var body: some View {
        ZStack{
            VStack {
                HStack(spacing: 7) {
                    Text("Our Partners").font(Font.custom("Poppins-SemiBold", size: 30)).textCase(.none).foregroundColor(Color.black).padding(.bottom, 1)
                }.padding([.top,.leading], 15).frame(minWidth: 20, maxWidth: .infinity,alignment: .leading).frame(height:50)
                
                List {
                    ForEach(self.$ourPatnersViewModel.allPartners, id: \.id) { partnerModel in
                        OurPartnersView( partnerDetailDict: partnerModel).listRowSeparatorTint(.clear)
                    }.listRowBackground(Color.clear)
                    if self.ourPatnersViewModel.allPartners.count != 0{
                        ActivityIndicator(self.$ourPatnersViewModel.loadMoreData, style: .medium).onAppear{
                            self.ourPatnersViewModel.fetchMembers(showIndicator: false)
                        }
                    }
                    
                }.listStyle(.grouped).modifier(ListBackgroundModifier())
            }
            ActivityIndicatorView(isVisible: self.$ourPatnersViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                .frame(width: 50.0, height: 50.0)
        }.navigationBarTitleDisplayMode(.inline).onAppear {
            self.ourPatnersViewModel.allPartners.removeAll()
            self.ourPatnersViewModel.currentPage = 0
            self.ourPatnersViewModel.loadMoreData = false
            self.ourPatnersViewModel.fetchMembers(showIndicator: true)
        }.navigationBarHidden(true).navigationBarTitleDisplayMode(.inline)
    }
}


