//
//  FeedBackViewModel.swift
//  Zol
//
//  Created by apple on 23/09/22.
//

import Foundation
import Combine
import SwiftUI

class FeedBackViewModel: ObservableObject {
    @Published var showLoadingIndicator:Bool = false
    var didSendRequest: AnyPublisher<Void, Never> {
        self.subject.eraseToAnyPublisher()
    }
    private let subject = PassthroughSubject<Void, Never>()
    func addFeedBack(dict:FeedBackModel){
        if dict.description == "" || dict.description == nil{
            NotificationCenter.default.post(name: .showAlert, object: "Please enter feedback")
        }
        else{
            self.showLoadingIndicator = true
            FeedBackApiModel().feedback(model: dict, response: FeedBackModel.self) { response, error, status in
                NotificationCenter.default.post(name: .showAlert, object: error ?? "Please check your internet")
                self.showLoadingIndicator = false
                if status == 1{
                    self.subject.send()
                }
            }
        }
    }
}


