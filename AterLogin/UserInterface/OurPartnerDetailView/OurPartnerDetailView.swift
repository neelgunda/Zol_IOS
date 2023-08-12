//
//  OurPartnerDetailView.swift
//  Zol
//
//  Created by apple on 03/09/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct OurPartnerDetailView: View {
    @StateObject var ourPatnersViewModel = OurPatnersViewModel()
    
    var partnerId:String
    var body: some View {
        ZStack{
            List{
                Section(header:
                            OurPartnerDetailHeaderView(partnerModel: self.ourPatnersViewModel.partnerDetail)
                ){
                    Section(header: Text("Current Deal").font(Font.custom("Poppins-SemiBold", size: 20)).textCase(.none).foregroundColor(Color.black).padding(.top, 5).padding(.horizontal,13)) {
                        ForEach(0..<(self.ourPatnersViewModel.partnerDetail?.deals?.count ?? 0), id: \.self) { each in
                                CurrentDealCellView(detailModel: self.ourPatnersViewModel.partnerDetail?.deals?[each] ?? DealModel()).listRowSeparatorTint(.clear)
                         
                        }
                    }.listRowBackground(Color.white)
                }
            }.listStyle(.grouped).modifier(ListBackgroundModifier()).onAppear {
                self.ourPatnersViewModel.fetchMemberDedtails(id: self.partnerId)
            }.navigationBarHidden(true)
            ActivityIndicatorView(isVisible: self.$ourPatnersViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                .frame(width: 50.0, height: 50.0)
        }
    }
}



