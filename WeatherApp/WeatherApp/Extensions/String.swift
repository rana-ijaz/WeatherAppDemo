//
//  String.swift
//  ListingsApp
//
//  Created by Rana Ijaz on 20/08/2022.
//

import Foundation

extension String {
    static func isSringEmpty(_ value: String?) -> Bool {
        guard let _ = value else {
            return false
        }

        return !(value ?? "").isEmpty
    }
}
