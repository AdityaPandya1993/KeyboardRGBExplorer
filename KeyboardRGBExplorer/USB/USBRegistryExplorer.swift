//
//  USBRegistryExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.


import Foundation
import IOKit

final class USBRegistryExplorer {

    func dumpChildren(of device: io_service_t) {

        Log.title("USB Registry")

        var iterator: io_iterator_t = 0

        let result = IORegistryEntryGetChildIterator(
            device,
            kIOServicePlane,
            &iterator
        )

        guard result == KERN_SUCCESS else {

            Log.error("Unable to enumerate children")

            return
        }

        while true {

            let child = IOIteratorNext(iterator)

            if child == 0 {

                break
            }

            printNode(child)

            IOObjectRelease(child)
        }

        IOObjectRelease(iterator)
    }

    private func printNode(_ service: io_service_t) {

        var className = [CChar](repeating: 0, count: 128)

        IOObjectGetClass(service, &className)

        let name = String(cString: className)

        Log.separator()

        Log.info("Class : \(name)")

        if let cfName = IORegistryEntryCreateCFProperty(
            service,
            "USB Product Name" as CFString,
            kCFAllocatorDefault,
            0
        )?.takeRetainedValue() {

            Log.info("Name : \(cfName)")
        }
        
        let keys: [CFString] = [
            "bInterfaceNumber" as CFString,
            "bInterfaceClass" as CFString,
            "bInterfaceSubClass" as CFString,
            "bInterfaceProtocol" as CFString,
            "bNumEndpoints" as CFString
        ]

        for key in keys {

            if let value = IORegistryEntryCreateCFProperty(
                service,
                key,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() {

                Log.info("\(key) : \(value)")
            }
        }
    }
}
