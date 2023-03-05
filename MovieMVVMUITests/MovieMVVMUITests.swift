// MovieMVVMUITests.swift
// Copyright © Alexandr T. All rights reserved.

import XCTest

/// UI тесты фильмов
final class MovieHWUITests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let tableViewIdentifier = "moviesTableViewIdentifier"
        static let tableViewCellIdentifier = "5"
    }

    // MARK: - Pulic Methods

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables[Constants.tableViewIdentifier]
        tableView.swipeDown()
        tableView.swipeUp()
        tableView.cells.element(matching: .cell, identifier: Constants.tableViewCellIdentifier).tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
