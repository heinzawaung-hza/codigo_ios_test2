//
//  MovieDetailView.swift
//  CodigoCodetest2
//
//  Created by Hein Aung on 26/07/2023.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var viewModel: MovieDetailViewModel
    
    init(movie: Movie) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movie: movie))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ImageView(urlString: "https://image.tmdb.org/t/p/w154\(viewModel.movie.posterPath)")
                .cornerRadius(8)
                .padding()
            Text(viewModel.movie.title)
                .font(.title)
                .padding()
            Text(viewModel.movie.overview)
                .font(.body)
                .padding()
            Spacer()
        }
        .navigationBarTitle(viewModel.movie.title, displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            viewModel.toggleFavorite()
        }, label: {
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
        }))
    }
}

