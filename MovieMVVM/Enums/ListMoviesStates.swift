// ListMoviesStates.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Состояния экрана со списком фильмов
enum ListMoviesState {
    case initial
    case loading
    case success([MovieData])
    case failure(Error)
}
