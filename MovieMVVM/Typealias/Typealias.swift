// Typealias.swift
// Copyright © Alexandr T. All rights reserved.

import Foundation

/// Псевдоним типа
typealias VoidHandler = () -> (Void)
typealias DataHandler = (Result<Data, Error>) -> Void
typealias MovieDataHandler = (MovieData) -> Void
typealias MoviesStateHandler = (ListMoviesState) -> Void
typealias SimilarMoviesHandler = (Result<[SimilarMovie], Error>) -> Void
typealias AlertHandler = (String) -> Void
