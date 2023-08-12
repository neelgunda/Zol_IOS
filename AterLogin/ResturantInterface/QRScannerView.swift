//
//  QRScannerView.swift
//  Zol
//
//  Created by apple on 11/10/22.
//

import Foundation
import SwiftUI
import ActivityIndicatorView
import AVFAudio


struct QRScannerView: View {
    @StateObject var  restaurantViewModel = RestaurantViewModel()
    
    var body: some View {
        ZStack(alignment: .center, content: {
            ZStack(alignment: .bottom){
                CodeScannerView(codeTypes: [.qr],scanMode: self.$restaurantViewModel.startCcanCode.wrappedValue == true ?.continuous :.never,showViewfinder: true,shouldVibrateOnSuccess: false) { response in
                    switch response {
                    case .success(let result):
                        self.restaurantViewModel.startCcanCode = false
                        PlayViewModel.instance.play()
                        print("Found code: \(result.string)")
                        let dict = RestaurantModel()
                        let splitData = result.string.components(separatedBy: "-")
                        dict.bar_code = splitData.first
                        dict.other_id = splitData.last
                        self.restaurantViewModel.scanCard(restaurnatDict: dict)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }.padding(.bottom,100)
                VStack(spacing:10){
                    Text("Scan barcode to verify card").font(Font.custom("Poppins-Medium", size: 17)).frame(height: 50,alignment: .center)
                    Text("Zol").font(Font.custom("Poppins-Medium", size: 17)).frame(height: 30)
                }.padding(.bottom,20).frame(minWidth: 100,maxWidth: .infinity).cornerRadius(10).background(Color.white).cornerRadius(10)
            }.navigationBarHidden(true).navigationBarTitleDisplayMode(.inline)
            ActivityIndicatorView(isVisible: self.$restaurantViewModel.showLoadingIndicator, type: .flickeringDots(count: 8)).foregroundColor(Color("#3DEE98"))
                .frame(width: 50.0, height: 50.0)
        }).fullScreenCover(isPresented: self.$restaurantViewModel.showAlert){
            TryAgainScanCodeView(scanAgain: self.$restaurantViewModel.startCcanCode).background(TransparentBackground())
        }.navigationDestination(isPresented: self.$restaurantViewModel.willMoveToRedeemView) {
            RedeemView(restaurantDict: self.$restaurantViewModel.restaurantModel)
        }
    }
}

struct TransparentBackground: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6214559189)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
