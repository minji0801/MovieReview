//
//  MockMovieDefailViewController.swift
//  MovieReviewTests
//
//  Created by 김민지 on 2022/03/23.
//

import Foundation
@testable import MovieReview
final class MockMovieDefailViewController: MovieDetailProtocol {
    var isCalledSetViews = false
    var isCalledSetRightBarButton = false

    var settedIsLiked = false

    func setViews(with movie: Movie) {
        isCalledSetViews = true
    }

    func setRightBarButton(with isLiked: Bool) {
        settedIsLiked = isLiked
        isCalledSetRightBarButton = true
    }
}
