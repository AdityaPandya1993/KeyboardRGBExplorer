//
//  RGBPacketExplorer.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
import IOKit.hid

final class RGBPacketExplorer {

    func start(device: IOHIDDevice) {

        Log.title("RGB Packet Explorer")

        DispatchQueue.global().async {

            // હાલ ફક્ત 0 થી 20 સુધી test કરીશું
            for command in UInt8(0)...20 {

                var report = [UInt8](repeating: 0, count: 64)

                report[0] = command

                let result = IOHIDDeviceSetReport(
                    device,
                    kIOHIDReportTypeOutput,
                    CFIndex(0),
                    &report,
                    report.count
                )

                Log.info("--------------------------------")
                Log.info(String(format: "Packet : %02X", command))
                Log.info("Result : \(result)")

                // અડધી સેકન્ડ રાહ જોવી
                Thread.sleep(forTimeInterval: 0.5)
            }

            Log.success("Explorer Finished")
        }
    }
}
