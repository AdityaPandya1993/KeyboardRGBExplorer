//
//  USBControlTransfer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.


import Foundation
import IOKit
import IOKit.usb

final class USBControlTransfer {

    private var deviceInterface:
        UnsafeMutablePointer<UnsafeMutablePointer<IOUSBDeviceInterface>>?

    private func releaseDevice() {

        if let device = deviceInterface {

            device.pointee.pointee.USBDeviceClose(device)
            device.pointee.pointee.Release(device)

            deviceInterface = nil
        }
    }

    deinit {
        releaseDevice()
    }

    func start() {

        Log.title("USB Control Transfer")

        var matching = IOServiceMatching(kIOUSBDeviceClassName)

        let iterator = UnsafeMutablePointer<io_iterator_t>.allocate(capacity: 1)
        defer {
            iterator.deallocate()
        }

        let kr = IOServiceGetMatchingServices(
            kIOMainPortDefault,
            matching,
            iterator
        )

        guard kr == KERN_SUCCESS else {

            Log.error("Cannot enumerate USB devices")
            return
        }

        while case let service = IOIteratorNext(iterator.pointee), service != 0 {

            defer {
                IOObjectRelease(service)
            }

            let vendor =
            IORegistryEntryCreateCFProperty(
                service,
                "idVendor" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() as? Int ?? 0

            let product =
            IORegistryEntryCreateCFProperty(
                service,
                "idProduct" as CFString,
                kCFAllocatorDefault,
                0
            )?.takeRetainedValue() as? Int ?? 0

            Log.info(String(
                format: "VID: 0x%04X PID: 0x%04X",
                vendor,
                product
            ))

            if vendor == 0xC0F4 &&
                product == 0x07C0 {

                Log.success("RGB Keyboard Found")
                Log.success("RGB Keyboard Found")

                // Next Step:
                // Create Plug-In Interface
            }
        }
    }
}
