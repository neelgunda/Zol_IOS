//
//  RestaurantApiModel.swift
//  Zol
//
//  Created by apple on 14/10/22.
//

import Foundation
class RestaurantApiModel{
    

    
    func barCodeScanner<T:Codable>(model:RestaurantModel,response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .barCodeScanner, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error ?? "Please check your internet")
        }
    }
    
    func AddAmount<T:Codable>(model:RestaurantModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .AddAmount, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error ?? "Please check your internet", status)
        }
    }
    
    func Redeem<T:Codable>(model:RestaurantModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .Redeem, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error ?? "Please check your internet", status)
        }
    }
    
}

