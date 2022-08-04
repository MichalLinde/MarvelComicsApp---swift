//
//  CreatorList.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation

struct CreatorList: Codable {
    public let available: Int?
    public let returned: Int?
    public let collectionURI: String?
    public let items: [CreatorSummary]?
}
