//
//  ResturantTabBarView.swift
//  Zol
//
//  Created by apple on 11/10/22.
//

import UIKit

import SwiftUI

struct ResturantTabBarView: View {
    
    @State var selection = 0
    init() {
        let image = UIImage.gradientImageWithBounds(
            bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: UIScreen.main.scale),
            colors: [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.03).cgColor
            ]
        )
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowImage = image
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: self.$selection) {
            QRScannerView().tabItem {
                if self.selection == 0 {
                    Image("bi_upc-scan")
                } else {
                    Image("bi_upc-scan-1")
                }
            }.tag(0)
            
            ResturantProfileView().tabItem {
                if self.selection == 1 {
                    Image("Vector 2")
                } else {
                    Image("Vector-2")
                }
            }.tag(1)
        }
    }
}

