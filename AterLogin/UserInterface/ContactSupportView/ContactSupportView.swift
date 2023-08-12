//
//  ContactSupportView.swift
//  Zol
//
//  Created by apple on 02/09/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct ContactSupportView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var  userViewModel = UserViewModel()
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
          NavigationStack {
            ZStack{
                VStack(alignment: .leading, spacing: 20, content: {
                    VStack(spacing: 3, content: {
                        Text("Phone Number").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 10).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("Phone Number", text: self.$userViewModel.userDetailModel.toUnwrapped(defaultValue: UserModel()).phone)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .disabled(false)
                            .keyboardType(.phonePad)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                    })
                    
                    VStack( spacing: 3, content: {
                        
                        Text("Email").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 10).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        TextField("Email", text: self.$userViewModel.userDetailModel.toUnwrapped(defaultValue: UserModel()).email)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .disabled(true)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                        
                    })
                    VStack(spacing: 3, content: {
                        
                        Text("Write your query in detail").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 10).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                        if #available(iOS 16.0, *) {
                            TextEditor(text:  self.$userViewModel.userDetailModel.toUnwrapped(defaultValue: UserModel()).description.toUnwrapped(defaultValue: ""))
                                .frame(height: 153.0).scrollContentBackground(.hidden)
                                .foregroundColor(Color.gray).cornerRadius(10, antialiased: true) .lineSpacing(2).font(.custom("Poppins-Medium", size: 15)).background(Color("#F4F4F4"))
                        } else {
                            TextEditor(text:  self.$userViewModel.userDetailModel.toUnwrapped(defaultValue: UserModel()).description.toUnwrapped(defaultValue: ""))
                                .frame(height: 153.0)
                                .foregroundColor(Color.gray).cornerRadius(10, antialiased: true) .lineSpacing(2).font(.custom("Poppins-Medium", size: 15)).background(Color("#F4F4F4"))
                        }
                    })
                    Button(action: {
                        UIApplication.shared.endEditing()
                        self.userViewModel.ContactSupport(userDetal: self.userViewModel.userDetailModel ?? UserModel())
                    }) {
                        Text("Send").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                    }.padding(.top, 30.0)
                    Spacer()
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image("BackIcon").padding(.leading, 10)
                                }
                            }
                            ToolbarItem(placement: .navigationBarLeading) {
                                Text("Contact Support").font(Font.custom("Poppins-SemiBold", size: 26)).foregroundColor(Color.black).padding(.leading, 10.0)
                            }
                        }.navigationBarBackButtonHidden(true)
                }).padding(.top, 30.0).padding(.horizontal,20).onAppear {
                    self.userViewModel.fetchUserDetail()
                }
                ActivityIndicatorView(isVisible: self.$userViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                    .frame(width: 50.0, height: 50.0)
            }
        }.hideKeyboardWhenTappedAround().onReceive(self.userViewModel.didSendRequest) { _ in
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

