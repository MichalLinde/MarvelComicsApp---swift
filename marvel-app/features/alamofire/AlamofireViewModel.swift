//
//  AlamofireViewModel.swift
//  marvel-app
//
//  Created by Michal on 05/08/2022.
//

import Foundation
import Combine

class AlamofireViewModel: ObservableObject{

    @Published var comics: ComicDataWrapper?

    var alamofireProtocol: AlamofireProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(alamofireProtocol: AlamofireProtocol = AlamofireClient.shared) {
        self.alamofireProtocol = alamofireProtocol
        fetchComicsAlamo()
    }

    func fetchComicsAlamo(){
        alamofireProtocol.fetchComicsAlamo()
            .sink{ (dataResponse) in
                if dataResponse.error == nil, let responseValue = dataResponse.value{
                    self.comics = responseValue
                } else{
                    print("\(String(describing: dataResponse.error))")
                }
            }.store(in: &cancellables)
    }
}
