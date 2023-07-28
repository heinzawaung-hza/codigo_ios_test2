//
//  NetWorkImageView.swift
//  CodigoCodetest2
//
//  Created by Hein Aung on 26/07/2023.
//

import SwiftUI
import Alamofire


struct ImageView: View {
    var urlString: String
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage(systemName: "photo")!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear {
                imageLoader.loadImage(from: urlString)
            }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        AF.request(url).response { response in
            if let data = response.data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
