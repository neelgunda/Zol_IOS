//
//  HomeViewModel.swift
//  Zol
//
//  Created by apple on 07/10/22.
//

import Foundation
class HomeViewModel: ObservableObject {
    @Published var restaurants = [OutletModel]()
    @Published var bars = [OutletModel]()
    @Published var services = [OutletModel]()

    @Published var dealDetail = OutletModel()
    @Published var showLoadingIndicator:Bool = false
    
    
    func getZolCard(){
        self.showLoadingIndicator = true
        HomeApiModel().homeApi() { response, error in
            self.showLoadingIndicator = false
            if let result = response{
                self.restaurants = result.Restaurants ?? []
                self.bars = result.Bars ?? []
                self.services = result.Service ?? []
            }
        }
    }
    
    func getDealDetail(id:String){
        let dict = OutletModel()
        dict.deal_id = id
        self.showLoadingIndicator = true
        HomeApiModel().barCode(model: dict, response: OutletModel.self) { response, error in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.showLoadingIndicator = false
                self.dealDetail = response ?? OutletModel()
//            }
        }
    }
}
