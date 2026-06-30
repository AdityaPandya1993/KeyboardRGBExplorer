//
//  USBInterfaceOpener.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit

final class USBInterfaceOpener {

    func start() {

        Log.title("USB Interface Opener")

        let matching = IOServiceMatching("IOUSBInterface")

        var iterator: io_iterator_t = 0

        let result = IOServiceGetMatchingServices(
            kIOMainPortDefault,
            matching,
            &iterator
        )

        guard result == KERN_SUCCESS else {
            Log.error("Cannot enumerate interfaces")
            return
        }

        while true {

            let service = IOIteratorNext(iterator)

            if service == 0 {
                break
            }

            defer {
                IOObjectRelease(service)
            }

            guard
                let vendor = property(
                    "idVendor",
                    service
                ) as? Int,

                let product = property(
                    "idProduct",
                    service
                ) as? Int

            else {

                continue

            }

            guard
                vendor == 0xC0F4,
                product == 0x07C0
            else {
                continue
            }

            Log.success("Keyboard Interface Found")

            printProperty("bInterfaceNumber", service)
            printProperty("bInterfaceClass", service)
            printProperty("bInterfaceSubClass", service)
            printProperty("bInterfaceProtocol", service)
            printProperty("bNumEndpoints", service)

        }

    }

    private func property(
        _ key: String,
        _ service: io_registry_entry_t
    ) -> Any? {

        IORegistryEntryCreateCFProperty(
            service,
            key as CFString,
            kCFAllocatorDefault,
            0
        )?.takeRetainedValue()

    }

    private func printProperty(
        _ key: String,
        _ service: io_registry_entry_t
    ) {

        if let value = property(key, service) {

            Log.info("\(key) : \(value)")

        }

    }

}
