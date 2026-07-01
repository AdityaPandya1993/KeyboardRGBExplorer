//
//  RGBPacketExplorerV2.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class RGBPacketExplorerV2 {

    func start(device: IOHIDDevice) {

        var packet = [UInt8](repeating: 0, count: 65)

        packet[0] = 0

        var command: UInt8 = 0

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in

            if command > 30 {

                timer.invalidate()

                Log.success("Finished RGB Scan")

                return
            }

            packet[1] = command

            let result = IOHIDDeviceSetReport(
                device,
                kIOHIDReportTypeOutput,
                CFIndex(packet[0]),
                &packet,
                packet.count
            )

            Log.title("Packet \(command)")
            Log.info(Hex.string(from: packet))
            Log.info("Result : \(result)")

            command += 1
        }
    }
}
