//
//  Extensions.swift
//  Weather
//
//  Created by Arber Basha on 13/09/2019.
//  Copyright © 2019 Arber Basha. All rights reserved.
//

import Foundation

extension Formatter {
    static let stringFormatters: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
}

extension Decimal {
    var formattedString: String {
        return Formatter.stringFormatters.string(for: self) ?? ""
    }
}
