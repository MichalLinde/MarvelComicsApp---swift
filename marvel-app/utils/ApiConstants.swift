//
//  ApiConstants.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

struct ApiConstants {
    static let baseUrl = "https://gateway.marvel.com/v1/public/comics"
    static let apiKey = "8e6eaff2babc82d749bb7e1f5586a85a"
    static let privateKey = "6ca43e1e43e8696e0d09bc35ccb20593c6ffc715"
    static var timeStamp: String = String(NSDate().timeIntervalSince1970)
}
