//
//  HIDReportTester.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class HIDReportTester {

    func readFeatureReport(device: IOHIDDevice) {

        var buffer = [UInt8](repeating: 0, count: 64)
        var length = buffer.count

        let result = IOHIDDeviceGetReport(
            device,
            kIOHIDReportTypeFeature,
            1,
            &buffer,
            &length
        )

        print("Feature Report Result: \(result)")
        print("Length: \(length)")
        Log.info(Hex.string(from: Array(buffer.prefix(length))))
    }
}
