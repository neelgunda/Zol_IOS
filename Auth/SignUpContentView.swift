//
//  SignUpContentVIew.swift
//  Zol
//
//  Created by apple on 29/08/22.
//

import SwiftUI
import ActivityIndicatorView
import Combine


struct SignUpContentView: View {
    @State private var hidePassword: Bool = true
    @State private var hideConfirmPassword: Bool = true

    @State private var signUpModel: SignUpModel = SignUpModel(email: "", password: "",first_name: "", last_name: "", phone: "",device_type:"2",device_token:UUID().uuidString, rememberMe: AppDefaults.userRemember,agreeWithTerms: false, confirmPassword: "")
    @Environment(\.presentationMode) var presentationMode
    @StateObject var userViewModel = UserViewModel()
    @State private var willMoveToWedView:Bool = false

    let textLimit = 12
    var comingFrom:String
    @State var moveToLoginView = false

    var body: some View {
          NavigationStack {
            ZStack{
                VStack{
                    Text("Sign up").font(Font.custom("Poppins-SemiBold", size: 26)).padding(.bottom, 2)
                    Text("Let’s create your account").padding([.leading, .bottom, .trailing], 33.0).font(Font.custom("Poppins-Regular", size: 18)).foregroundColor(Color("#818181")).multilineTextAlignment(.center)
                    ScrollView {
                        VStack{
                            VStack{
                                
                                Text("First Name").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    TextField("First Name", text: self.$signUpModel.first_name)
                                        .padding(.horizontal, 15.0)
                                        .frame(height: 50.0)
                                        .keyboardType(.emailAddress)
                                        .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                                }.padding(.horizontal, 30.0).padding(.bottom, 20)
                                
                                Text("Last Name").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    TextField("Last Name", text: self.$signUpModel.last_name)
                                        .padding(.horizontal, 15.0)
                                        .frame(height: 50.0)
                                        .keyboardType(.emailAddress)
                                        .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                                }.padding(.horizontal, 30.0).padding(.bottom, 20)
                                
                                Text("Email Address").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    TextField("Email", text: self.$signUpModel.email)
                                        .padding(.horizontal, 15.0)
                                        .frame(height: 50.0)
                                        .keyboardType(.emailAddress)
                                        .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                                }.padding(.horizontal, 30.0).padding(.bottom, 20)
                                
                                Text("Phone Number(Optional)").font(Font.custom("Poppins-Regular", size: 15)).padding(.horizontal, 40.0).padding(.bottom, -6).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                                HStack{
                                    TextField("Phone Number", text: self.$signUpModel.phone)
                                        .onReceive(Just($signUpModel.phone)) { _ in
                                            limitText(textLimit)
                                        }
                                        .padding(.horizontal, 15.0)
                                        .frame(height: 50.0)
                                        .keyboardType(.phonePad)
                                        .textFieldStyle(.plain).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true).font(Font.custom("Poppins-Regular", size: 18))
                                }.padding(.horizontal, 30.0).padding(.bottom, 20)
                                
                                
                            }
                            
                            Text("Password").font(Font.custom("Poppins-Regular", size: 16)).padding(.horizontal, 40).padding(.bottom, -8).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                            HStack(spacing: -10){
                                Group {
                                    if self.hidePassword {
                                        SecureField("Password", text: $signUpModel.password).font(Font.custom("Poppins-Regular", size: 18))
                                    }
                                    else{
                                        TextField("Password", text: $signUpModel.password).font(Font.custom("Poppins-Regular", size: 18))
                                    }
                                }.padding(.horizontal, 15.0)
                                    .frame(height: 50.0).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                                Button(action: {
                                    self.hidePassword.toggle()
                                }) {
                                    Image( self.hidePassword ? "hidePassword" :  "showPassword")
                                }.frame(width: 50, height: 50).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                            }.padding(.horizontal, 30).padding(.bottom, 20)
                            
                            
                            Text("Confirm Password").font(Font.custom("Poppins-Regular", size: 16)).padding(.horizontal, 40).padding(.bottom, -8).foregroundColor(Color("#818181")).frame(maxWidth: .infinity, alignment: .leading)
                            HStack(spacing: -10){
                                Group {
                                    if self.hideConfirmPassword {
                                        SecureField("Confirm Password", text: $signUpModel.confirmPassword).font(Font.custom("Poppins-Regular", size: 18))
                                    }
                                    else{
                                        TextField("Confirm Password", text: $signUpModel.confirmPassword).font(Font.custom("Poppins-Regular", size: 18))
                                    }
                                }.padding(.horizontal, 15.0)
                                    .frame(height: 50.0).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                                Button(action: {
                                    self.hideConfirmPassword.toggle()
                                }) {
                                    Image( self.hideConfirmPassword ? "hidePassword" :  "showPassword")
                                }.frame(width: 50, height: 50).background(Color("#F4F4F4")).cornerRadius(7, antialiased: true)
                            }.padding(.horizontal, 30).padding(.bottom, 20)
                            
                            HStack{
                                Button(action: {
                                    self.signUpModel.agreeWithTerms.toggle()
                                }) {
                                    HStack{
                                        Image(self.signUpModel.agreeWithTerms ? "Vector" : "Vector-1")
                                    }
                                }.padding(.top, 10)
                                Button(action: {
                                    self.willMoveToWedView = true
                                }) {
                                    HStack{
                                        Text("Terms and Conditions").font(Font.custom("Poppins-Regular", size: 14)).foregroundColor(Color("#818181"))
                                    }
                                }.padding(.top, 10)
                                Spacer()
                            }.padding(.horizontal, 30)
                            Button(action: {
                                self.userViewModel.signUp(signUpModel: self.signUpModel)
                            }) {
                                Text("Sign up").font(Font.custom("Poppins-Medium", size: 17)).foregroundColor(Color("#000000")).multilineTextAlignment(.center).padding(.horizontal, 10.0).frame(minWidth: 100, maxWidth: .infinity, minHeight: 50).background(Color("#3DEE98")).cornerRadius(10, antialiased: true)
                            }.padding([.top, .leading, .trailing], 30.0).padding(.bottom,80)
                            
                            Spacer()
                            
                            HStack{
                                Text("Already have an account ?").font(Font.custom("Poppins-Regular", size: 16)).foregroundColor(Color("#818181"))
                                Button(action: {
                                    if self.comingFrom == "loginView"{
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                    else{
                                        self.moveToLoginView = true
                                    }
                                }) {
                                    HStack {
                                        Text("Log in").font(Font.custom("Poppins-Regular", size: 16)).foregroundColor(Color("#3DEE98"))
                                    }
                                }
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image("BackIcon").padding(.leading, 15.0)
                            }
                        }
                    }.navigationBarBackButtonHidden(true)
                }
                ActivityIndicatorView(isVisible: self.$userViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                    .frame(width: 50.0, height: 50.0)
            }
        }.onReceive(self.userViewModel.didSendRequest) { _ in
            if self.comingFrom == "loginView"{
                self.presentationMode.wrappedValue.dismiss()
            }
            else{
                self.moveToLoginView = true
            }
        }.navigationDestination(isPresented: self.$willMoveToWedView) {
            WebView(url: "https://zol-tech.com/Webservices/term_and_condition.php", title: "Terms and Conditions")
        }.navigationDestination(isPresented: self.$moveToLoginView) {
            LoginContentView()
        }
        
    }
    
    //    MARK: USE SET RANGE IN TEXTFIELD
    func limitText(_ upper: Int) {
        if signUpModel.phone.count > upper {
            signUpModel.phone = String(signUpModel.phone.prefix(upper))
        }
    }
}


