//
//  LoginContentView.swift
//  Zol
//
//  Created by apple on 26/08/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView

struct LoginContentView: View {
    @State private var loginModel: LoginModel = LoginModel(email: AppDefaults.userEmail ?? "", password: AppDefaults.userPassword ?? "", device_type: "2", device_token: "", rememberMe:  AppDefaults.userRemember)
    @State private var hidePassword: Bool = true
    @State private var willMoveToSignUpScreen:Bool = false
    @State private var willMoveToForgotScreen:Bool = false
    @StateObject var userViewModel = UserViewModel()
    
    
    var body: some View {
         NavigationStack{
            ZStack{
                GeometryReader { proxy in
                    ScrollView{
                        VStack(spacing: 10.0) {
                            VStack{
                                Image("lgog 1")
                                    .resizable().scaledToFill()
                                    .frame(width: 140, height: 140)
                                Text("Login Now").font(Font.custom("Poppins-SemiBold", size: 26))
                                Text("Please sign in to continue").padding([.leading, .bottom, .trailing], 30.0).font(Font.custom("Poppins-Regular", size: 18)).foregroundColor(Color("#818181")).multilineTextAlignment(.center)
                                Text("Email").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40).padding(.bottom, -8).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    TextField("Email", text: $loginModel.email)
                                        .padding(.horizontal, 15.0)
                                        .frame(height: 50.0)
                                        .keyboardType(.emailAddress)
                                        .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                                }.padding(.horizontal, 30.0).padding(.bottom, 20)
                                Text("Password").font(Font.custom("Poppins-Regular", size: 16)).padding(.horizontal, 40).padding(.bottom, -8).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                                HStack(spacing: -10){
                                    Group {
                                        if self.hidePassword {
                                            SecureField("Password", text: $loginModel.password).font(Font.custom("Poppins-Regular", size: 18))
                                        }
                                        else{
                                            TextField("Password", text: $loginModel.password).font(Font.custom("Poppins-Regular", size: 18))
                                        }
                                    }.padding(.horizontal, 15.0)
                                        .frame(height: 50.0).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                                    Button(action: {
                                        self.hidePassword.toggle()
                                    }) {
                                        Image( self.hidePassword ? "hidePassword" :  "showPassword")
                                    }.frame(width: 50, height: 50).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                                }.padding(.horizontal, 30)
                                HStack{
                                    Button(action: {
                                        self.loginModel.rememberMe.toggle()
                                    }) {
                                        HStack {
                                            Image(self.loginModel.rememberMe ? "Vector" : "Vector-1")
                                            Text("Remember me").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#000000"))
                                        }
                                    }.padding(.top, 10.0)
                                    Spacer()
                                    Button(action: {
                                        self.willMoveToForgotScreen.toggle()
                                        
                                    }) {
                                        HStack {
                                            Text("Forgot Password?").font(Font.custom("Poppins-Regular", size: 15)).foregroundColor(Color("#000000"))
                                        }
                                    }.padding(.top, 10.0)
                                }.padding(.horizontal, 30)
                            }
                            
                            Button(action: {
                                self.loginModel.device_token = AppDefaults.deviceToken ?? UUID().uuidString
                                self.userViewModel.loginUser(loginModel: self.loginModel)
                            }) {
                                Text("Log in").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                            }.padding([.top, .leading, .trailing], 30.0)
                            Spacer()
                            HStack{
                                Text("Don’t have an account ?").font(Font.custom("Poppins-Regular", size: 16)).foregroundColor(Color("#818181"))
                                Button(action: {
                                    self.willMoveToSignUpScreen.toggle()
                                }) {
                                    HStack {
                                        Text("Sign up").font(Font.custom("Poppins-Regular", size: 16)).foregroundColor(Color("#3DEE98"))
                                    }
                                }
                            }
                        }.frame(minHeight: proxy.size.height)
                        
                    }
                }
                ActivityIndicatorView(isVisible: self.$userViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                    .frame(width: 50.0, height: 50.0)
            }.navigationBarHidden(true)
        }
//        .navigationDestination(isPresented: self.$userViewModel.userLogin) {
//            TabBarView()
//        }.navigationDestination(isPresented: self.$userViewModel.resturantLogin) {
//            ResturantTabBarView()
//        }
        .navigationDestination(isPresented: self.$userViewModel.is_new) {
            IntroduceView()
        }.navigationDestination(isPresented: self.$willMoveToForgotScreen) {
            ForgotPasswordContentView()
        }.navigationDestination(isPresented: self.$willMoveToSignUpScreen) {
            SignUpContentView(comingFrom: "loginView")
        }
    }
}
