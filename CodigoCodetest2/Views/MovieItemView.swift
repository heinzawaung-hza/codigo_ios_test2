//
//  MovieItemView.swift
//  CodigoCodetest2
//
//  Created by Hein Aung on 26/07/2023.
//
import SwiftUI
import Alamofire

struct MovieItemView: View {
    var movie: Movie

    var body: some View {
        HStack {
            ImageView(urlString: "https://image.tmdb.org/t/p/w154\(movie.posterPath)")
                            .frame(width: 100, height: 150)
                            .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseDate)
                    .font(.subheadline)
                Text(movie.overview)
                    .font(.caption)
            }
        }
        .padding(.vertical, 8)
    }
}


