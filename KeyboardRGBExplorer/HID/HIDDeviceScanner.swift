//
//  HIDDeviceScanner.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class HIDDeviceScanner {
    
    func printBasicInfo(device: IOHIDDevice) {

        print("====================")

        print("Manufacturer:",
              IOHIDDeviceGetProperty(device, kIOHIDManufacturerKey as CFString) ?? "N/A")

        print("Product:",
              IOHIDDeviceGetProperty(device, kIOHIDProductKey as CFString) ?? "N/A")

        print("Vendor ID:",
              IOHIDDeviceGetProperty(device, kIOHIDVendorIDKey as CFString) ?? "N/A")

        print("Product ID:",
              IOHIDDeviceGetProperty(device, kIOHIDProductIDKey as CFString) ?? "N/A")

        print("Usage Page:",
              IOHIDDeviceGetProperty(device, kIOHIDPrimaryUsagePageKey as CFString) ?? "N/A")

        print("Usage:",
              IOHIDDeviceGetProperty(device, kIOHIDPrimaryUsageKey as CFString) ?? "N/A")

        print("====================")
    }
    
    func printAllProperties(device: IOHIDDevice) {

        guard let properties = IOHIDDeviceCopyMatchingElements(device, nil, 0) as? [IOHIDElement] else {
            return
        }

        print("Total Elements: \(properties.count)")

        for element in properties {

            print("""
            ------------------------
            Usage Page : \(IOHIDElementGetUsagePage(element))
            Usage      : \(IOHIDElementGetUsage(element))
            Report ID  : \(IOHIDElementGetReportID(element))
            Report Size: \(IOHIDElementGetReportSize(element))
            Report Count: \(IOHIDElementGetReportCount(element))
            Type       : \(IOHIDElementGetType(element))
            """)
        }
    }

}
