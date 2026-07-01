//
//  RGBCommandTester.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.

import Foundation
import IOKit.hid

final class RGBCommandTester {

    func test(device: IOHIDDevice) {

        Log.title("RGB Command Tester")

        let packets = RGBPacketGenerator.shared.allPackets()

        for (index, packet) in packets.enumerated() {

            var bytes = packet

            let result = IOHIDDeviceSetReport(
                device,
                kIOHIDReportTypeOutput,
                CFIndex(0),
                &bytes,
                bytes.count
            )

            Log.info("Packet \(index + 1) -> \(result)")
        }
    }
}
