//
//  CardViewModel.swift
//  Zol
//
//  Created by apple on 06/10/22.
//

import Foundation
import Combine
import SwiftUI

class CardViewModel: ObservableObject {
    @Published var allCards  = [CardModel]()
    @Published var showLoadingIndicator:Bool = false
    @Published var AddPaymentBtnText = "Add payment method"
    
    @Published var raferralCodeApplied:Bool = false
    @Published var raferralDiscount = "0"
    var didSendRequest: AnyPublisher<Void, Never> {
        self.subject.eraseToAnyPublisher()
    }
    private let subject = PassthroughSubject<Void, Never>()

    func deleteCardID(id:String?){
        guard let index = self.allCards.firstIndex(where: { $0.id == id }) else {
            return
        }
        let cardDict = CardModel()
        cardDict.id = id
        self.deleteCard(cardDict: cardDict)
        self.allCards.remove(at: index)
    }
    
    func fetchCard(){
        self.raferralCodeApplied = false
        self.raferralDiscount = ""
        self.showLoadingIndicator = true
        CardApiModel().getCard(response: [CardModel].self) { response, error in
            self.showLoadingIndicator = false
            if response != nil{
                self.allCards = response!
                if self.allCards.count > 0{
                    self.AddPaymentBtnText = "Buy Zol Card"
                }
                else{
                    self.AddPaymentBtnText = "Add payment method"
                }
            }
            else{
                self.allCards = []
                self.AddPaymentBtnText = "Add payment method"

            }
        }
    }
  
    
    func addCard(cardDict:CardModel,completion: @escaping (CardModel?,String?) -> Void){
        CardApiModel().addCard(model: cardDict, response: CardModel.self) { response, error in
            return completion(response,error)
        }
    }
    
    
    func deleteCard(cardDict:CardModel){
        self.showLoadingIndicator = true
        CardApiModel().deleteCard(model: cardDict, response: CardModel.self) { response, error in
            self.showLoadingIndicator = false
        }
    }
    
    func buyCard(cardDict:CardModel){
        if cardDict.card_id == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please select a payment method.")
        }
        else{
            self.showLoadingIndicator = true
            CardApiModel().buyCard(model: cardDict, response: CardModel.self) { response, error, status in
                NotificationCenter.default.post(name: .showAlert, object: error)
                self.showLoadingIndicator = false
                if status == 1{
                    self.subject.send()
                }
            }
        }
    }
    
    func appliedRaferralCode(referral_code:String){
        if referral_code == ""{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter referral code.")
        }
        else{
            let dict = CardModel()
            dict.referral_code = referral_code
            self.showLoadingIndicator = true
            CardApiModel().referralCode(model: dict, response: CardModel.self) { response, error, status in
                self.showLoadingIndicator = false
                if status == 1{
                    self.raferralCodeApplied = true
                    self.raferralDiscount = response?.discount ?? "0"
                    
                }
                else{
                    NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet.")
                }
            }
        }
    }
}
