//
//  TabBarView.swift
//  Zol
//
//  Created by apple on 30/08/22.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    
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
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView(selection: self.$selection) {
            HomeView().tabItem {
                if self.selection == 0 {
                    Image("Group 1")
                } else {
                    Image("Vector-4")
                }
            }.tag(0)
            
            BuyZolCardView(tabSelection: self.$selection).tabItem {
                if self.selection == 1 {
                    Image("Vector 1")
                } else {
                    Image("Vector-3")
                }
            }.tag(1)
            
            OurPatnersView().tabItem {
                if self.selection == 2 {
                    Image("Group 2")
                } else {
                    Image("Group-1")
                }
            }.tag(2)
            
            ProfileView().tabItem {
                if self.selection == 3 {
                    Image("Vector 2")
                } else {
                    Image("Vector-2")
                }
            }.tag(3)
        }
    }
    
}

