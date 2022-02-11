//
//  MovieListCollectionViewCell.swift
//  MovieReview
//
//  Created by 김민지 on 2022/02/11.
//  Cell은 MVP를 따르지 않고 여기서 모든 동작을 수행함

import SnapKit
import UIKit
import Kingfisher

final class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCollectionViewCell"

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .secondarySystemBackground

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)

        return label
    }()

    private lazy var userRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .medium)

        return label
    }()

    // Cell UI Update
    func update(_ movie: Movie) {
        setupView()
        setupLayout()

        imageView.kf.setImage(with: movie.imageURL)
        titleLabel.text = movie.title
        userRatingLabel.text = "⭐️ \(movie.userRating)"
    }
}

private extension MovieListCollectionViewCell {
    // Cell Background Configure
    func setupView() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8.0

        backgroundColor = .systemBackground
    }

    // Cell Components Configure
    func setupLayout() {
        [imageView, titleLabel, userRatingLabel].forEach { self.addSubview($0) }

        imageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(16.0)
            $0.height.equalTo(imageView.snp.width)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8.0)
            $0.leading.equalTo(imageView.snp.leading)
            $0.trailing.equalTo(imageView.snp.trailing)
        }

        userRatingLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.leading)
            $0.leading.equalTo(imageView.snp.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.bottom.equalToSuperview().inset(8.0)
        }
    }
}
