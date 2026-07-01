//
//  RGBPacketSender.swift
//  KeyboardRGBExplorer
//
//  Created by ADITYA PANDYA on 01/07/26.
//

import Foundation
import IOKit
import IOKit.hid

final class RGBPacketSender {
    
    @discardableResult
    func sendReport(
        reportID: UInt8 = 0,
        command: UInt8,
        payload: [UInt8] = [],
        to device: IOHIDDevice
    ) -> IOReturn {

        var report = [UInt8](repeating: 0, count: 65)

        report[0] = reportID
        report[1] = command

        for (index, value) in payload.enumerated() where index < 63 {
            report[index + 2] = value
        }

        let reportLength = report.count

        let result = report.withUnsafeMutableBytes { rawBuffer in

            guard let pointer = rawBuffer.bindMemory(to: UInt8.self).baseAddress else {
                return kIOReturnError
            }

            return IOHIDDeviceSetReport(
                device,
                kIOHIDReportTypeOutput,
                CFIndex(reportID),
                pointer,
                reportLength
            )
        }

        print("--------------------------------")
        print(String(format: "ReportID : %02X", reportID))
        print(String(format: "Command  : %02X", command))
        print("Result    :", result)

        return result
    }
    
    @discardableResult
    func sendRaw(
        reportID: UInt8 = 0,
        packet: [UInt8],
        to device: IOHIDDevice
    ) -> IOReturn {

        var report = packet

        // Always send a 64-byte report
        if report.count < 64 {
            report += [UInt8](repeating: 0, count: 64 - report.count)
        }

        if report.count > 64 {
            report = Array(report.prefix(64))
        }

        let result = IOHIDDeviceSetReport(
            device,
            kIOHIDReportTypeOutput,
            CFIndex(reportID),
            &report,
            report.count
        )

        print("--------------------------------")
        print("RAW Packet")

        for byte in report {
            print(String(format: "%02X", byte), terminator: " ")
        }

        print("")
        print("Result :", result)
        print(String(format: "0x%08X", result))
        return result
    }

    @discardableResult
    func send(
        reportID: UInt8 = 0,
        command: UInt8,
        payload: [UInt8] = [],
        to device: IOHIDDevice
    ) -> IOReturn {

        var report = [UInt8](repeating: 0, count: 64)

        report[0] = command

        for (index, value) in payload.enumerated() where index < 63 {
            report[index + 1] = value
        }

        let result = IOHIDDeviceSetReport(
            device,
            kIOHIDReportTypeOutput,
            CFIndex(reportID),
            &report,
            report.count
        )

        print("--------------------------------")
        print(String(format:"CMD : %02X", command))
        print("Payload :", payload)
        print("Result :", result)

        return result
    }
}
