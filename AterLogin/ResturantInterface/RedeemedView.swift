//
//  RedeemedView.swift
//  Zol
//
//  Created by apple on 04/11/22.
//

import SwiftUI

struct RedeemedView: View {
    @Binding var restaurantDict : RestaurantModel

    var body: some View {
        ZStack(alignment: .topTrailing){
            ZStack{
                VStack(spacing:10){
                    Text("REDEEMED").font(Font.custom("Poppins-Medium", size: 18)).foregroundColor(Color("#00D1FF")).padding(.top, 13)
                    Text(Date(timeIntervalSince1970: Double(restaurantDict.created_at ?? "0") ?? 0).getRedeemDate()).font(Font.custom("Poppins-Regular", size: 11)).foregroundColor(Color("#C6C6C6"))
                    Divider().padding(.horizontal, 40).padding(.top, 5)
                    Text("VOUCHER ID").font(Font.custom("Poppins-Regular", size: 11)).foregroundColor(Color("#C6C6C6"))
                    Text(self.restaurantDict.bar_code ?? "").font(Font.custom("Poppins-SemiBold", size: 17)).foregroundColor(Color.black).padding(.top, -5)
                }
            }
            .frame(height: 155)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 0.7, dash: [6])).foregroundColor(Color("#E1E1E1"))
            ).padding(.horizontal, 15).padding(.top,15)
            Image("dl.beatsnoop 1")
                .frame(width: 121.0, height: 113.0)
        }
    }
}

