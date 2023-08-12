//
//  OurPatnersViewModel.swift
//  Zol
//
//  Created by apple on 08/09/22.
//

import Foundation
import Combine
import SwiftUI

class OurPatnersViewModel: ObservableObject {
    @Published var allPartners = [PartnerModel]()
    @Published var partnerDetail : PartnerModel?
    @Published var showLoadingIndicator:Bool = false
    @Published var loadMoreData = false
    var currentPage = 0
    
    
    func fetchMembers(showIndicator:Bool) {
        let dict = PaginationModel()
        dict.perPage = "10"
        dict.pagenumber = "\(self.currentPage + 1)"
        self.showLoadingIndicator = showIndicator
        PartnerApiModel().getAllPartners(model: dict, response: [PartnerModel].self) { response, error,status in
            self.showLoadingIndicator = false
            if response != nil{
                self.currentPage += 1
                self.loadMoreData = true
                self.allPartners.append(contentsOf: response!)
            }
            else{
                self.loadMoreData = false
            }
        }
    }
    
    
    func fetchMemberDedtails(id:String){
        let dict = PaginationModel()
        dict.id = id
        self.showLoadingIndicator = true
        PartnerApiModel().getPartnerDetail(model: dict, response: PartnerModel.self) { response, error in
            self.showLoadingIndicator = false
            if response != nil{
                self.partnerDetail = response
            }
            else{
                
            }
        }
    }
}
