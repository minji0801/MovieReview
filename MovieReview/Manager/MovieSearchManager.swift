//
//  MovieSearchManager.swift
//  MovieReview
//
//  Created by 김민지 on 2022/01/29.
//

import Alamofire
import Foundation

protocol MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void)
}

struct MovieSearchManager: MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }

        let parameters = MovieSearchRequestModel(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "vG95SRrIYs7muxvV4t19",
            "X-Naver-Client-Secret": "nZkbphXlYx"
        ]

        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(of: MovieSearchResponseModel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.items)
            case .failure(let error):
                print(error)
            }
        }
        .resume()
    }
}
