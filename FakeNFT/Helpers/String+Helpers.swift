//
//  String+Helpers.swift
//  FakeNFT
//
//  Created by Emil on 09.10.2025.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self) could not be found in Localizable.strings")
    }
}
