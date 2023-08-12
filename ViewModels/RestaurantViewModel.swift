//
//  RestaurantViewModel.swift
//  Zol
//
//  Created by apple on 14/10/22.
//

import Foundation

class RestaurantViewModel: ObservableObject {
    
    @Published var showLoadingIndicator:Bool = false
    @Published var showAlert:Bool = false
    @Published var willMoveToRedeemView:Bool = false
    @Published var startCcanCode = true
    @Published var restaurantModel:RestaurantModel = RestaurantModel()
    @Published var discountAmount:String?
    @Published var amount:String?
    
    
    func scanCard(restaurnatDict:RestaurantModel){
        self.showLoadingIndicator = true
        RestaurantApiModel().barCodeScanner(model: restaurnatDict, response: RestaurantModel.self) { [self] response, error in
            self.showLoadingIndicator = false
            if response != nil{
                self.restaurantModel = response ?? RestaurantModel()
                self.restaurantModel.bar_code = restaurnatDict.bar_code
                self.startCcanCode = true
                self.willMoveToRedeemView = true
            }
            else{
                self.showAlert = true
            }
        }
    }
    
    func AddAmount(scanId:String){
        if self.amount == "" || self.amount == "0" || self.amount == nil{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter amount greater than 0.")
            
        }
        else if self.discountAmount == "" || self.discountAmount == nil{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter discount amount.")
            
            
        }
        else{
            let dict = RestaurantModel()
            dict.scan_id = scanId
            dict.amount = String(format: "%.2f",(Double(self.amount ?? "0") ?? 0) - (Double(self.discountAmount ?? "0") ?? 0))
            dict.discount_amount = self.discountAmount
            self.showLoadingIndicator = true
            RestaurantApiModel().AddAmount(model: dict, response: RestaurantModel.self) { [self] response, error,status in
                NotificationCenter.default.post(name: .showAlert, object: error)
                self.showLoadingIndicator = false
                if status == 1{
                    self.restaurantModel = response ?? RestaurantModel()
                    self.willMoveToRedeemView = true
                }
                
            }
        }
    }
    
    func Redeem(id:String?){
        let dict = RestaurantModel()
        dict.scan_id = id        
        RestaurantApiModel().Redeem(model: dict, response: RestaurantModel.self) { [self] response, error,status in
            self.showLoadingIndicator = false
            if status == 1{
                self.restaurantModel = response ?? RestaurantModel()
            }
        }
    }
}
