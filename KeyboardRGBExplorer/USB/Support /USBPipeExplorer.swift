//
//  USBPipeExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

//
//  USBPipeExplorer.swift
//  KeyboardRGBExplorer
//

import Foundation
import IOKit

final class USBPipeExplorer {

    func start() {

        Log.title("USB Pipe Explorer")

        let matching = IOServiceMatching("IOUSBInterface")

        var iterator: io_iterator_t = 0

        guard IOServiceGetMatchingServices(
            kIOMainPortDefault,
            matching,
            &iterator
        ) == KERN_SUCCESS else {

            Log.error("Cannot enumerate interfaces")
            return
        }

        defer {
            IOObjectRelease(iterator)
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
                let vendor = property("idVendor", service) as? Int,
                let product = property("idProduct", service) as? Int
            else {
                continue
            }

            guard
                vendor == 0xC0F4,
                product == 0x07C0
            else {
                continue
            }

            Log.success("-----------------------------")

            dump(service)
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

    private func dump(_ service: io_registry_entry_t) {

        var properties: Unmanaged<CFMutableDictionary>?

        let result = IORegistryEntryCreateCFProperties(
            service,
            &properties,
            kCFAllocatorDefault,
            0
        )

        guard result == KERN_SUCCESS,
              let dict = properties?.takeRetainedValue()
                as? [String: Any] else {

            return
        }

        for (key,value) in dict.sorted(by:{$0.key < $1.key}) {

            print("\(key) : \(value)")
        }
    }
}
