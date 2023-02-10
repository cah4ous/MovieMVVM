// CoreDataServiceProtocol.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

protocol CoreDataServiceProtocol {
    func saveContext(movies: [Movie], movieCategory: CategoryMovies)
    func getData(movieType: CategoryMovies) -> [MovieData]
}
