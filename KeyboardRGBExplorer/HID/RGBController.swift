//
//  RGBController.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class RGBController {

    static let shared = RGBController()
    private init() {}

    var device: IOHIDDevice?

    func setDevice(_ device: IOHIDDevice) {
        self.device = device
        print("Device attached 🔥")
    }

    func send(_ bytes: [UInt8], reportID: Int = 0) {

        guard let device = device else {
            print("No device")
            return
        }

        var report = bytes

        IOHIDDeviceSetReport(
            device,
            kIOHIDReportTypeOutput,
            CFIndex(reportID),
            &report,
            report.count
        )

        print("Sent:", bytes)
    }
}
