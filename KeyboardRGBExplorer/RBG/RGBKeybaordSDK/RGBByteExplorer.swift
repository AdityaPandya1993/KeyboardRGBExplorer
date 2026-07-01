//
//  RGBByteExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit.hid

final class RGBByteExplorer {

    private let sender = RGBPacketSender()
    private let handshake = RGBHandshake()

    func start(device: IOHIDDevice) {

        Log.title("RGB Byte Explorer")

        // Always initialize keyboard first
        handshake.start(device: device)

        let targetByte = 1      // Change later (0,1,2,3...)
        let delay = 0.30

        for value in UInt8.min...UInt8.max {

            var packet = [UInt8](repeating: 0, count: 64)

            packet[targetByte] = value

            Log.info("Byte[\(targetByte)] = \(String(format: "%02X", value))")

            let result = sender.sendRaw(
                packet: packet,
                to: device
            )

            Log.info("Result = \(result)")

            Thread.sleep(forTimeInterval: delay)
        }

        Log.success("Byte Explorer Finished")
    }
}
