//
//  FeedbackView.swift
//  Zol
//
//  Created by apple on 02/09/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct FeedbackView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var feedbackViewModle = FeedBackViewModel()
    @State var feedBackModel = FeedBackModel()
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
          NavigationStack {
                ScrollView{
                    ZStack{
                        VStack(alignment: .leading, spacing: 24, content: {
                            Text("What would you like to tell us?").font(Font.custom("Poppins-Medium", size: 22)).foregroundColor(Color.black)
                            if #available(iOS 16.0, *) {
                                TextEditor(text: self.$feedBackModel.description.toUnwrapped(defaultValue: ""))
                                    .frame(height: 153.0).scrollContentBackground(.hidden)
                                    .background(Color("#F4F4F4")).foregroundColor(Color.gray).cornerRadius(10, antialiased: true) .lineSpacing(2).font(.custom("Poppins-Medium", size: 15))
                            } else {
                                TextEditor(text: self.$feedBackModel.description.toUnwrapped(defaultValue: ""))
                                    .frame(height: 153.0)
                                    .background(Color("#F4F4F4")).foregroundColor(Color.gray).cornerRadius(10, antialiased: true) .lineSpacing(2).font(.custom("Poppins-Medium", size: 15))
                            }
                            Button(action: {
                                UIApplication.shared.endEditing()
                                self.feedbackViewModle.addFeedBack(dict: self.feedBackModel)
                            }) {
                                Text("Send").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                            }.padding(.top, 30.0)
                            Spacer()
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button(action: {
                                            self.presentation.wrappedValue.dismiss()
                                        }) {
                                            Image("BackIcon").padding(.leading, 10.0)
                                        }
                                    }
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Text("Feedback").font(Font.custom("Poppins-SemiBold", size: 26)).foregroundColor(Color.black).padding(.leading, 10.0)
                                    }
                                }.navigationBarBackButtonHidden(true)
                        }).padding(.top, 30.0).padding(.horizontal,25)
                    }
                    ActivityIndicatorView(isVisible: self.$feedbackViewModle.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                        .frame(width: 50.0, height: 50.0)
                }.hideKeyboardWhenTappedAround()
        }.onReceive(self.feedbackViewModle.didSendRequest) { _ in
            self.presentation.wrappedValue.dismiss()
        }
    }
}
