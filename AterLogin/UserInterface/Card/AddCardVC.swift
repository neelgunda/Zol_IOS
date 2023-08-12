//
//  AddCardVC.swift
//  Zol
//
//  Created by apple on 03/10/22.
//

import Foundation
import SwiftUI
import SquareInAppPaymentsSDK
struct AddCardVC: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation

    typealias UIViewControllerType = SQIPCardEntryViewController
    
    func makeUIViewController(context: Context) -> SQIPCardEntryViewController {
        let cardEntry = SQIPCardEntryViewController(theme: SQIPTheme())
        cardEntry.collectPostalCode = false
        cardEntry.delegate = context.coordinator
        return cardEntry
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    func updateUIViewController(_ uiViewController: SQIPCardEntryViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, SQIPCardEntryViewControllerDelegate, UINavigationControllerDelegate {
        
        
        var parent: AddCardVC
        
        init(_ cameraView: AddCardVC) {
            self.parent = cameraView
        }
        
        func cardEntryViewController(_ cardEntryViewController: SQIPCardEntryViewController, didObtain cardDetails: SQIPCardDetails, completionHandler: @escaping (Error?) -> Void) {
            self.addCard(expirationYear: cardDetails.card.expirationYear, brand: cardDetails.card.brand.description, expirationMonth: cardDetails.card.expirationMonth, lastFourDigits: cardDetails.card.lastFourDigits,source_id: cardDetails.nonce)
        }
        
        func addCard(expirationYear:UInt,brand:String,expirationMonth:UInt,lastFourDigits:String,source_id:String){
            var addCardDict = CardModel()
            addCardDict.expiration_year = "\(expirationYear)"
            addCardDict.last_four_digits = "\(lastFourDigits)"
            addCardDict.expiration_month = "\(expirationMonth)"
            addCardDict.source_id = source_id
            addCardDict.brand = brand
            CardViewModel().addCard(cardDict: addCardDict) { response, error in
                print(response)
                print(error)
                self.parent.presentation.wrappedValue.dismiss()
            }
        }
        
        
        func cardEntryViewController(_ cardEntryViewController: SQIPCardEntryViewController, didCompleteWith status: SQIPCardEntryCompletionStatus) {
        }
     
        func navigationControllerSupportedInterfaceOrientations(
            _: UINavigationController
        ) -> UIInterfaceOrientationMask {
            return .portrait
        }
    }
}
