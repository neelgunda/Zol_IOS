//
//  ForgotPasswordContentView.swift
//  Zol
//
//  Created by apple on 29/08/22.
//

import SwiftUI
import ActivityIndicatorView

struct ForgotPasswordContentView: View {
    
    @State private var forgotModel:ForgotPasswordModel = ForgotPasswordModel(email: "")
    @Environment(\.presentationMode) var presentation
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: 10) {
                    Text("Forgot Password").font(Font.custom("Poppins-SemiBold", size: 26)).padding(.bottom, 3)
                    Text("Please enter your registered email address to recover your password").padding([.leading, .bottom, .trailing], 33.0).font(Font.custom("Poppins-Regular", size: 18)).foregroundColor(Color("#818181")).multilineTextAlignment(.center)
                    Text("Email Address").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        TextField("Email", text: $forgotModel.email)
                            .padding(.horizontal, 15.0)
                            .frame(height: 50.0)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                    }.padding(.horizontal, 30.0).padding(.bottom, 20)
                    Button(action: {
                        
                        self.userViewModel.forgotPasswor(forgotModel: self.forgotModel)
                    }) {
                        Text("Submit").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                    }.padding([.top, .leading, .trailing], 30.0)
                    Spacer()
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image("BackIcon").padding(.leading, 15.0)
                    }
                }
            }.navigationBarBackButtonHidden(true)
            ActivityIndicatorView(isVisible: self.$userViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                .frame(width: 50.0, height: 50.0)
            
        }.onReceive(self.userViewModel.didSendRequest) { _ in
            self.presentation.wrappedValue.dismiss()
        }
    }
}
