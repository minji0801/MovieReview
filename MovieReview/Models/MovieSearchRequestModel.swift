//
//  MovieSearchRequestModel.swift
//  MovieReview
//
//  Created by 김민지 on 2022/01/29.
//

import Foundation

/// API Network Request Model
struct MovieSearchRequestModel: Codable {
    let query: String
}
