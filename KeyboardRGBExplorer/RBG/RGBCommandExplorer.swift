//
//  RGBCommandExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit.hid

final class RGBCommandExplorer {

    func start(device: IOHIDDevice) {

        Log.title("RGB Command Explorer")

        let open = IOHIDDeviceOpen(device, 0)

        guard open == kIOReturnSuccess else {
            Log.error("Cannot open HID device")
            return
        }

        defer {
            IOHIDDeviceClose(device, 0)
        }

        for command in UInt8(0)...255 {

            var packet = [UInt8](repeating: 0, count: 65)

            packet[0] = 0
            packet[1] = command

            let reportID = CFIndex(packet[0])
            let length = packet.count

            let send = packet.withUnsafeMutableBytes { rawBuffer in

                guard let pointer = rawBuffer.bindMemory(to: UInt8.self).baseAddress else {
                    return kIOReturnError
                }

                return IOHIDDeviceSetReport(
                    device,
                    kIOHIDReportTypeOutput,
                    reportID,
                    pointer,
                    length
                )
            }

            print("")
            print("--------------------------------")
            print(String(format: "CMD : %02X", command))
            print("Send Result : \(send)")

            readFeature(device: device, reportID: 0)

            Thread.sleep(forTimeInterval: 0.00)
        }

        Log.success("Finished")
    }

    private func readFeature(device: IOHIDDevice, reportID: UInt8) {

        var buffer = [UInt8](repeating: 0, count: 65)
        var length = buffer.count

        buffer[0] = reportID

        let result = buffer.withUnsafeMutableBytes { ptr in

            IOHIDDeviceGetReport(
                device,
                kIOHIDReportTypeFeature,
                CFIndex(reportID),
                ptr.bindMemory(to: UInt8.self).baseAddress!,
                &length
            )
        }

        print("Feature Result : \(result)")
        print("Length : \(length)")

        if length > 0 {

            let hex = buffer.prefix(length)
                .map { String(format: "%02X", $0) }
                .joined(separator: " ")

            print(hex)
        }
    }
}
