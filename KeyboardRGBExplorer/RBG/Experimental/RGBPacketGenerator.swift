//
//  RGBPacketGenerator.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation

final class RGBPacketGenerator {

    static let shared = RGBPacketGenerator()

    private init() {}

    func allPackets() -> [[UInt8]] {

        return [

            // Packet 1
            [
                0x08,0x00,0x06,0x00,
                0x00,0x00,0x00,0x00
            ],

            // Packet 2
            [
                0x08,0x00,0x05,0x00,
                0x00,0x00,0x00,0x00
            ],

            // Packet 3
            [
                0x07,0x00,0xFF,0x00,
                0x00,0x00,0x00,0x00
            ],

            // Packet 4
            [
                0x0E,0x01,0xFF,0x00,
                0x00,0x00,0x00,0x00
            ],

            // Packet 5
            [
                0x55,0xAA,0x00,0x01,
                0xFF,0x00,0x00,0x00
            ],

            // Packet 6
            [
                0xFE,0xEF,0x00,0x02,
                0xFF,0x00,0x00,0x00
            ]
        ]
    }
}
