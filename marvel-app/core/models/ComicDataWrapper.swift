//
//  ComicDataWrapper.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation

struct ComicDataWrapper: Codable {
    public let code: Int?
    public let status: String?
    public let copyright: String?
    public let attributionText: String?
    public let attributionHTML: String?
    public let data: ComicDataContainer?
    public let etag: String?
}
