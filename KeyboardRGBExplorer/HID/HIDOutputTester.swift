//
//  HIDOutputTester.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class HIDOutputTester {

    func sendTest(device: IOHIDDevice) {

        for reportID in 0...5 {

            var buffer = [UInt8](repeating: 0, count: 64)

            buffer[0] = 0x00

            let result = IOHIDDeviceSetReport(
                device,
                kIOHIDReportTypeOutput,
                CFIndex(reportID),
                &buffer,
                buffer.count
            )

            Log.info("Output Report \(reportID) -> \(result)")
        }
    }
}
