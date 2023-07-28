//
//  Movie.swift
//  CodigoCodetest2
//
//  Created by Hein Aung on 26/07/2023.
//

import Foundation
import RealmSwift

// MARK: - MovieResponse
struct MovieResponse: Codable {
   
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
class Movie: Object, Codable, Identifiable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var posterPath: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var video: Bool = false
    @objc dynamic var isPopular: Bool = false
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}

