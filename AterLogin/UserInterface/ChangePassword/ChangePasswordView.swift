//
//  ChangePasswordView.swift
//  Zol
//
//  Created by apple on 21/10/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct ChangePasswordView: View {
        
    @Environment(\.presentationMode) var presentation
    @State private var confirmModel:ConfirmPasswordModel = ConfirmPasswordModel(old_password: "", new_password: "", con_password: "")
    
    @StateObject var userViewModel = UserViewModel()

    @State private var hidePassword: Bool = true
    @State private var hidPassword: Bool = true
    @State private var hiPassword: Bool = true
    @State private var currentpassword: String = ""
    @State private var newpassword: String = ""
    @State private var confirmpassword: String = ""
    
    var body: some View {
          NavigationStack {
            ScrollView {
                VStack(){
                    TextField("Current password", text: $currentpassword).padding(.top, 20)
                    HStack(spacing: -10){
                        Group {
                            if self.hidePassword {
                                SecureField("Current password", text: $confirmModel.old_password).font(Font.custom("Poppins-Regular", size: 18))
                            }
                            else{
                                TextField("Current password", text: $confirmModel.old_password).font(Font.custom("Poppins-Regular", size: 18))
                            }
                        }.padding(.horizontal, 15.0)
                            .frame(height: 50.0).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                        Button(action: {
                            self.hidePassword.toggle()
                        }) {
                            Image( self.hidePassword ? "hidePassword" :  "showPassword")
                        }.frame(width: 50, height: 50).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                    }.padding(.horizontal, 0).padding(.bottom, 20)
                    
                    TextField("New password", text: $newpassword)
                    HStack(spacing: -10){
                        Group {
                            if self.hidPassword {
                                SecureField("New password", text: $confirmModel.new_password).font(Font.custom("Poppins-Regular", size: 18))
                            }
                            else{
                                TextField("New password", text: $confirmModel.new_password).font(Font.custom("Poppins-Regular", size: 18))
                            }
                        }.padding(.horizontal, 15.0)
                            .frame(height: 50.0).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                        Button(action: {
                            self.hidPassword.toggle()
                        }) {
                            Image( self.hidPassword ? "hidePassword" :  "showPassword")
                        }.frame(width: 50, height: 50).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                    }.padding(.horizontal, 0).padding(.bottom, 20)
                    
                    TextField("Confirm password", text: $confirmpassword)
                    HStack(spacing: -10){
                        Group {
                            if self.hiPassword {
                                SecureField("Confirm password", text: $confirmModel.con_password).font(Font.custom("Poppins-Regular", size: 18))
                            }
                            else{
                                TextField("Confirm password", text: $confirmModel.con_password).font(Font.custom("Poppins-Regular", size: 18))
                            }
                        }.padding(.horizontal, 15.0)
                            .frame(height: 50.0).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                        Button(action: {
                            self.hiPassword.toggle()
                        }) {
                            Image( self.hiPassword ? "hidePassword" :  "showPassword")
                        }.frame(width: 50, height: 50).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                    }.padding(.horizontal, 0)
                    Spacer(minLength: 50)
                    Button(action: {
                        self.userViewModel.changepassword(confirmPwd: self.confirmModel)
                    }) {
                        Text("Submit").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 80, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                    }
                }.padding([.leading, .trailing], 20)
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image("BackIcon").padding(.leading, 2.0)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Change Password").font(Font.custom("Poppins-SemiBold", size: 24)).foregroundColor(Color.black).padding(.leading, 10.0)
                }
            }.navigationBarBackButtonHidden(true)
        }.onReceive(self.userViewModel.didSendRequest) { _ in
            self.presentation.wrappedValue.dismiss()
        }
    }
}

