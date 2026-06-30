//
//  USBEndpointExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit
import IOKit.usb

final class USBEndpointExplorer {

    func start() {

        Log.title("USB Endpoint Explorer")

        let matching = IOServiceMatching("IOUSBInterface")

        var iterator: io_iterator_t = 0

        guard IOServiceGetMatchingServices(kIOMainPortDefault,
                                           matching,
                                           &iterator) == KERN_SUCCESS else {
            return
        }

        defer {
            IOObjectRelease(iterator)
        }

        while case let service = IOIteratorNext(iterator), service != 0 {

            print("--------------------------------")

            if let interfaceNumber = IORegistryEntryCreateCFProperty(
                service,
                "bInterfaceNumber" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() {

                Log.info("Interface : \(interfaceNumber)")
            }

            if let endpoint = IORegistryEntryCreateCFProperty(
                service,
                "bNumEndpoints" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() {

                Log.info("Endpoints : \(endpoint)")
            }

            if let interfaceClass = IORegistryEntryCreateCFProperty(
                service,
                "bInterfaceClass" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() {

                Log.info("Class : \(interfaceClass)")
            }

            if let protocolValue = IORegistryEntryCreateCFProperty(
                service,
                "bInterfaceProtocol" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() {

                Log.info("Protocol : \(protocolValue)")
            }

            if let subclass = IORegistryEntryCreateCFProperty(
                service,
                "bInterfaceSubClass" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() {

                Log.info("Subclass : \(subclass)")
            }

            // Dump every property
            var properties: Unmanaged<CFMutableDictionary>?

            let result = IORegistryEntryCreateCFProperties(
                service,
                &properties,
                kCFAllocatorDefault,
                0
            )

            if result == KERN_SUCCESS,
               let dict = properties?.takeRetainedValue() as? [String: Any] {

                for (key, value) in dict.sorted(by: { $0.key < $1.key }) {

                    if key.lowercased().contains("endpoint") ||
                       key.lowercased().contains("pipe") ||
                       key.lowercased().contains("address") {

                        Log.info("\(key) : \(value)")
                    }
                }
            }

            IOObjectRelease(service)
        }
    }
}
