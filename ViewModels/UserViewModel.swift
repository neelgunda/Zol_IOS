//
//  UserViewModel.swift
//  Zol
//
//  Created by apple on 09/09/22.
//

import Foundation
import Combine
import SwiftUI


class UserViewModel: ObservableObject {
    
    @Published var userDetailModel : UserModel?
    @Published var showLoadingIndicator:Bool = false
    @Published var userLogin:Bool = false
    @Published var resturantLogin:Bool = false
    @Published var is_new:Bool = false
    @Published var goBack:Bool = false
    @Published var scannedCount:String = ""
    var didSendRequest: AnyPublisher<Void, Never> {
        self.subject.eraseToAnyPublisher()
    }
    private let subject = PassthroughSubject<Void, Never>()
    
    func loginUser(loginModel:LoginModel){
        if loginModel.email == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your email address")
            
            
        }
        else  if !loginModel.email.isValidEmail{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter correct email address")
            
            
        }
        else  if loginModel.password == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your password")
            
            
        }
        else{
            self.showLoadingIndicator = true
            UserApiModel().Login(model: loginModel, response: UserModel.self) { response, error in
                NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet")
                self.showLoadingIndicator = false
                if let responseModel = response{
                    if loginModel.rememberMe == true{
                        AppDefaults.userRemember = loginModel.rememberMe
                        AppDefaults.userEmail = loginModel.email
                        AppDefaults.userPassword = loginModel.password
                    }
                    AppDefaults.token = responseModel.authtoken
                    AppDefaults.userID = responseModel.id
                    AppDefaults.userName = responseModel.first_name
                    AppDefaults.role = responseModel.role
                    if responseModel.role == "2"{
                        self.resturantLogin = true
                    }
                    else{
                        if responseModel.is_new == "1"{
                            AppDefaults.is_new = false
                        }
                        else{
                            AppDefaults.is_new = true
                        }
                    }
                }
            }
        }
    }

    
    
    func signUp(signUpModel:SignUpModel){
        if signUpModel.first_name == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your first name")
        }
        else if signUpModel.last_name == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your last name")
        }
        else  if signUpModel.email == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your email address")
            
        }
        else  if !signUpModel.email.isValidEmail{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter correct email address")
            
        }
        else  if signUpModel.phone != "" && signUpModel.phone.count < 7{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter valid phone number")
        }
        else  if signUpModel.password == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your password")
        }
        else  if signUpModel.password != signUpModel.confirmPassword{
            NotificationCenter.default.post(name: .showAlert, object: "Password and confirm password must be same")
        }
        else if signUpModel.agreeWithTerms == false{
            NotificationCenter.default.post(name: .showAlert, object: "Please agree to terms & conditions")
        }
        else{
            self.showLoadingIndicator = true
            UserApiModel().signUp(model: signUpModel, response: UserModel.self) { response, error in
                NotificationCenter.default.post(name: .showAlert, object:  error ?? "Please check your internet")
                self.showLoadingIndicator = false
                if response != nil{
                    self.subject.send()
                }
            }
        }
    }
    
    func forgotPasswor(forgotModel:ForgotPasswordModel){
        if forgotModel.email == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your email address")
            
        }
        else  if !forgotModel.email.isValidEmail{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter correct email address")
            
        }
        else{
            self.showLoadingIndicator = true
            UserApiModel().forgotPassword(model: forgotModel, response: UserModel.self) { response, error , status in
                NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet")
                self.showLoadingIndicator = false
                if status == 1{
                    self.subject.send()
                }
            }
        }
    }
    
    
    func changepassword(confirmPwd: ConfirmPasswordModel){
        if confirmPwd.old_password == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your current password.")

        }else if confirmPwd.new_password == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your new password.")

    
        }else if confirmPwd.con_password == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your confirm password.")

        }else if confirmPwd.new_password != confirmPwd.con_password{
            NotificationCenter.default.post(name: .showAlert, object: "Password not match.")
        }else{
            self.showLoadingIndicator = true
            UserApiModel().changePassword(model: confirmPwd, response: UserModel.self) { response, error , status in
                NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet")

                self.showLoadingIndicator = false
                if status == 1{
                    self.subject.send()
                }
            }
            
        }
    }
    
    func fetchScanCount(){
        self.showLoadingIndicator = true
        UserApiModel().ScannedCardPartner(response: UserModel.self) { response, error,count in
            self.showLoadingIndicator = false
            if let scanCount = count{
                self.scannedCount = count ?? "0"
            }
        }
    }
    
    
    
    func fetchUserDetail(){
        self.showLoadingIndicator = true
        UserApiModel().getProfileDetail(response: UserModel.self) { response, error in
            self.showLoadingIndicator = false
            if let response = response {
                self.userDetailModel = response
            }
        }
    }
    func fetchRestaurantDetail(){
        self.showLoadingIndicator = true
        UserApiModel().getProfileDetail(response: UserModel.self) { response, error in
            self.showLoadingIndicator = false
            if let response = response {
                self.userDetailModel = response
                self.fetchScanCount()
            }
        }
    }
    
    func logout(){
        self.showLoadingIndicator = true
        UserApiModel().logoutUser(response: UserModel.self) { response, error in
            NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet")
            self.showLoadingIndicator = false
            NotificationCenter.default.post(name: .autoLogout, object: nil)
        }
    }
    
    func deleteAccount(){
        self.showLoadingIndicator = true
        UserApiModel().deleteUser(response: UserModel.self) { response, error in
            NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet")
            self.showLoadingIndicator = false
            NotificationCenter.default.post(name: .autoLogout, object: nil)
        }
    }
    
    func UpdateUserDetail(userDetal:UserModel,userImage:Data?,dissmissView:Binding<PresentationMode>){
        if userDetal.first_name == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your first name")
        }
        else if userDetal.last_name == "" {
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your last name")
        }
        else if userDetal.email == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please your phone number")
        }
        else  if userDetal.phone != "" && (userDetal.phone.count ?? 0) < 7{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter valid phone number")
        }
        else{
            self.showLoadingIndicator = true
            UserApiModel().editUserDetail(model: userDetal, userImage: userImage, response: UserModel.self) { response, error in
                self.showLoadingIndicator = false
                NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet")
                if let dict = response{
                    self.userDetailModel = dict
                    AppDefaults.userName = dict.first_name
                    dissmissView.wrappedValue.dismiss()
                }
            }
        }
    }
    
    
    func ContactSupport(userDetal:UserModel){
        if userDetal.phone == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your phone number")
            
        }
        else  if (userDetal.phone.count ?? 0) < 7{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter valid phone number")
        }
        else if userDetal.email == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter your email address")
        }
        else if userDetal.description == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please write your query in detail")
        }
        else{
            self.showLoadingIndicator = true
            UserApiModel().contactSupport(model: userDetal, response: UserModel.self) { response, error, status in
                NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet")

                self.showLoadingIndicator = false
                if status == 1{
                    self.subject.send()
                }
            }
        }
    }
    
    func verificationApi(verificationCode:String){
        var userDetal = UserModel()
        userDetal.code = verificationCode
        UserApiModel().verificationApi(model: userDetal, response: UserModel.self) { response, error,status  in
            
        }
    }
}
