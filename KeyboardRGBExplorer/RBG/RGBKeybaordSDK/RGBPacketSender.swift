//
//  RGBPacketSender.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit
import IOKit.hid

final class RGBPacketSender {

    @discardableResult
    func send(
        reportID: UInt8 = 0,
        command: UInt8,
        payload: [UInt8] = [],
        to device: IOHIDDevice
    ) -> IOReturn {

        var report = [UInt8](repeating: 0, count: 64)

        report[0] = command

        for (index, value) in payload.enumerated() where index < 63 {
            report[index + 1] = value
        }

        let result = IOHIDDeviceSetReport(
            device,
            kIOHIDReportTypeOutput,
            CFIndex(reportID),
            &report,
            report.count
        )

        print("--------------------------------")
        print(String(format:"CMD : %02X", command))
        print("Payload :", payload)
        print("Result :", result)

        return result
    }
}
