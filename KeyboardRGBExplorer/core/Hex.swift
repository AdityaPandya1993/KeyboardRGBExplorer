//
//  Hex.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation

enum Hex {

    static func string(from bytes: [UInt8]) -> String {

        bytes
            .map {
                String(format: "%02X", $0)
            }
            .joined(separator: " ")

    }

}

