//
//  MovieDetailViewModel.swift
//  CodigoCodetest2
//
//  Created by Hein Aung on 26/07/2023.
//
import Combine
import RealmSwift

class MovieDetailViewModel: ObservableObject {
    var movie: Movie

    @Published var isFavorite: Bool

    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
    }

    init(movie: Movie) {
        self.movie = movie
        self.isFavorite = movie.isFavorite
    }

    func toggleFavorite() {
        do {
            try realm.write {
                movie.isFavorite = !movie.isFavorite
                realm.add(movie, update: .modified)
            }
            isFavorite = movie.isFavorite
        } catch {
            print("Error saving favorite state: \(error)")
        }
    }
}

