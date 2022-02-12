//
//  UserDefaultsManager.swift
//  MovieReview
//
//  Created by 김민지 on 2022/02/12.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getMovies() -> [Movie]
    func addMovie(_ newValue: Movie)
    func removeMovie(_ value: Movie)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case movie
    }

    // UserDefaults get Movies
    func getMovies() -> [Movie] {
        guard let data = UserDefaults.standard.data(forKey: Key.movie.rawValue) else { return [] }

        return (try? PropertyListDecoder().decode([Movie].self, from: data)) ?? []
    }

    // UserDefaults add Movies
    func addMovie(_ newValue: Movie) {
        var currentMovie: [Movie] = getMovies()
        currentMovie.insert(newValue, at: 0)

        saveMovie(currentMovie)
    }

    // UserDefaults remove Movie
    func removeMovie(_ value: Movie) {
        let currentMovie: [Movie] = getMovies()
        let newValue = currentMovie.filter { $0.title != value.title }

        saveMovie(newValue)
    }

    // new save
    private func saveMovie(_ newValue: [Movie]) {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(newValue),
            forKey: Key.movie.rawValue
        )
    }
}
