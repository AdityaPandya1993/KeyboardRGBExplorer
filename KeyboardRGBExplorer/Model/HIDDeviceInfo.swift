//
//  HIDDeviceInfo.swift
//  MacHIDExplorer
//

import Foundation
import IOKit.hid

struct HIDDeviceInfo {

    // Original HID Device
    let device: IOHIDDevice

    // Basic Information
    let manufacturer: String
    let product: String
    let transport: String

    // IDs
    let vendorID: Int
    let productID: Int

    // HID Usage
    let usagePage: Int
    let usage: Int
}
