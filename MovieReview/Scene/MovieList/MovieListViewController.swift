//
//  ViewController.swift
//  MovieReview
//
//  Created by 김민지 on 2022/01/29.
//

import SnapKit
import UIKit

final class MovieListViewController: UIViewController {
    private lazy var presenter = MovieListPresenter(viewController: self)

    private let searchController = UISearchController()

    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = presenter
        collectionView.delegate = presenter

        collectionView.register(
            MovieListCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier
        )

        return collectionView
    }()

    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
}

extension MovieListViewController: MovieListProtocol {
    // NavigationBar Configure
    func setupNavigationBar() {
        navigationItem.title = "영화 평점"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    // SearchBar Configure
    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = presenter
    }

    // CollectionView, TableView Configure
    func setupViews() {
        [collectionView, searchResultTableView].forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        searchResultTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        searchResultTableView.isHidden = true
    }

    // TableView Hidden
    func updateSearchTableView(isHidden: Bool) {
        searchResultTableView.isHidden = isHidden
        searchResultTableView.reloadData()
    }
}
