//
//  AlamofireProtocol.swift
//  marvel-app
//
//  Created by Michal on 05/08/2022.
//

import Foundation
import Alamofire
import Combine

protocol AlamofireProtocol{
    func fetchComicsAlamo() -> AnyPublisher<DataResponse<ComicDataWrapper, AFError>, Never>
}
