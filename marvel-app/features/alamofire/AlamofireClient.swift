//
//  AlamofireClient.swift
//  marvel-app
//
//  Created by Michal on 04/08/2022.
//

import Foundation
import Alamofire
import CryptoKit
import Combine


class AlamofireClient {
    static let shared: AlamofireProtocol = AlamofireClient()
    private init() {}
    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
    

extension AlamofireClient: AlamofireProtocol{
    func fetchComicsAlamo() -> AnyPublisher<DataResponse<ComicDataWrapper, AFError>, Never> {
        let toHash = "\(ApiConstants.timeStamp)\(ApiConstants.privateKey)\(ApiConstants.apiKey)"

        let url = "\(ApiConstants.baseUrl)?ts=\(ApiConstants.timeStamp)&apikey=\(ApiConstants.apiKey)&hash=\(MD5(string: toHash))"

        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: ComicDataWrapper.self)
            .map{ response in
                response.mapError{ error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

