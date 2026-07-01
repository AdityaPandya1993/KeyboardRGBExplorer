//
//  RGBPayloadExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit.hid

final class RGBPayloadExplorer {

    func start(device: IOHIDDevice) {

        print("")
        print("========== RGB Payload Explorer ==========")

        IOHIDDeviceOpen(device, IOOptionBits(kIOHIDOptionsTypeNone))

        let reportIDs: [UInt8] = [0,1]

        let payloads: [[UInt8]] = [

            [0x00],

            [0x01],

            [0x02],

            [0x10],

            [0x20],

            [0xFF],

            [0xAA,0x55],

            [0x55,0xAA],

            [0x01,0x02,0x03],

            [0x10,0x20,0x30]

        ]

        for reportID in reportIDs {

            for payload in payloads {

                var packet = [UInt8](repeating: 0, count: 65)

                packet[0] = reportID

                for i in 0..<payload.count {

                    packet[i + 1] = payload[i]

                }

                let rid = packet[0]
                let size = packet.count

                let result = packet.withUnsafeMutableBytes { ptr in

                    IOHIDDeviceSetReport(
                        device,
                        kIOHIDReportTypeOutput,
                        CFIndex(rid),
                        ptr.bindMemory(to: UInt8.self).baseAddress!,
                        size
                    )

                }

                print("--------------------------------")
                print("Report ID : \(reportID)")
                print("Payload   : \(payload.map{String(format:"%02X",$0)}.joined(separator:" "))")
                print("Result    : \(result)")

                usleep(200000)
            }
        }

        IOHIDDeviceClose(device, 0)
    }
}
