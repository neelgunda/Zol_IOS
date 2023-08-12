//
//  UserApiModel.swift
//  Zol
//
//  Created by apple on 06/09/22.
//

import Foundation

class UserApiModel{
    
    func Login<T:Codable>(model:LoginModel,response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .loginApi, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count  in
                completion(response,error ?? "Please check your internet")
        }
    }
    
    func signUp<T:Codable>(model:SignUpModel,response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .signUpApi, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
                completion(response,error ?? "Please check your internet")
        }
    }
    
    func forgotPassword<T:Codable>(model:ForgotPasswordModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .forgotPassword, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error ?? "Please check your internet", status)
        }
    }
    
    func changePassword<T:Codable>(model:ConfirmPasswordModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .changePassword, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
                completion(response,error ?? "Please check your internet",status)
        }
    }
    
    func getProfileDetail<T:Codable>(response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .getProfileDetail, params: [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error ?? "Please check your internet")
        }
    }
    
    func ScannedCardPartner<T:Codable>(response: T.Type,completion: @escaping (T?,String?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .ScannedCardPartner, params: [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error ?? "Please check your internet",count)
        }
    }
    
    
    
    func logoutUser<T:Codable>(response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .logout, params: [:], userImage: nil, response: T.self) { response, error,status,count in
                completion(response,error ?? "Please check your internet")
        }
    }
    
    func deleteUser<T:Codable>(response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.requestPOSTURL(strURL:  .deleteAccount, params: [:], response: T.self) { response, error,status in
            completion(response,error ?? "Please check your internet")
        }
    }
    
    func editUserDetail<T:Codable>(model:UserModel,userImage:Data?,response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .editProfile, params: model.convertToDict ?? [:], userImage: userImage, response: T.self) { response, error,status,count in
                completion(response,error ?? "Please check your internet")
        }
    }

    func contactSupport<T:Codable>(model:UserModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.requestPOSTURL(strURL:  .contacts, params: model.convertToDict ?? [:], response: T.self) { response, error,status in
        
                completion(response,error ?? "Please check your internet",status)
        }
    }
    func verificationApi<T:Codable>(model:UserModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL:  .newVerifyUser, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,image  in
            completion(response,error ?? "Please check your internet",status)
        }
    }
}
