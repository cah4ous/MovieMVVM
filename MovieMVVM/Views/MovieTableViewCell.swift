// MovieTableViewCell.swift
// Copyright © Alexandr T. All rights reserved.

import UIKit

/// Ячейка фильма
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let defaultOrange = "defaultOrange"
        static let error = "init(coder:) has not been implemented"
        static let firstPathOfUrlString = "https://image.tmdb.org/t/p/w200/"
        static let placeHolderImageName = "xmark.app"
        static let movieNameLabelFontSizeValue = 19.0
        static let movieNameLabelNumberOfLinesValue = 2
        static let movieDescriptionLabelNumberOfLinesValue = 0
        static let movieDescriptionLabelFontSizeValue = 16.0
        static let movieImageViewLeftAnchorValue = 0.0
        static let movieImageViewWidthAnchorValue = 150.0
        static let movieImageViewTopAnchorValue = -10.0
        static let movieImageViewBottomAnchorValue = 0.0
        static let movieImageViewHeightAnchorValue = 250.0
        static let contentViewCornerRadiusValue = 15.0
        static let contentViewCornerWidth = 1.0
        static let movieViewLeftAnchorValue = 0.0
        static let movieViewRightAnchorValue = 0.0
        static let movieViewTopAnchorValue = -10.0
        static let movieViewBottomAnchorValue = 0.0
        static let movieNameLabelLeftAnchorValue = 10.0
        static let movieNameLabelRightAnchorValue = -10.0
        static let movieNameLabelTopAnchorValue = 20.0
        static let movieNameLabelHeightAnchorValue = 40.0
        static let movieDescriptionLabelLeftAnchorValue = 10.0
        static let movieDescriptionLabelRightAnchorValue = -10.0
        static let movieDescriptionLabelTopAnchorValue = 10.0
        static let movieDescriptionLabelBottomAnchorValue = -10.0
        static let movieRatingLabelLeftAnchorValue = 10.0
        static let movieRatingLabelBottomAnchorValue = -10.0
        static let movieRatingLabelHeightAnchorValue = 30.0
        static let movieRatingLabelWidthAnchorValue = 30.0
        static let contentViewTopFrameValue = 20.0
        static let contentViewLeftFrameValue = 0.0
        static let contentViewBottomFrameValue = 20.0
        static let contentViewRightFrameValue = 0.0
        static let movieRatingLabelFontSizeValue = 15.0
        static let movieRatingLabelBorderWidthValue = 3.0
    }

    // MARK: - Private Visual Components

    private let movieImageView: UIImageView = {
        let movieImageView = UIImageView()

        movieImageView.backgroundColor = .black
        movieImageView.contentMode = .scaleToFill

        return movieImageView
    }()

    private let movieNameLabel: UILabel = {
        let movieNameLabel = UILabel()

        movieNameLabel.textAlignment = .center
        movieNameLabel.font = UIFont.boldSystemFont(ofSize: Constants.movieNameLabelFontSizeValue)
        movieNameLabel.textColor = .black
        movieNameLabel.numberOfLines = Constants.movieNameLabelNumberOfLinesValue
        movieNameLabel.adjustsFontSizeToFitWidth = true

        return movieNameLabel
    }()

    private let movieDescriptionLabel: UILabel = {
        let movieDescriptionLabel = UILabel()
        movieDescriptionLabel.numberOfLines = Constants.movieDescriptionLabelNumberOfLinesValue
        movieDescriptionLabel.textAlignment = .center
        movieDescriptionLabel.font = UIFont.systemFont(ofSize: Constants.movieDescriptionLabelFontSizeValue)
        return movieDescriptionLabel
    }()

    private let movieRatingLabel: UILabel = {
        let movieRatingLabel = UILabel()

        movieRatingLabel.layer.masksToBounds = true
        movieRatingLabel.font = UIFont.boldSystemFont(ofSize: Constants.movieRatingLabelFontSizeValue)
        movieRatingLabel.backgroundColor = .white
        movieRatingLabel.layer.borderWidth = Constants.movieRatingLabelBorderWidthValue
        movieRatingLabel.layer.borderColor = UIColor(named: Constants.defaultOrange)?.cgColor
        movieRatingLabel.layer.cornerRadius = Constants.movieRatingLabelFontSizeValue
        movieRatingLabel.textColor = .black
        movieRatingLabel.textAlignment = .center

        return movieRatingLabel
    }()

    // MARK: Private Visual Components

    private let movieView = UIView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.error)
    }

    // MARK: - Public Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: Constants.contentViewTopFrameValue,
            left: Constants.contentViewLeftFrameValue,
            bottom: Constants.contentViewBottomFrameValue,
            right: Constants.contentViewRightFrameValue
        ))
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieView.backgroundColor = UIColor(named: Constants.defaultOrange)
    }

    func configure(movie: MovieData, moviesViewModel: MoviesViewModelProtocol) {
        movieDescriptionLabel.text = movie.overview
        movieRatingLabel.text = "\(movie.voteAverage)"
        movieNameLabel.text = movie.title
        moviesViewModel.fetchData(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.movieImageView.image = UIImage(data: data)
            case let .failure(error):
                self.movieImageView.image = UIImage(systemName: Constants.placeHolderImageName)
            }
        })
    }

    // MARK: - Private Methods

    private func configureCell() {
        setupContentView()
        createMovieView()
        addConstraints()
    }

    private func addConstraints() {
        createMovieRatingLabelConstraints()
        createMovieNameLabelConstraints()
        createMovieDescriptionLabelConstraints()
        createMovieViewConstraints()
        createMovieImageViewConstraints()
    }

    private func createMovieRatingLabelConstraints() {
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        movieRatingLabel.leftAnchor.constraint(
            equalTo: movieImageView.leftAnchor,
            constant: Constants.movieRatingLabelLeftAnchorValue
        ).isActive = true
        movieRatingLabel.bottomAnchor.constraint(
            equalTo: movieImageView.bottomAnchor,
            constant: Constants.movieRatingLabelBottomAnchorValue
        ).isActive = true
        movieRatingLabel.heightAnchor.constraint(equalToConstant: Constants.movieRatingLabelHeightAnchorValue)
            .isActive = true
        movieRatingLabel.widthAnchor.constraint(equalToConstant: Constants.movieRatingLabelWidthAnchorValue)
            .isActive = true
    }

    private func createMovieDescriptionLabelConstraints() {
        movieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        movieDescriptionLabel.leftAnchor.constraint(
            equalTo: movieView.leftAnchor,
            constant: Constants.movieDescriptionLabelLeftAnchorValue
        ).isActive = true
        movieDescriptionLabel.rightAnchor.constraint(
            equalTo: movieView.rightAnchor,
            constant: Constants.movieDescriptionLabelRightAnchorValue
        ).isActive = true
        movieDescriptionLabel.topAnchor.constraint(
            equalTo: movieNameLabel.bottomAnchor,
            constant: Constants.movieDescriptionLabelTopAnchorValue
        ).isActive = true
        movieDescriptionLabel.bottomAnchor.constraint(
            equalTo: movieView.bottomAnchor,
            constant: Constants.movieDescriptionLabelBottomAnchorValue
        ).isActive = true
    }

    private func createMovieNameLabelConstraints() {
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.leftAnchor.constraint(
            equalTo: movieView.leftAnchor,
            constant: Constants.movieNameLabelLeftAnchorValue
        ).isActive = true
        movieNameLabel.rightAnchor.constraint(
            equalTo: movieView.rightAnchor,
            constant: Constants.movieNameLabelRightAnchorValue
        ).isActive = true
        movieNameLabel.topAnchor.constraint(
            equalTo: movieView.topAnchor,
            constant: Constants.movieNameLabelTopAnchorValue
        ).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: Constants.movieNameLabelHeightAnchorValue)
            .isActive = true
    }

    private func createMovieView() {
        movieView.backgroundColor = UIColor(named: Constants.defaultOrange)
        movieView.addSubview(movieNameLabel)
        movieView.addSubview(movieDescriptionLabel)
    }

    private func createMovieViewConstraints() {
        movieView.translatesAutoresizingMaskIntoConstraints = false
        movieView.leftAnchor.constraint(
            equalTo: movieImageView.rightAnchor,
            constant: Constants.movieViewLeftAnchorValue
        ).isActive = true
        movieView.rightAnchor
            .constraint(equalTo: contentView.rightAnchor, constant: Constants.movieViewRightAnchorValue).isActive = true
        movieView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.movieViewTopAnchorValue)
            .isActive = true
        movieView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: Constants.movieViewBottomAnchorValue
        ).isActive = true
    }

    private func setupContentView() {
        movieImageView.addSubview(movieRatingLabel)
        contentView.layer.cornerRadius = Constants.contentViewCornerRadiusValue
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = Constants.contentViewCornerWidth
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieView)
    }

    private func createMovieImageViewConstraints() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.leftAnchor.constraint(
            equalTo: contentView.leftAnchor,
            constant: Constants.movieImageViewLeftAnchorValue
        ).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: Constants.movieImageViewWidthAnchorValue).isActive = true
        movieImageView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.movieImageViewTopAnchorValue
        ).isActive = true
        movieImageView.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: Constants.movieImageViewBottomAnchorValue
        ).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: Constants.movieImageViewHeightAnchorValue)
            .isActive = true
    }
}
