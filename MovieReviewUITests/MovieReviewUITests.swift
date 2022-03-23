//
//  MovieReviewUITests.swift
//  MovieReviewUITests
//
//  Created by 김민지 on 2022/01/29.
//

import XCTest

class MovieReviewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false    // 하나라도 실패하면 종료

        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()

        app = nil
    }

    func test_navigationBar의_title이_영화평점으로_설정되어있다() {
        let existsNavigationBar = app.navigationBars["영화 평점"].exists
        XCTAssertTrue(existsNavigationBar)
    }

    func test_searchBar가_존재한다() {
        let existsSearchBar = app.navigationBars["영화 평점"].searchFields["Search"].exists
        XCTAssertTrue(existsSearchBar)
    }

    func test_searchBar에_cancel버튼이_존재한다() {
        let navigationBar = app.navigationBars["영화 평점"]
        navigationBar.searchFields["Search"].tap()

        let existSearchBarCancelButton = navigationBar.buttons["Cancel"].exists
        XCTAssertTrue(existSearchBarCancelButton)
    }

    // BDD
    func test_영화가_즐겨찾기_되어있으면 () {
        let existsCell = app.collectionViews
            .cells
            .containing(.staticText, identifier: "소녀와 거미")
            .element
            .exists
        XCTAssertTrue(existsCell, "Title이 표시된 Cell이 존재한다")
    }

    func test_영화가_즐겨찾기_되어있지_않으면 () {
        let existsCell = app.collectionViews
            .cells
            .containing(.staticText, identifier: "007")
            .element
            .exists
        XCTAssertFalse(existsCell, "Title이 표시된 Cell이 존재하지 않는다")
    }
}
