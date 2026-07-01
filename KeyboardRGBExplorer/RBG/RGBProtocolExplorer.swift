//
//  RGBProtocolExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class RGBProtocolExplorer {

    func start(device: IOHIDDevice) {

        Log.title("RGB Protocol Explorer")

        for command in UInt8(0)...31 {

            var packet = [UInt8](repeating: 0, count: 65)

            packet[0] = 0          // Report ID
            packet[1] = command    // Command

            let result = IOHIDDeviceSetReport(
                device,
                kIOHIDReportTypeOutput,
                CFIndex(packet[0]),
                &packet,
                packet.count
            )

            Log.info("--------------------------------")
            Log.info(String(format: "Command : 0x%02X", command))
            Log.info("Result  : \(result)")
            Log.info(Hex.string(from: packet))

            Thread.sleep(forTimeInterval: 0.30)
        }

        Log.success("Finished")
    }
}
