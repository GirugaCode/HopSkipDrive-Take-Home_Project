//
//  Helper+Extension.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/21/21.
//

import Foundation

class Helper {
    
    /// Formats String date to output any Date format
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
        outFormatter.amSymbol = "a"
        outFormatter.pmSymbol = "p"

        let inStr = stringWithDate
        let date = inFormatter.date(from: inStr)!
        return outFormatter.string(from: date)
    }
    
    /// Formats double values of dollars to $xx.xx
    /// - Parameters:
    ///     - dollars: The double value you would like to format
    static func numberFormatDollars(dollars: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: dollars)
        let formattedValue = numberFormatter.string(from: number)
        
        return formattedValue
    }
}
