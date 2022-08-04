//
//  Comic.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation

struct Comic: Codable {
    public let title: String?
    public let description: String?
    public let urls: [Url]?
    public let thumbnail: Image?
    public let creators: CreatorList?
}
