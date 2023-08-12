//
//  HomeApiModel.swift
//  Zol
//
//  Created by apple on 07/10/22.
//

import Foundation

class HomeApiModel{
    
    
    func homeApi(completion: @escaping (HomeModel?,String?) -> Void){
        AFWrapperClass.sharedInstance.requestGetURL1(strURL: .homeScreen) { Result, error in
            return  completion(Result,error ?? "Please check your internet")
        }
    }
    func barCode<T:Codable>(model:OutletModel,response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .barCode, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error ?? "Please check your internet")
        }
    }
}
