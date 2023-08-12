//
//  HomeView.swift
//  Zol
//
//  Created by apple on 30/08/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    var body: some View {
        ZStack{
            VStack (spacing: 0){
                HStack {
                    Text("Welcome").font(Font.custom("Poppins-Regular", size: 25)).foregroundColor(Color("#A8A8A8"))
                    Text(AppDefaults.userName ?? "").font(Font.custom("Poppins-SemiBold", size: 25))
                }.frame(height:35).frame(minWidth: 15, maxWidth: .infinity,alignment: .leading).padding([.top,.leading], 15)
                
                List{
                    Section(header:
                                Text("Restaurants").textCase(.none).font(Font.custom("Poppins-Medium", size: 24)).foregroundColor(Color.black)
                    ) {
                        ForEach(self.$homeViewModel.restaurants, id: \.deal_id) { deals in
                            HomeCell(outlet: deals).listRowSeparatorTint(.clear)
                            
                        }.listRowBackground(Color.clear)
                    }
                    
                    Section(header:
                                Text("Bars").textCase(.none).font(Font.custom("Poppins-Medium", size: 24)).foregroundColor(Color.black)
                    ) {
                        ForEach(self.$homeViewModel.bars, id:\.deal_id) { deals in
                            HomeCell(outlet: deals).listRowSeparatorTint(.clear)
                        }.listRowBackground(Color.clear)
                    }
                    
                    Section(header:
                                Text("Service").textCase(.none).font(Font.custom("Poppins-Medium", size: 24)).foregroundColor(Color.black)
                    ) {
                        ForEach(self.$homeViewModel.services, id:\.deal_id) { deals in
                            HomeCell(outlet: deals).listRowSeparatorTint(.clear)
                        }.listRowBackground(Color.clear)
                    }
                    
                }.listStyle(.grouped).modifier(ListBackgroundModifier())
            }
            ActivityIndicatorView(isVisible: self.$homeViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98")).frame(width: 50.0, height: 50.0)
            
        }.navigationBarHidden(true).navigationBarTitleDisplayMode(.inline).onAppear{
            self.homeViewModel.getZolCard()
        }
    }
}
