//
//  MovieListPresenter.swift
//  MovieReview
//
//  Created by 김민지 on 2022/02/06.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func updateSearchTableView(isHidden: Bool)
}

final class MovieListPresenter: NSObject {
    private weak var viewController: MovieListProtocol? // weak var와 unowned let을 사용했을 때 memory leak에 대한 것!

    private let movieSearchManager: MovieSearchManagerProtocol

    private var likedMovie: [Movie] = [
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2022"),
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2022"),
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2022")
    ]
    
    private var currentMovieSearchResult: [Movie] = []

    init(
        viewController: MovieListProtocol,
        movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager()
    ) {
        self.viewController = viewController
        self.movieSearchManager = movieSearchManager
    }

    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
}

// MARK: UISearchBarDelegate
extension MovieListPresenter: UISearchBarDelegate {
    // SearchBar Use
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }

    // SearchBar UnUse
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMovieSearchResult = []
        viewController?.updateSearchTableView(isHidden: true)
    }

    // Auto Complete Search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.request(from: searchText) { [weak self] movies in
            self?.currentMovieSearchResult = movies
            self?.viewController?.updateSearchTableView(isHidden: false)
        }
    }
}

// MARK: UICollectionViewDelegate
extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    // Cell Size
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 210.0)
    }

    // Leading, Trailing Inset
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovie.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieListCollectionViewCell

        let movie = likedMovie[indexPath.item]
        cell?.update(movie)

        return cell ?? UICollectionViewCell()
    }
}

// MARK: UITableViewDelegate
extension MovieListPresenter: UITableViewDelegate {
    //
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovieSearchResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = currentMovieSearchResult[indexPath.row].title

        return cell
    }
}
