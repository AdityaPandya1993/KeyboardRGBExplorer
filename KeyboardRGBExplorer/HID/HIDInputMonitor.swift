//
//  HIDInputMonitor.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

class HIDInputMonitor {

    private var reportBuffer = [UInt8](repeating: 0, count: 64)

    func start(device: IOHIDDevice) {

        IOHIDDeviceRegisterInputReportCallback(
            device,
            &reportBuffer,
            reportBuffer.count,
            { context, result, sender, type, reportID, report, reportLength in

                let bytes = UnsafeBufferPointer(
                    start: report,
                    count: reportLength
                )

                Log.info(Hex.string(from: Array(bytes)))
            },
            nil
        )

        IOHIDDeviceScheduleWithRunLoop(
            device,
            CFRunLoopGetCurrent(),
            CFRunLoopMode.defaultMode.rawValue
        )
    }
}
