//
//  USBDeviceExplorer.swift
//  KeyboardRGBExplorer
//

import Foundation
import IOKit
import IOKit.usb

final class USBDeviceExplorer {
    
    private let registry = USBRegistryExplorer()

    func start() {

        Log.title("USB Explorer")

        let matchingDict = IOServiceMatching(kIOUSBDeviceClassName)

        var iterator: io_iterator_t = 0

        let result = IOServiceGetMatchingServices(
            kIOMainPortDefault,
            matchingDict,
            &iterator
        )

        guard result == KERN_SUCCESS else {

            Log.error("Unable to enumerate USB devices")

            return
        }

        while case let device = IOIteratorNext(iterator), device != 0 {

            printDevice(device)
            registry.dumpChildren(of: device)

            IOObjectRelease(device)
        }

        IOObjectRelease(iterator)
    }

    private func printDevice(_ device: io_service_t) {

        Log.separator()

        let keys: [CFString] = [

            "USB Product Name" as CFString,
            "USB Vendor Name" as CFString,
            "idVendor" as CFString,
            "idProduct" as CFString,
            "locationID" as CFString

        ]

        for key in keys {

            if let value = IORegistryEntryCreateCFProperty(
                device,
                key,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() {

                Log.info("\(key) : \(value)")
            }
        }
    }
}
