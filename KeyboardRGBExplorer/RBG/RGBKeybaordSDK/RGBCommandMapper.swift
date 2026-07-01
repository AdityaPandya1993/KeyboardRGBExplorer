//
//  RGBCommandMapper.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit.hid

final class RGBCommandMapper {

    private let handshake = RGBHandshake()
    private let sender = RGBPacketSender()

    /// Change only this value before each run.
    
//    private let command: UInt8 = 0x08
//    private let command: UInt8 = 0x09
//    private let command: UInt8 = 0x0A
//    private let command: UInt8 = 0x0B
    //private let command: UInt8 = 0x0D
    //private let command: UInt8 = 0x0E
    //private let command: UInt8 = 0x0F
    
    
    /*
     | CMD | Binary | Num | Caps | Scroll | RGB |
     | --- | ------ | --- | ---- | ------ | --- |
     | 08  | 000    | ❌   | ❌    | ❌      | ❌   |
     | 09  | 001    | ✅   | ❌    | ❌      | ❌   |
     | 0A  | 010    | ❌   | ✅    | ❌      | ❌   |
     | 0B  | 011    | ✅   | ✅    | ❌      | ❌   |
     | 0C  | 100    | ❌   | ❌    | ✅      | ✅   |
     | 0D  | 101    | ✅   | ❌    | ✅      | ✅   |
     | 0E  | 110    | ❌   | ✅    | ✅      | ✅   |
     | 0F  | 111    | ✅   | ✅    | ✅      | ✅   |

     */

    private let command: UInt8 = 0x0C

    func start(device: IOHIDDevice) {

        Log.title("RGB Command Mapper")

        // Always initialize keyboard first
        handshake.start(device: device)

        Thread.sleep(forTimeInterval: 0.5)

        Log.info(String(format: "Testing Command : %02X", command))

        let result = sender.send(
            command: command,
            to: device
        )

        Log.info("Result : \(result)")

        Log.info("Observe keyboard for 5 seconds...")

        Thread.sleep(forTimeInterval: 5)

        Log.success("Test Finished")
    }
}
