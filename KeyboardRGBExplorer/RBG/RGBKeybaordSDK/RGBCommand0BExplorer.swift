//
//  RGBCommand0BExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit
import IOKit.hid

final class RGBCommand0BExplorer {

    func start(device: IOHIDDevice) {

        RGBHandshake().start(device: device)

        for value: UInt8 in 0...255 {

            var report = [UInt8](repeating: 0, count: 64)

            report[0] = 0x0B
            report[1] = value

            let result = IOHIDDeviceSetReport(
                device,
                kIOHIDReportTypeOutput,
                0,
                &report,
                report.count
            )

            print("--------------------------------")
            print(String(format: "0B  %02X", value))
            print("Result :", result)

            Thread.sleep(forTimeInterval: 1.0)
        }
    }
}
