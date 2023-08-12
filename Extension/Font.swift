//
//  ooo.swift
//  Zol
//
//  Created by apple on 29/08/22.
//

import SwiftUI

extension Font {
    struct Event {
        let poppinsSemiBold = Font.custom("Poppins-SemiBold", size: 26)
        let poppinsRegular = Font.custom("Poppins-Regular", size: 18)
        let poppinsRegularSix = Font.custom("Poppins-Regular", size: 16)
        let price = Font.custom("GillSans-SemiBoldItalic", size: 12)
    }
    static let event = Event()
}
