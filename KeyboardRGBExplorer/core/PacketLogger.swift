//
//  PacketLogger.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation

final class PacketLogger {

    static func dump(_ bytes: [UInt8]) {

        let string = bytes.map {

            String(format: "%02X", $0)

        }.joined(separator: " ")

        Log.info(string)
    }

}
