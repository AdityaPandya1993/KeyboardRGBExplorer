//
//  HIDDeviceFinder.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class HIDDeviceFinder {
    
    var hidDevice: IOHIDDevice?

    func start() {

        Log.title("HID Device Finder Started")

        let manager = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone))

        let matching: [String: Any] = [
            kIOHIDVendorIDKey: 0xC0F4,
            kIOHIDProductIDKey: 0x07C0
        ]

        IOHIDManagerSetDeviceMatching(manager, matching as CFDictionary)

        IOHIDManagerOpen(manager, IOOptionBits(kIOHIDOptionsTypeSeizeDevice))

        guard let devices = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice> else {
            Log.error("No HID devices found")
            return
        }

        for device in devices {
            Log.success("Keyboard HID Device Found 🎯")
            //RGBController.shared.setDevice(device)
        }
    }
}
