//
//  VendorHIDCommander.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class VendorHIDCommander {

    static let shared = VendorHIDCommander()

    private init() { }

    func start() {

        Log.title("Vendor HID Commander")

    }
}
