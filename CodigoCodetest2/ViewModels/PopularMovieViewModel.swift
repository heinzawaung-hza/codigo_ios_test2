//
//  PopularMovieViewModel.swift
//  CodigoCodetest2
//
//  Created by Hein Aung on 26/07/2023.
//


import SwiftUI
import RealmSwift
import Alamofire
import Combine

class PopularMovieViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private var realm: Realm
    
    @Published var popularMovies: Results<Movie>
    @Published var errorMessage: String?
    @Published var isLoading = false
    private var notificationToken: NotificationToken?
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYjIzOGMwN2Y0M2Q2ZWNiNmNkMjMyZjA4YmE3NTU4ZSIsInN1YiI6IjY0YmQwNDg1YWM2Yzc5MDhkZTVmN2E2NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hE3BXEIvP22vjEd6Frv5BGTsoOLCLsXQ8M6zS9siaic"
    ]
    
    init() {
        do {
            realm = try Realm()
            popularMovies = realm.objects(Movie.self).filter("isPopular == true")
            observeDatabaseChanges()
        } catch {
            fatalError("Error initializing Realm: \(error)")
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func fetchPopularMovies() {
        isLoading = true
        AF.request("https://api.themoviedb.org/3/movie/popular", headers: headers)
                .validate()
                .responseDecodable(of: MovieResponse.self) { [weak self] response in
                    defer { self?.isLoading = false }
                    switch response.result {
                    case .success(let movieResponse):
                        print(movieResponse)
                        for index in movieResponse.results.indices {
                            movieResponse.results[index].id = movieResponse.results[index].id * 1000
                            movieResponse.results[index].isPopular = true
                        }
                        self?.updateDatabase(with: movieResponse.results)
                    case .failure(let error):
                        print(error)
                        self?.errorMessage = error.localizedDescription
                    }
                }
    }
    
    private func observeDatabaseChanges() {
        notificationToken = popularMovies.observe { [weak self] changes in
            switch changes {
            case .initial, .update:
                self?.objectWillChange.send()
            case .error(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func updateDatabase(with movies: [Movie]) {
        do {
            for movie in movies {
                if checkMovieByID(id: movie.id) == nil {
                    try realm.write {
                        realm.add(movie, update: .error)
                    }
                }
            }
        } catch {
            errorMessage = "Failed to update database"
        }
    }
    
    func checkMovieByID(id: Int) -> Movie? {
        do {
            let realm = try Realm()
            return realm.object(ofType: Movie.self, forPrimaryKey: id)
        } catch {
            print("Error accessing Realm database: \(error)")
            return nil
        }
    }
}

