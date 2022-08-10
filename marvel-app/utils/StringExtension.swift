//
//  StringExtension.swift
//  marvel-app
//
//  Created by Michal on 10/08/2022.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
