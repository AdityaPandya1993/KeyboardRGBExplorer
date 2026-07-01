//
//  RGBPacketExplorerV3.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 30/06/26.
//

import Foundation
class RGBPacketExplorerV3 {

    func start(device: IOHIDDevice) {

        for reportID in UInt8(0)...255 {

            var packet = [UInt8](repeating: 0, count: 64)
            packet[0] = reportID

            let result = IOHIDDeviceSetReport(
                device,
                kIOHIDReportTypeOutput,
                CFIndex(reportID),
                packet,
                packet.count
            )

            print(String(format:"ReportID %02X -> %d", reportID, result))
        }

        print("Finished")
    }
}
