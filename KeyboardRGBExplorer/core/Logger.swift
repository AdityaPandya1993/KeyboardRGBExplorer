//
//  Logger.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation

enum Log {

    static func info(_ text: String) {
        print("ℹ️ \(text)")
    }

    static func success(_ text: String) {
        print("✅ \(text)")
    }

    static func warning(_ text: String) {
        print("⚠️ \(text)")
    }

    static func error(_ text: String) {
        print("❌ \(text)")
    }

    static func hex(_ bytes: [UInt8]) {

        let string = bytes
            .map {
                String(format: "%02X", $0)
            }
            .joined(separator: " ")

        print(string)
    }
    
    static func title(_ text: String){

    print()

    print("════════════════════════════")

    print(text)

    print("════════════════════════════")

    }

}
