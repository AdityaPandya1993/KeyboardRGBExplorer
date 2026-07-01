//
//  main.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation

//let helper = HIDManagerHelper()
//let scanner = HIDDeviceScanner()
//let tester = HIDReportTester()
//let outputTester = HIDOutputTester()
//let monitor = HIDInputMonitor()
//let usbExplorer = USBDeviceExplorer()

//let interfaceExplorer = USBInterfaceExplorer()
//let endpointExplorer = USBEndpointExplorer()
//let finder = USBVendorInterfaceFinder()
//let opener = USBInterfaceOpener()
//let rgbTester = RGBCommandTester()

//let explorerV2 = RGBPacketExplorerV2()
//let protocolExplorer = RGBProtocolExplorer()
//let explorerV3 = RGBPacketExplorerV3()
////coumitcate ... USB KeyBaord
//let controlTransfer = USBControlTransfer()

//let commandExplorer = RGBCommandExplorer()
//let descriptorReader = HIDReportDescriptorReader()
//let pipeExplorer = USBPipeExplorer()
//let RGBPayLoad = RGBPacketExplorer()
//let RGBPacketMap = RGBPacketMapper()


//Log.title("Scanning HID Devices")
//Log.info("Total Devices : \(devices.count)")
//
//for (index, info) in devices.enumerated() {
//
//    Log.title("Device \(index + 1)")
//
//    //scanner.printBasicInfo(device: info.device)
//    //scanner.printAllProperties(device: info.device)
//    
//    RGBPacketMap.test(device: info.device)
//    //RGBPayLoad.start(device: info.device)
//    
//    Log.title("Feature Reports")
//    //tester.readFeatureReport(device: info.device)
//    
//    
//
//    Log.info("Manufacturer : \(info.manufacturer)")
//    Log.info("Vendor ID    : \(String(format:"0x%04X", info.vendorID))")
//    Log.info("Product ID   : \(String(format:"0x%04X", info.productID))")
//
//    if info.vendorID == 0xC0F4 &&
//       info.productID == 0x07C0 {
//
//        Log.success("Target RGB Keyboard")
//
//        Log.title("Output Reports")
//        //outputTester.sendTest(device: info.device)
//
//        Log.title("RGB Command Tester")
//       // rgbTester.test(device: info.device)
//        
//        
//        //commandExplorer.start(device: info.device)
//        //descriptorReader.start(device: info.device)
//        // packetExplorer.start(device: info.device)
//        //Log.title("RGB Packet Testing")
//        //explorerV3.start(device: info.device)
//        
//        Log.title("RGB Handshake")
//        //handshake.start(device: info.device)
//        
//        //protocolExplorer.start(device: info.device)
//
//        Log.title("Live Input Monitor")
//        //monitor.start(device: info.device)
//    }
//}
//
////usbExplorer.start()
////interfaceExplorer.explore()
////endpointExplorer.start()
//finder.start()
////opener.start()
////controlTransfer.start()
////pipeExplorer.start()
//
//RunLoop.current.run()


let helper = HIDManagerHelper()
let scanner = HIDDeviceScanner()
let packetMapper = RGBPacketMapper()
let RGBComman0BExpore = RGBCommandExplorer()
let handshake = RGBHandshake() // Perfect to start static RGB Light all in Keyboard
//let packetExplorer = RGBPacketExplorer() // Findout RGB Lights On Packet 04 to 07

let devices = helper.scanDevices()

for (_, info) in devices.enumerated() {

    
    handshake.start(device: info.device)
    RGBComman0BExpore.start(device: info.device)

    if info.vendorID == 0xC0F4 &&
       info.productID == 0x07C0 {

        Log.success("Target RGB Keyboard")
        //packetExplorer.start(device: info.device)
       
    }
}

RunLoop.current.run()


