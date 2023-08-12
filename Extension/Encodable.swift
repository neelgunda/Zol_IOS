//
//  File.swift
//  Zol
//
//  Created by apple on 06/09/22.
//

import Foundation
extension Encodable {
    
    var convertToDict: [String:Any]? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(self)
            let dictonary =  try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any]
            return dictonary
        } catch {
            return nil
        }
    }
    
    var convertToString: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
    
}
