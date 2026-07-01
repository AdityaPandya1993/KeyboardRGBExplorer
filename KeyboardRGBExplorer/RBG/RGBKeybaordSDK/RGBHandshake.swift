//
//  RGBHandshake.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

import Foundation
import IOKit.hid

final class RGBHandshake {

    private let handshake: [UInt8] = [
        0x04,
        0x05,
        0x06,
        0x07
    ]

    func start(device: IOHIDDevice) {

        Log.title("RGB Handshake")

        let sender = RGBPacketSender()

        for cmd in [0x04,0x05,0x06,0x07] {

            let result = sender.send(
                command: UInt8(cmd),
                to: device
            )

            print(result)

            Thread.sleep(forTimeInterval:0.5)
        }

        Log.success("Handshake Finished")
    }
}
