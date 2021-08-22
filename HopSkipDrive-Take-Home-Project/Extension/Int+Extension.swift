//
//  Int+Extension.swift
//  HopSkipDrive-Take-Home-Project
//
//  Created by Ryan Nguyen on 8/21/21.
//

import Foundation

extension Int {
    
    /// Converts cents(Int) to Double value in dollars
    func centsToDollars() -> Double {
        Double(self) / 100
    }
}
