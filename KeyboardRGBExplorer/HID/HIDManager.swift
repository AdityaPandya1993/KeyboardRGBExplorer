//
//  HIDManager.swift
//  MacHIDExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class HIDManagerHelper {

    // MARK: - Properties

    private let vendorID = 0xC0F4
    private let productID = 0x07C0

    private let manager: IOHIDManager

    // MARK: - Initializer

    init() {
        manager = IOHIDManagerCreate(
            kCFAllocatorDefault,
            IOOptionBits(kIOHIDOptionsTypeNone)
        )
    }
    
    //MARK: Open Device
    func open(_ device: IOHIDDevice) -> Bool {

        let result = IOHIDDeviceOpen(
            device,
            IOOptionBits(kIOHIDOptionsTypeNone)
        )

        Log.info("IOHIDDeviceOpen : \(result)")

        return result == kIOReturnSuccess
    }

    // MARK: - Device Scan

    func scanDevices() -> [HIDDeviceInfo] {

        let matching: NSDictionary = [
            kIOHIDVendorIDKey: vendorID,
            kIOHIDProductIDKey: productID
        ]

        IOHIDManagerSetDeviceMatching(manager, matching)

        let result = IOHIDManagerOpen(manager, IOOptionBits(kIOHIDOptionsTypeNone))

        Log.info("Manager Open Result : \(result)")

        guard let deviceSet = IOHIDManagerCopyDevices(manager) as? Set<IOHIDDevice> else {

            Log.warning("No HID Devices Found")
            return []
        }

        var devices: [HIDDeviceInfo] = []

        for device in deviceSet {

            let info = HIDDeviceInfo(

                device: device,

                manufacturer: stringProperty(
                    kIOHIDManufacturerKey as CFString,
                    from: device
                ),

                product: stringProperty(
                    kIOHIDProductKey as CFString,
                    from: device
                ),

                transport: stringProperty(
                    kIOHIDTransportKey as CFString,
                    from: device
                ),

                vendorID: intProperty(
                    kIOHIDVendorIDKey as CFString,
                    from: device
                ),

                productID: intProperty(
                    kIOHIDProductIDKey as CFString,
                    from: device
                ),

                usagePage: intProperty(
                    kIOHIDPrimaryUsagePageKey as CFString,
                    from: device
                ),

                usage: intProperty(
                    kIOHIDPrimaryUsageKey as CFString,
                    from: device
                )
            )

            devices.append(info)
            
            if open(device) {

                Log.success("Device Opened")

            } else {

                Log.error("Cannot Open Device")
            }
        }

        Log.success("Found \(devices.count) HID Device(s)")
        
        

        return devices
    }

    // MARK: - RunLoop

    func startRunLoop() {

        IOHIDManagerScheduleWithRunLoop(
            manager,
            CFRunLoopGetCurrent(),
            CFRunLoopMode.defaultMode.rawValue
        )

        CFRunLoopRun()
    }

    // MARK: - Helper Methods

    func stringProperty(
        _ key: CFString,
        from device: IOHIDDevice
    ) -> String {

        return IOHIDDeviceGetProperty(device, key) as? String ?? ""
    }

    func intProperty(
        _ key: CFString,
        from device: IOHIDDevice
    ) -> Int {

        return IOHIDDeviceGetProperty(device, key) as? Int ?? 0
    }
}
