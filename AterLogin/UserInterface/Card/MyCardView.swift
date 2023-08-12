//
//  MyCardView.swift
//  Zol
//
//  Created by apple on 01/09/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct MyCardView: View {
    @Environment(\.presentationMode) var presentation
    @State private var willMoveToAddCard: Bool = false
    @State private var offsets = [CGSize](repeating: CGSize.zero, count: 6)
    @StateObject var cardViewModel = CardViewModel()
    var body: some View {
        NavigationStack {
            ZStack{
                List {
                    if self.cardViewModel.allCards.count > 0{
                        ForEach(self.$cardViewModel.allCards, id: \.id) { card in
                            MyCardCellView(cardModel: card).mySwipeAction {
                                self.cardViewModel.deleteCardID(id: card.id.wrappedValue)
                            }.background(Color.white).cornerRadius(17, antialiased: false).padding(.horizontal,5).shadow(color: Color("Shadow"),radius: 14,x: 0,y: 0)
                            
                        }.listRowBackground(Color.clear).listRowSeparatorTint(.clear)
                        
                    }
                    else{
                        Text("No cards found.").frame(width: UIScreen.screenWidth - 50,height: UIScreen.screenHeight - 200,alignment: .center)
                    }
                }.modifier(ListBackgroundModifier()).listStyle(.grouped)
                
                ActivityIndicatorView(isVisible: self.$cardViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                    .frame(width: 50.0, height: 50.0)
            }.onAppear {
                self.cardViewModel.fetchCard()
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image("BackIcon").padding(.leading, 15.0)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("My Cards").font(Font.custom("Poppins-SemiBold", size: 26)).foregroundColor(Color.black).padding(.leading, 10.0)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.willMoveToAddCard = true
                        
                    }) {
                        Image("Vector-9").resizable().scaledToFill().padding(.trailing, 15.0).frame(width: 19, height: 19)
                    }
                }
            }.navigationBarBackButtonHidden(true)
        }.navigationDestination(isPresented: self.$willMoveToAddCard) {
            AddCardVC()
        }
    }
}

