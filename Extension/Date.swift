//
//  Date.swift
//  Zol
//
//  Created by apple on 05/11/22.
//

import Foundation

extension Date{
    func getRedeemDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
}

