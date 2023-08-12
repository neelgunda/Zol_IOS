//
//  BrCodeDetailView.swift
//  Zol
//
//  Created by apple on 02/09/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct BrCodeDetailView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var id:String
    @StateObject var homeViewModel = HomeViewModel()
    var backIsHome:Bool
    
    @State var tabBarView:Bool = false
    var body: some View {
          NavigationStack {
            ZStack{
                VStack(alignment: .leading, spacing: 10, content: {
                    BrCodeView(outletModel: self.$homeViewModel.dealDetail)
                    Text(self.homeViewModel.dealDetail.deal_title ?? "").font(Font.custom("Poppins-SemiBold", size: 28)).foregroundColor(Color.black).padding(.top, 13.0)
                    if Int(self.homeViewModel.dealDetail.offer_left ?? "0")! > 1{
                        Label("\(self.homeViewModel.dealDetail.offer_left ?? "0") offers left",image:"offer 2").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#FF008C"))
                    }
                    else{
                        Label("\(self.homeViewModel.dealDetail.offer_left ?? "0") offer left",image:"offer 2").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#FF008C"))
                    }
                    Text(self.homeViewModel.dealDetail.deal_description ?? "").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#818181"))
                    Spacer()
                })
            }
            .padding(.horizontal, 20).padding(.top,30)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if self.backIsHome == true{
                            self.presentation.wrappedValue.dismiss()
                        }
                        else{
                            self.tabBarView = true
                        }
                    }) {
                        Image("BackIcon").padding(.leading, 5)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(self.homeViewModel.dealDetail.deal_title ?? "").font(Font.custom("Poppins-SemiBold", size: 20)).foregroundColor(Color.black).padding(.leading, 10.0)
                }
            }.navigationBarBackButtonHidden(true)
        }
        .onAppear{
            self.homeViewModel.getDealDetail(id: self.id)
        }.navigationDestination(isPresented: self.$tabBarView) {
            TabBarView()
        }
    }
}
