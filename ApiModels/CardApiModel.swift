//
//  CardApiModel.swift
//  Zol
//
//  Created by apple on 06/10/22.
//

import Foundation
class CardApiModel{
    
    
    func addCard<T:Codable>(model:CardModel,response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .addCard, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error ?? "Please check your internet")
        }
    }
    
    func getCard<T:Codable>(response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.requestPOSTURL(strURL: .getCards, params: [:], response: T.self) { response, error,status in
            if response != nil{
                completion(response,nil)
            }
            else{
                completion(nil,error ?? "Please check your internet")
            }
        }
    }
    
    func deleteCard<T:Codable>(model:CardModel,response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .disableCard, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            if response != nil{
                completion(response,nil)
            }
            else{
                completion(nil,error ?? "Please check your internet")
            }
        }
    }
    
    func referralCode<T:Codable>(model:CardModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .referralCode, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error,status)
        }
    }
    
    func buyCard<T:Codable>(model:CardModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .buyZolCard, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            completion(response,error,status)
        }
    }
}
