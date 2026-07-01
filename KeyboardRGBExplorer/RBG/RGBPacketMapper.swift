//
//  RGBPacketMapper.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit.hid

final class RGBPacketMapper {

    func test(device: IOHIDDevice) {

        Log.title("RGB Packet Mapper")

        for value: UInt8 in 0...15 {

            var packet = [UInt8](repeating: 0, count: 65)

            packet[0] = 0x01      // Report ID
            packet[1] = 0x0B      // RGB Command
            packet[2] = value     // <-- Testing Byte

            let reportID = CFIndex(packet[0])
            let length = packet.count

            let result = packet.withUnsafeMutableBytes { ptr in

                IOHIDDeviceSetReport(
                    device,
                    kIOHIDReportTypeOutput,
                    reportID,
                    ptr.bindMemory(to: UInt8.self).baseAddress!,
                    length
                )
            }

            print("--------------------------------")
            print(String(format:"Byte2 = %02X", value))
            print("Result :", result)

            Thread.sleep(forTimeInterval: 0.5)
        }
    }
}
