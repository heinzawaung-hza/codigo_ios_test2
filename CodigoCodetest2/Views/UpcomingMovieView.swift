//
//  UpcomingMovieView.swift
//  CodigoCodetest2
//
//  Created by Hein Aung on 26/07/2023.
//

import SwiftUI

struct UpcomingMovieView: View {
    @ObservedObject var viewModel = UpcomingMovieViewModel()
    
    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            if viewModel.isLoading {
                ProgressView("Loading...")
            }
            NavigationView {
                List(viewModel.upcomingMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieItemView(movie: movie)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchUpcomingMovies()
        }
    }
}
