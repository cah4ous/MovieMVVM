// AssemblyBuilderTests.swift
// Copyright © Alexandr T. All rights reserved.

import CoreData
@testable import MovieMVVM
import XCTest

/// Тест сборщика экранов
final class AssemblyBuilderTests: XCTestCase {
    // MARK: - Private Constants

    private enum Constants {
        static let mockContextName = "MovieDataModel"
        static let mockEntityName = "MovieData"
    }

    // MARK: - Private Properties

    private var assemblyBuilder: AssemblyBuilderProtocol?

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        assemblyBuilder = ModuleBuilder()
    }

    override func tearDown() {
        super.tearDown()
        assemblyBuilder = nil
    }

    func testMainModule() {
        let mainModule = assemblyBuilder?.makeMainModule()
        XCTAssertTrue(mainModule is MoviesViewController)
    }

    func testDetailModule() {
        let mockContext = NSPersistentContainer(name: Constants.mockContextName).viewContext
        guard let mockEntity = NSEntityDescription.entity(forEntityName: Constants.mockEntityName, in: mockContext)
        else { return }
        let mockMovieData = MovieData(entity: mockEntity, insertInto: mockContext)
        let detailModule = assemblyBuilder?.makeDetailModule(movie: mockMovieData)
        XCTAssertTrue(detailModule is DetailViewController)
    }
}
