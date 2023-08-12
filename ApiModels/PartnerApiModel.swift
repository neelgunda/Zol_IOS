//
//  PartnerApiModel.swift
//  Zol
//
//  Created by apple on 08/09/22.
//

import Foundation

class PartnerApiModel{
    
    func getAllPartners<T:Codable>(model:PaginationModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .getAllPartners, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            if let responseModel = response{
                completion(responseModel,nil,status)
                
            }
            else{
                completion(nil,error ?? "Please check your internet",0)
            }
        }
    }
    func getPartnerDetail<T:Codable>(model:PaginationModel,response: T.Type,completion: @escaping (T?,String?) -> Void){
        AFWrapperClass.sharedInstance.multipartApi(strURL: .partnerParticulardetail, params: model.convertToDict ?? [:], userImage: nil, response: T.self) { response, error,status,count in
            if let responseModel = response{
                completion(responseModel,nil)
                
            }
            else{
                completion(nil,error ?? "Please check your internet")
            }
        }
    }
}
