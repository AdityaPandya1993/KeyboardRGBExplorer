//
//  main.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import Foundation

let helper = HIDManagerHelper()
let scanner = HIDDeviceScanner()
let tester = HIDReportTester()
let outputTester = HIDOutputTester()
let monitor = HIDInputMonitor()
let usbExplorer = USBDeviceExplorer()
let devices = helper.scanDevices()


Log.title("Scanning HID Devices")
Log.info("Total Devices : \(devices.count)")

for (index, info) in devices.enumerated() {
    
    Log.title("Device \(index + 1)")
    
    scanner.printBasicInfo(device: info.device)
    
    scanner.printAllProperties(device: info.device)
    
    Log.title("Feature Reports")
    tester.readFeatureReport(device: info.device)
    
    Log.title("Output Reports")
    outputTester.sendTest(device: info.device)
    
    Log.title("Live Input Monitor")
    monitor.start(device: info.device)
    
    Log.title(info.product)

    Log.info("Manufacturer : \(info.manufacturer)")
    Log.info("Vendor ID    : \(String(format: "0x%04X", info.vendorID))")
    Log.info("Product ID   : \(String(format: "0x%04X", info.productID))")
    Log.info("Transport    : \(info.transport)")
    Log.info("Usage Page   : \(info.usagePage)")
    Log.info("Usage        : \(info.usage)")
}



// USB Explorer (Future Phase)
usbExplorer.start()

RunLoop.current.run()

//usbExplorer.start()



