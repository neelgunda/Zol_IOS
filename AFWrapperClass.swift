//
// AFWrapperClass.swift
// Attire4hire
//
// Copyright © 2020 Apple. All rights reserved.
//
//
import Foundation
import UIKit
import Alamofire

class AFWrapperClass{
    
    static let sharedInstance = AFWrapperClass()
    
    func multipartApi<T:Codable>(strURL: ApiConstant, params: [String: Any],userImage:Data?, response: T.Type,completion:@escaping(T?,String?,Int?,String?) -> Void) {
        print(params,"Param ====>")
        print(strURL.rawValue,"URL ====>")
        print(AppDefaults.token,"token ====>")
        
        let headers: HTTPHeaders = [
            "Content-type": "application/form-data","authtoken":AppDefaults.token ?? ""]
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    if key != "image"{
                        multiPart.append(temp.data(using: .utf8)!, withName: key)
                    }
                }
            }
            if userImage != nil{
                multiPart.append(userImage!, withName: "image", fileName: "\(UUID()).png", mimeType: "image/png")
            }
        } ,to: strURL.rawValue, usingThreshold: UInt64.init(), method: .post, headers: headers)
        .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseData(completionHandler: { data in
            switch data.result {
            case .success(let value):
                let result = try? JSONDecoder().decode(ApiResponseModel<T>.self, from: value)
                print(result?.convertToDict,"Api Response ====>")
                if result?.status == 401{
                    NotificationCenter.default.post(name: .autoLogout, object: nil)
                }
                else{
                    completion(result?.data,result?.message, result?.status, result?.count)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil,error.localizedDescription, 0,nil)
            }
        })
    }
    
    
    func requestPOSTURL<T:Codable>(strURL :  ApiConstant, params : [String : Any]?,response: T.Type,completion:@escaping(T?,String?,Int?) ->Void){
        print(params,"Param ====>")
        print(strURL.rawValue,"URL ====>")
        print(AppDefaults.token,"token ====>")
        
        AF.request(strURL.rawValue, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json","authtoken":AppDefaults.token ?? ""]).responseData(completionHandler:  {data in
            switch data.result {
            case .success(let value):
                let result = try? JSONDecoder().decode(ApiResponseModel<T>.self, from: value)
                print(result.convertToDict,"Api Response ====>")
                if result?.status == 401{
                    NotificationCenter.default.post(name: .autoLogout, object: nil)
                }
                else{
                    completion(result?.data,result?.message,result?.status)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil,error.localizedDescription,0)
            }
        })
    }
    
    func requestGetURL<T:Codable>(strURL :  ApiConstant,response: T.Type,completion:@escaping(T?,String?) ->Void){
        print(strURL.rawValue,"URL ====>")
        print(AppDefaults.token,"token ====>")
        AF.request(strURL.rawValue, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json","authtoken":AppDefaults.token ?? ""]).responseData(completionHandler:  {data in
            switch data.result {
            case .success(let value):
                let result = try? JSONDecoder().decode(ApiResponseModel<T>.self, from: value)
                print(result.convertToDict,"Api Response ====>")
                if result?.status == 401{
                    NotificationCenter.default.post(name: .autoLogout, object: nil)
                }
                else{
                    completion(result?.data,result?.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil,error.localizedDescription)
            }
        })
    }
    
    
    func requestGetURL1(strURL :  ApiConstant,completion:@escaping(HomeModel?,String?) ->Void){
        print(strURL.rawValue,"URL ====>")
        print(AppDefaults.token,"token ====>")
        AF.request(strURL.rawValue, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json","authtoken":AppDefaults.token ?? ""]).responseData(completionHandler:  {data in
            switch data.result {
            case .success(let value):
                let result = try? JSONDecoder().decode(HomeModel.self, from: value)
                print(result.convertToDict,"Api Response ====>")
                if result?.status == 401{
                    NotificationCenter.default.post(name: .autoLogout, object: nil)
                }
                else{
                    completion(result,result?.message)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error.localizedDescription)
            }
        })
    }
    
}
