//
//  MovieData+CoreDataProperties.swift
//
//
//  Created by Александр Троицкий on 09.02.2023.
//
//

import CoreData
import Foundation

/// Информация о фильме
public extension MovieData: Identifiable {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieData> {
        return NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    /// Уникальный идентификатор
    @NSManaged var id: UUID?
    /// Идентификатор фильма
    @NSManaged var movieId: Int64
    /// Краткое описание фильма
    @NSManaged var overview: String?
    /// Ссылка на постер фильма
    @NSManaged var posterPath: String?
    /// Дата релиза фильма
    @NSManaged var releaseData: String?
    /// Наименование фильма
    @NSManaged var title: String?
    /// Оценка фильма
    @NSManaged var voteAverage: Double
    /// Количество голосов
    @NSManaged var voteCount: Double
    /// Категория фильма
    @NSManaged var category: String?
}
