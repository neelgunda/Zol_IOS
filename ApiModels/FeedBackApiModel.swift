//
//  FeedBackApiModel.swift
//  Zol
//
//  Created by apple on 23/09/22.
//

import Foundation
class FeedBackApiModel{
    
    
    func feedback<T:Codable>(model:FeedBackModel,response: T.Type,completion: @escaping (T?,String?,Int?) -> Void){
        AFWrapperClass.sharedInstance.requestPOSTURL(strURL: .feedback, params: model.convertToDict ?? [:], response: T.self) { response, error,status in
            completion(response,error,status)
        }
    }
    
}
