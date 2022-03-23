//
//  MovieListPresenterTests.swift
//  MovieReviewTests
//
//  Created by 김민지 on 2022/01/29.
//

import XCTest
@testable import MovieReview

class MovieListPresenterTests: XCTestCase {
    var sut: MovieListPresenter!

    var viewController: MockMovieListViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    var movieSearchManager: MockMovieSearchManager!

    override func setUp() {
        super.setUp()

        viewController = MockMovieListViewController()
        userDefaultsManager = MockUserDefaultsManager()
        movieSearchManager = MockMovieSearchManager()

        sut = MovieListPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager,
            movieSearchManager: movieSearchManager
        )
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
        viewController = nil
        userDefaultsManager = nil
        movieSearchManager = nil
    }

    // request메소드가 성공하면 updateSearchTableView가 실행됨
    func test_searchBar_textDidChange가_호출될때_request가_성공하면() {
        movieSearchManager.needToSuccessRequest = true
        sut.searchBar(UISearchBar(), textDidChange: "")
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행된다.")
    }
    // request메소드가 실패하면 updateSearchTableView가 실행되지 않음
    func test_searchBar_textDidChange가_호출될때_request가_실패하면() {
        movieSearchManager.needToSuccessRequest = false
        sut.searchBar(UISearchBar(), textDidChange: "")
        XCTAssertFalse(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행되지 않는다.")
    }

    func test_viewDidLoad가_호출되면() {
        sut.viewDidLoad()
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupSearchBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }

    func test_viewWillAppear가_호출되면() {
        sut.viewWillApear()
        XCTAssertTrue(userDefaultsManager.isCalledGetMovies)
        XCTAssertTrue(viewController.isCalledUpdateCollectionView)
    }

    func test_searchBarTextDidBeginEditing이_호출되면() {
        sut.searchBarTextDidBeginEditing(UISearchBar())
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
    }

    func test_searchBarCancelButtonClicked이_호출되면() {
        sut.searchBarCancelButtonClicked(UISearchBar())
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
    }
}
