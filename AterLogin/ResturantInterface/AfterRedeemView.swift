//
//  RedeemedView.swift
//  Zol
//
//  Created by apple on 04/11/22.
//

import SwiftUI
import ActivityIndicatorView

struct AfterRedeemView: View {
    @Environment(\.presentationMode) var presentation :Binding<PresentationMode>
    @StateObject var restaurantViewModel = RestaurantViewModel()
    @Binding var restaurantDict : RestaurantModel
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 10, content: {
                RedeemedView(restaurantDict: self.$restaurantDict)
                Text(self.restaurantViewModel.restaurantModel.deal_title ?? "").font(Font.custom("Poppins-SemiBold", size: 28)).foregroundColor(Color.black).padding(.top, 13.0)
                Text(self.restaurantViewModel.restaurantModel.deal_description ?? "").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#818181"))
                if Int(exactly: self.restaurantViewModel.restaurantModel.offer_left ?? 0)! > 1{
                    Label("\(self.restaurantViewModel.restaurantModel.offer_left ?? 0) offers left",image:"offer 2").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#FF008C"))
                }
                else{
                    Label("\(self.restaurantViewModel.restaurantModel.offer_left ?? 0) offer left",image:"offer 2").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#FF008C"))
                }
                HStack{
                    Text("Discounted Amount:").font(Font.custom("Poppins-Medium", size: 19)).foregroundColor(Color.black).frame(maxWidth: .infinity, alignment: .leading)
                    Text("$ \(self.restaurantViewModel.restaurantModel.discount_amount ?? "")").font(Font.custom("Poppins-Regular", size: 19)).foregroundColor(Color("#818181"))
                }.padding(.top,10)
                
                HStack{
                    Text("Final Amount:").font(Font.custom("Poppins-Medium", size: 19)).foregroundColor(Color.black).frame(maxWidth: .infinity, alignment: .leading)
                    Text("$ \(self.restaurantViewModel.restaurantModel.amount ?? "")").font(Font.custom("Poppins-Regular", size: 19)).foregroundColor(Color("#818181"))
                }.padding(.top,5)
                
                Divider().padding(.vertical,19)
                VStack(alignment: .leading, spacing: 15){
                    HStack{
                        Text("Purchase ID").font(Font.custom("Poppins-Medium", size: 18)).foregroundColor(Color.black).frame(maxWidth: .infinity, alignment: .leading)
                        Text("Purchase on").font(Font.custom("Poppins-Medium", size: 19)).foregroundColor(Color.black)
                    }
                    HStack{
                        Text(self.restaurantDict.product_id ?? "").font(Font.custom("Poppins-Regular", size: 19)).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                        Text(Date(timeIntervalSince1970: Double(restaurantDict.created_at ?? "0") ?? 0).getRedeemDate()).font(Font.custom("Poppins-Regular", size: 19)).foregroundColor(Color("#818181"))
                    }
                }
                Spacer()
            }).padding(.horizontal,10)
            ActivityIndicatorView(isVisible: self.$restaurantViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98")).frame(width: 50.0, height: 50.0)
        }.padding(.horizontal, 20).padding(.top,30)
            .onAppear{
                self.restaurantViewModel.Redeem(id: self.restaurantDict.id)
            }  .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
//                        self.presentation.wrappedValue.dismiss()
                        NavigationUtil.popToRootView()
                    }) {
                        Image("BackIcon").padding(.leading, 5)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(self.restaurantViewModel.restaurantModel.deal_title ?? "").font(Font.custom("Poppins-SemiBold", size: 20)).foregroundColor(Color.black).padding(.leading, 10.0)
                }
            }.navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.inline)
    }
}


