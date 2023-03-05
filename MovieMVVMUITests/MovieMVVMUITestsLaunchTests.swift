// MovieMVVMUITestsLaunchTests.swift
// Copyright © Alexandr T. All rights reserved.

import XCTest

/// Запуск UI фильмов тестов
final class MovieHWUITestsLaunchTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let launchScreenName = "Launch Screen"
    }

    // MARK: - Public Properties

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = Constants.launchScreenName
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
