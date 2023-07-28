//
//  ContentView.swift
//  CodigoCodetest2
//
//  Created by Hein Aung on 26/07/2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    init() {
        configureRealm()
    }
    
    var body: some View {
        
        TabView {
            UpcomingMovieView()
                .tabItem {
                    Image(systemName: "film")
                    Text("Upcoming")
                }

            PopularMovieView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Popular")
                }
        }
    }
}


func configureRealm() {
    let config = Realm.Configuration(
        schemaVersion: 2,
        migrationBlock: { migration, oldSchemaVersion in
            
        })
    
    Realm.Configuration.defaultConfiguration = config
}






