//
//  ApiClient.swift
//  marvel-app
//
//  Created by Michal on 01/08/2022.
//

import Foundation
import CryptoKit

class ApiClient {
    
    func fetchComics() async throws -> Data {
                
        let toHash = "\(ApiConstants.timeStamp)\(ApiConstants.privateKey)\(ApiConstants.apiKey)"

        let url = URL(string: "\(ApiConstants.baseUrl)?ts=\(ApiConstants.timeStamp)&apikey=\(ApiConstants.apiKey)&hash=\(MD5(string: toHash))")
        
        guard let url = url else {
            throw FetchingError.invalidUrl
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
            
        } catch {
            throw FetchingError.failedFetching(message: "Failed in ApiClient")
        }
    }
    
    func searchComics(searchText: String) async throws -> Data {
        
        let toHash = "\(ApiConstants.timeStamp)\(ApiConstants.privateKey)\(ApiConstants.apiKey)"
        let url = URL(string: "\(ApiConstants.baseUrl)?titleStartsWith=\(searchText)&ts=\(ApiConstants.timeStamp)&apikey=\(ApiConstants.apiKey)&hash=\(MD5(string: toHash))")
        
        print("\(ApiConstants.baseUrl)?titleStartsWith=\(searchText)&ts=\(ApiConstants.timeStamp)&apikey=\(ApiConstants.apiKey)&hash=\(MD5(string: toHash))")
        
        guard let url = url else {
            throw FetchingError.invalidUrl
        }
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw FetchingError.failedFetching(message: "Failed in ApiClient")
        }
    }
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

enum FetchingError: Error{
    case failedFetching(message: String)
    case invalidUrl
}

