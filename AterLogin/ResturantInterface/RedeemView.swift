//
//  RedeemView.swift
//  Zol
//
//  Created by apple on 14/10/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView
import AVFoundation

struct RedeemView: View {
    @Environment(\.presentationMode) var presentation
    
    @StateObject var restaurantViewModel = RestaurantViewModel()
    @Binding var restaurantDict : RestaurantModel
    @State var discountAmount: String?
    
    
    var body: some View {
        ZStack{
            VStack(spacing:20){
                Text("Enter Amount").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 25).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    TextField("Enter Amount", text:
                                Binding(
                                    get: {self.restaurantViewModel.amount ?? ""},
                                    set: {self.restaurantViewModel.amount = $0.filter{"0123456789.".contains($0)}})).onChange(of: self.restaurantViewModel.amount, perform: { newValue in
                                        self.restaurantViewModel.discountAmount = nil
                                    })
                                    .padding(.horizontal, 15.0)
                                    .frame(height: 50.0)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                }.padding(.horizontal, 23)
                
                Text("Discountt Amount").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 25).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    TextField("Discountt Amount", text: ( Binding(
                        get: {self.restaurantViewModel.discountAmount ?? ""},
                        set: {self.restaurantViewModel.discountAmount = $0.filter{"0123456789.".contains($0)}}))).onChange(of: self.restaurantViewModel.discountAmount, perform: { newValue in
                            if (Double(self.restaurantViewModel.discountAmount ?? "0") ?? 0) <= (Double(self.restaurantViewModel.amount ?? "0") ?? 0){
                                self.discountAmount = newValue
                            }
                            self.restaurantViewModel.discountAmount = self.discountAmount
                        })
                        .padding(.horizontal, 15.0)
                        .frame(height: 50.0)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                }.padding(.horizontal, 23)
                
                Divider().padding(.horizontal,23).padding(.vertical,3)
                VStack(alignment: .leading, spacing: 15){
                    HStack{
                        Text("Discount Applied").font(Font.custom("Poppins-Medium", size: 19)).foregroundColor(Color.black).frame(maxWidth: .infinity, alignment: .leading)
                        Text("$\(self.restaurantViewModel.discountAmount ?? "0")").font(Font.custom("Poppins-Regular", size: 19)).foregroundColor(Color("#818181"))
                    }
                    HStack{
                        Text("Total").font(Font.custom("Poppins-Medium", size: 19)).foregroundColor(Color.black).frame(maxWidth: .infinity, alignment: .leading)
                        Text("$\(String(format: "%.2f",(Double(self.restaurantViewModel.amount ?? "0") ?? 0) - (Double(self.restaurantViewModel.discountAmount ?? "0") ?? 0)))").font(Font.custom("Poppins-Medium", size: 19)).foregroundColor(Color.black)
                    }
                }.padding(.horizontal,23)
                Button(action: {
                    self.restaurantViewModel.AddAmount(scanId: self.restaurantDict.id ?? "0")
                }) {
                    Text("Reedem").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 80, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true).padding([.top, .leading, .trailing],35)
                }
                Spacer()
            }
            ActivityIndicatorView(isVisible: self.$restaurantViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98")).frame(width: 50.0, height: 50.0)
        }.padding(.top,20)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image("BackIcon").padding(.leading, 2.0)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(self.$restaurantDict.deal_title.wrappedValue ?? "").font(Font.custom("Poppins-SemiBold", size: 24)).foregroundColor(Color.black).padding(.leading, 10.0)
                }
            }.navigationBarBackButtonHidden(true).navigationDestination(isPresented: self.$restaurantViewModel.willMoveToRedeemView) {
                AfterRedeemView(presentation: self._presentation, restaurantDict: self.$restaurantDict)
            }.navigationBarTitleDisplayMode(.inline)
    }
}

