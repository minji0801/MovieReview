//
//  MovieSearchResponseModel.swift
//  MovieReview
//
//  Created by 김민지 on 2022/01/29.
//

import Foundation

/// API Network Response Model
struct MovieSearchResponseModel: Decodable {
    var items: [Movie] = []
}
