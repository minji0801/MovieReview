//
//  MovieDetailPresenterTests.swift
//  MovieReviewTests
//
//  Created by 김민지 on 2022/03/23.
//

import XCTest
@testable import MovieReview

class MovieDetailPresenterTests: XCTestCase {
    var sut: MovieDetailPresenter!

    var viewController: MockMovieDefailViewController!
    var movie: Movie!
    var userDefaultsManager: MockUserDefaultsManager!

    override func setUp() {
        super.setUp()

        viewController = MockMovieDefailViewController()
        movie = Movie(title: "", imageURL: "", userRating: "", actor: "", director: "", pubDate: "")
        userDefaultsManager = MockUserDefaultsManager()

        sut = MovieDetailPresenter(
            viewController: viewController,
            movie: movie,
            userDefaultsManager: userDefaultsManager
        )
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        movie = nil
        userDefaultsManager = nil

        super.tearDown()
    }

    func test_viewDidLoad가_호출될때() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetViews)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }

    func test_didTapRightBarButtonItem이_호출될때_isLiked가_true가되면() {
        movie.isLiked = false
        sut = MovieDetailPresenter(
            viewController: viewController,
            movie: movie,
            userDefaultsManager: userDefaultsManager
        )

        sut.didTaprightBarButtonItem()

        XCTAssertTrue(userDefaultsManager.isCalledAddMovie)
        XCTAssertFalse(userDefaultsManager.isCalledRemoveMovie)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }

    func test_didTapRightBarButtonItem이_호출될때_isLiked가_false가되면() {
        movie.isLiked = true
        sut = MovieDetailPresenter(
            viewController: viewController,
            movie: movie,
            userDefaultsManager: userDefaultsManager
        )

        sut.didTaprightBarButtonItem()

        XCTAssertFalse(userDefaultsManager.isCalledAddMovie)
        XCTAssertTrue(userDefaultsManager.isCalledRemoveMovie)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
}
