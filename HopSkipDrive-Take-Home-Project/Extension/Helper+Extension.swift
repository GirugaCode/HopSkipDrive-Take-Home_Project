//
//  Helper+Extension.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/21/21.
//

import Foundation

class Helper {
    
    /// Formates String date to output any Date format
    /// - Parameters:
    ///     - stringWithDate: The string date you would like to convert
    ///     - inDateFormat: The intaking date format the stringWithDate is
    ///     - outDateFormat: Choice of date format as the output
    static func dateTimeChangeFormat(str stringWithDate: String, inDateFormat: String, outDateFormat: String) -> String {
        let inFormatter = DateFormatter()
        inFormatter.locale = Locale(identifier: "en_US_POSIX")
        inFormatter.dateFormat = inDateFormat

        let outFormatter = DateFormatter()
        outFormatter.locale = Locale(identifier: "en_US_POSIX")
        outFormatter.dateFormat = outDateFormat

        let inStr = stringWithDate
        let date = inFormatter.date(from: inStr)!
        return outFormatter.string(from: date)
    }
}
