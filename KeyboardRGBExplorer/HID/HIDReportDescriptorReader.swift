//
//  HIDReportDescriptorReader.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit.hid

final class HIDReportDescriptorReader {

    func start(device: IOHIDDevice) {

        Log.title("HID Report Descriptor")

        guard let descriptor =
            IOHIDDeviceGetProperty(
                device,
                kIOHIDReportDescriptorKey as CFString
            )
        else {

            Log.error("Descriptor not found")
            return
        }

        guard let data = descriptor as? Data else {

            Log.error("Descriptor is not Data")
            return
        }

        Log.success("Descriptor Size : \(data.count) bytes")
        print("")

        var offset = 0

        for byte in data {

            print(String(format:"%02X ", byte), terminator: "")

            offset += 1

            if offset % 16 == 0 {

                print("")

            }
        }

        print("")
    }
}
