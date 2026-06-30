//
//  USBVendorInterfaceFinder.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit

final class USBVendorInterfaceFinder {

    func start() {

        Log.title("Vendor Interface Finder")

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

        while case let service = IOIteratorNext(iterator), service != 0 {

            defer {
                IOObjectRelease(service)
            }

            let vendor =
            IORegistryEntryCreateCFProperty(
                service,
                "idVendor" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue()

            let product =
            IORegistryEntryCreateCFProperty(
                service,
                "idProduct" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue()

            guard
                let v = vendor as? Int,
                let p = product as? Int
            else {
                continue
            }

            if v == 0xC0F4 &&
               p == 0x07C0 {

                Log.success("RGB Keyboard Interface Found")

                Log.info("Class : \(IOObjectCopyClass(service).takeRetainedValue() as String)")

            }

        }

    }

}
