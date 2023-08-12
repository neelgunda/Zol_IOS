//
//  AddCard.swift
//  Zol
//
//  Created by apple on 01/09/22.
//

import Foundation
import SwiftUI

struct AddCardView: View {
    
    @State private var email: String = ""
    
    var body: some View {
          NavigationStack {
            
            
            VStack{
                Text("Add card Debit / Credit").font(Font.custom("Poppins-Medium", size: 22)).padding(.horizontal, 30).padding(.bottom, 14).foregroundColor(Color("#000000")).frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Card Number").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    TextField("Card Number", text: $email)
                        .padding(.horizontal, 15.0)
                        .frame(height: 50.0)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                }.padding(.horizontal, 30.0).padding(.bottom, 20)
                Text("Card Holder Name").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    TextField("Card Holder Name", text: $email)
                        .padding(.horizontal, 15.0)
                        .frame(height: 50.0)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                }.padding(.horizontal, 30.0).padding(.bottom, 20)
                HStack(spacing:20){
                    VStack{
                        Text("Expiry Date").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                        TextField("Expiry Date", text: $email)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18)).padding([.bottom,.leading], 30)
                    }
                    VStack(alignment: .leading){
                        
                        Text("CVV").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 10.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("CVV", text: $email)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18)).padding([.bottom,.trailing], 30)
                    }
                }
                Button(action: {}) {
                    Text("Add card").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                }.padding([.top, .leading, .trailing], 30.0).padding(.bottom,80)
                Spacer()
            }.padding(.top,40)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            print("Refresh")
                        }) {
                            Image("BackIcon").padding(.leading, 15.0)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Add New Card").font(Font.custom("Poppins-SemiBold", size: 26)).foregroundColor(Color.black).padding(.leading, 10.0)
                    }
                }.navigationBarBackButtonHidden(true)
        }
    }
}



