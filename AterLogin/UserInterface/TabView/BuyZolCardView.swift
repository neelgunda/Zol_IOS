//
//  BuyZolCardView.swift
//  Zol
//
//  Created by apple on 30/08/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct BuyZolCardView: View {
    @State var cardCount = "1"
    @State private var willMoveToAddCard: Bool = false
    @StateObject var cardViewModel = CardViewModel()
    @State var cardId = ""
    @Binding var tabSelection: Int
    @State var ReferralCode = ""
    var body: some View {
        ZStack{
            VStack {
                Text("Buy Zol Card").font(Font.custom("Poppins-SemiBold", size: 30)).textCase(.none).foregroundColor(Color.black).frame(minWidth: 15, maxWidth: .infinity,alignment: .leading).padding([.top,.leading], 15).frame(height:50)
                List {
                    Section(header:
                                VStack(alignment: .leading){
                        ZolCardCellView(cardCount: self.$cardCount).padding(.vertical, 5).foregroundColor(Color.black)
                        if self.$cardViewModel.allCards.count > 0{
                            HStack(alignment: .firstTextBaseline) {
                                Text("Referral Code").font(Font.custom("Poppins-Medium", size: 18)).textCase(.none)
                                Text("(optional)").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#AEAEAE")).textCase(.none)
                                Spacer()
                            }.padding(.top, 10)
                            HStack(alignment: .center) {
                                TextField("Referral Code", text: self.$ReferralCode)
                                    .padding(.horizontal, 15.0)
                                    .frame(height: 50.0)
                                    .textFieldStyle(.plain).font(Font.custom("Poppins-Regular", size: 18)).textCase(.none).onChange(of: self.ReferralCode) { newValue in
                                        self.cardViewModel.raferralCodeApplied = false
                                        self.cardViewModel.raferralDiscount = ""
                                    }
                                
                                Button(action: {
                                    UIApplication.shared.endEditing()
                                    self.cardViewModel.appliedRaferralCode(referral_code: self.ReferralCode)
                                }) {
                                    if self.cardViewModel.raferralCodeApplied == false{
                                        Text("Apply").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).padding(.trailing, 15.0).textCase(.none)
                                    }
                                    else{
                                        Text("Applied").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#3DEE98")).padding(.trailing, 15.0).textCase(.none)
                                    }
                                }
                            }.background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                            if self.cardViewModel.raferralCodeApplied == true{
                                Text("Congratulations, the discount code was applied successfully!").font(Font.custom("Poppins-Regular", size: 14)).foregroundColor(Color("#3DEE98")).textCase(.none)
                                HStack(alignment: .firstTextBaseline) {
                                    Text("Total").font(Font.custom("Poppins-Medium", size: 19)).foregroundColor(Color.black).textCase(.none)
                                    Spacer()
                                    Text("~~$\((Int(self.cardCount) ?? 0) * 20)~~").font(Font.custom("Poppins-Regular", size: 13)).foregroundColor(Color("#AEAEAE"))
                                    Text("$\(max(((Int(self.cardCount) ?? 0) * 20) - (Int(self.cardViewModel.raferralDiscount) ?? 0), 0))").font(Font.custom("Poppins-Medium", size: 19)).foregroundColor(Color.black)
                                }.padding(.vertical, 10)
                            }
                        }
                    }.background(Color.white),
                            footer:Button(action: {
                        UIApplication.shared.endEditing()
                        if self.cardViewModel.allCards.count == 0{
                            self.willMoveToAddCard = true
                        }
                        else{
                            let dict = CardModel()
                            dict.price = "\(max(((Int(self.cardCount) ?? 0) * 20) - (Int(self.cardViewModel.raferralDiscount) ?? 0), 0))"
                            dict.total_card = self.cardCount
                            dict.card_id = self.cardId
                            self.cardViewModel.buyCard(cardDict: dict)
                        }
                    }) {
                        
                        Text(self.cardViewModel.AddPaymentBtnText).font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                    }.padding([.leading, .trailing], 5)
                    ) {
                        
                        Section (header:  Text("Payment Method").font(Font.custom("Poppins-Medium", size: 20)).textCase(.none).foregroundColor(Color.black).padding(.bottom, 4)){
                            ForEach(self.$cardViewModel.allCards, id: \.id) { card in
                                    HStack{
                                        MyCardCellView(cardModel: card)
                                        
                                        if self.cardId == card.card_id.wrappedValue{
                                            Image("Vector").padding(.trailing,15)
                                        }
                                        else{
                                            Image("Vector-1").padding(.trailing,15)
                                        }
                                    }.background(Color.white).cornerRadius(17, antialiased: false).padding(.horizontal,5).shadow(color: Color("Shadow"),radius: 14,x: 0,y: 0).onTapGesture {
                                        self.cardId = card.card_id.wrappedValue ?? ""
                                    }.listRowSeparator(.hidden)
                                                                
                            }.listRowBackground(Color.clear)
                            
                        }
                    }.listRowBackground(Color.white).listRowSeparator(.hidden)
                }.modifier(ListBackgroundModifier()).onAppear {
                    self.ReferralCode = ""
                    self.cardViewModel.fetchCard()
                }
            }
            ActivityIndicatorView(isVisible: self.$cardViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98")).frame(width: 50.0, height: 50.0)
        }.listStyle(.grouped).onReceive(self.cardViewModel.didSendRequest) { _ in
            self.tabSelection = 0
        }.navigationDestination(isPresented: self.$willMoveToAddCard) {
            AddCardVC()
        }.navigationBarHidden(true).navigationBarTitleDisplayMode(.inline)
    }
}

struct ListBackgroundModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
                .background(.white)
        } else {
            content
            
        }
    }
}
