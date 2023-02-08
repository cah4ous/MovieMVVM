// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран детального описания фильма
final class DetailViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let defaultBlack = "defaultBlack"
        static let defaultOrange = "defaultOrange"
        static let watchText = "Смотреть"
        static let shareButtonImageName = "square.and.arrow.up"
        static let clearString = ""
        static let ratingText = "Оценка пользователей - "
        static let firstPathOfUrlString = "https://image.tmdb.org/t/p/w200/"
        static let fatalErrorText = "init(coder:) has not been implemented"
        static let errorText = "Error"
        static let okText = "Ok"
        static let watchButtonCornerRadiusValue = 9.0
        static let watchButtonBorderWidthValue = 1.0
        static let movieRatingLabelFontSizeValue = 25.0
        static let movieRatingTopAnchorValue = 10.0
        static let movieRatingHeightAnchorValue = 50.0
        static let watchButtonLeftAnchorValue = 10.0
        static let watchButtonTopAnchorValue = 20.0
        static let watchButtonWidthAnchorValue = -20.0
        static let watchButtonHeightAnchorValue = 50.0
        static let movieImageViewHeightAnchorValue = 460.0
        static let movieImageViewLeftAnchorValue = 0.0
        static let scrollViewBottomAnchorValue = 100.0
        static let movieDescriptionLabelWidthAnchorValue = -10.0
        static let movieDescriptionLabelLeftAnchorValue = 5.0
        static let movieDescriptionLabelRightAnchorValue = -5.0
        static let movieDescriptionLabelBottomAnchorValue = -100.0
    }

    // MARK: Private Visual Components

    private let movieImageView: UIImageView = {
        let movieImageView = UIImageView()
        movieImageView.contentMode = .scaleToFill
        movieImageView.translatesAutoresizingMaskIntoConstraints = false

        return movieImageView
    }()

    private let movieDescriptionLabel: UILabel = {
        let movieDescriptionLabel = UILabel()
        movieDescriptionLabel.numberOfLines = 0
        movieDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return movieDescriptionLabel
    }()

    private let watchButton: UIButton = {
        let watchButton = UIButton(type: .system)
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        watchButton.setTitle(Constants.watchText, for: .normal)
        watchButton.titleLabel?.adjustsFontSizeToFitWidth = true
        watchButton.backgroundColor = UIColor(named: Constants.defaultOrange)
        watchButton.setTitleColor(UIColor.white, for: .normal)
        watchButton.layer.cornerRadius = Constants.watchButtonCornerRadiusValue
        watchButton.layer.borderColor = UIColor.white.cgColor
        watchButton.layer.borderWidth = Constants.watchButtonBorderWidthValue
        return watchButton
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(named: Constants.defaultBlack)
        return scrollView
    }()

    private let movieRatingLabel: UILabel = {
        let movieRatingLabel = UILabel()
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        movieRatingLabel.font = .boldSystemFont(ofSize: Constants.movieRatingLabelFontSizeValue)
        movieRatingLabel.textColor = UIColor.white
        movieRatingLabel.textAlignment = .center
        return movieRatingLabel
    }()

    // MARK: - Private Properties

    private var movieTitle: String = Constants.clearString

    // MARK: - Public Properties

    var detailMovieViewModel: DetailMovieViewModel

    // MARK: - Initializers

    init(detailViewModel: DetailMovieViewModel) {
        detailMovieViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
        initView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalErrorText)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    // MARK: - Private Methods

    @objc private func shareButtonAction() {}

    private func initView() {
        detailMovieViewModel.mainPosterCompletion = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.movieImageView.image = UIImage(data: data)
            case let .failure(error):
                self.showErrorAlert(
                    alertTitle: Constants.errorText,
                    message: error.localizedDescription,
                    actionTitle: Constants.okText
                )
            }
        }
        detailMovieViewModel.fetchMainPosterData()
        movieTitle = detailMovieViewModel.movie.title
        movieRatingLabel.text = Constants.ratingText + "\(detailMovieViewModel.movie.voteAverage)"
        movieDescriptionLabel.text = detailMovieViewModel.movie.overview
    }

    private func initMethods() {
        setupScrollView()
        setupView()
        setupNavigationBar()
        setConstraints()
    }

    private func setConstraints() {
        createRatingLabelConstraints()
        createWatchButtonConstraints()
        createMovieImageViewConstraints()
        createScrollViewConstraints()
        createRatingLabelConstraints()
        createMovieDescriptionLabelConstraints()
    }

    private func createWatchButtonConstraints() {
        watchButton.leftAnchor
            .constraint(equalTo: scrollView.leftAnchor, constant: Constants.watchButtonLeftAnchorValue).isActive = true
        watchButton.topAnchor.constraint(
            equalTo: movieImageView.bottomAnchor,
            constant: Constants.watchButtonTopAnchorValue
        ).isActive = true
        watchButton.widthAnchor.constraint(
            equalTo: scrollView.widthAnchor,
            constant: Constants.watchButtonWidthAnchorValue
        ).isActive = true
        watchButton.heightAnchor.constraint(equalToConstant: Constants.watchButtonHeightAnchorValue).isActive = true
    }

    private func createMovieImageViewConstraints() {
        movieImageView.leftAnchor.constraint(
            equalTo: scrollView.leftAnchor,
            constant: Constants.movieImageViewLeftAnchorValue
        ).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        movieImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: Constants.movieImageViewHeightAnchorValue)
            .isActive = true
    }

    private func createScrollViewConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.scrollViewBottomAnchorValue)
            .isActive = true
    }

    private func createMovieDescriptionLabelConstraints() {
        movieDescriptionLabel.topAnchor.constraint(equalTo: movieRatingLabel.bottomAnchor, constant: 15).isActive = true
        movieDescriptionLabel.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            constant: Constants.movieDescriptionLabelWidthAnchorValue
        ).isActive = true
        movieDescriptionLabel.leftAnchor.constraint(
            equalTo: scrollView.leftAnchor,
            constant: Constants.movieDescriptionLabelLeftAnchorValue
        ).isActive = true
        movieDescriptionLabel.rightAnchor.constraint(
            equalTo: scrollView.rightAnchor,
            constant: Constants.movieDescriptionLabelRightAnchorValue
        ).isActive = true
        movieDescriptionLabel.bottomAnchor.constraint(
            equalTo: scrollView.bottomAnchor,
            constant: Constants.movieDescriptionLabelBottomAnchorValue
        ).isActive = true
    }

    private func createRatingLabelConstraints() {
        movieRatingLabel.topAnchor.constraint(
            equalTo: watchButton.bottomAnchor,
            constant: Constants.movieRatingTopAnchorValue
        ).isActive = true
        movieRatingLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        movieRatingLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        movieRatingLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        movieRatingLabel.heightAnchor.constraint(equalToConstant: Constants.movieRatingHeightAnchorValue)
            .isActive = true
    }

    private func setupScrollView() {
        scrollView.addSubview(watchButton)
        scrollView.addSubview(movieImageView)
        scrollView.addSubview(movieDescriptionLabel)
        scrollView.addSubview(movieRatingLabel)
    }

    private func setupView() {
        view.addSubview(scrollView)
        view.backgroundColor = UIColor(named: Constants.defaultBlack)
    }

    private func setupNavigationBar() {
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(systemName: Constants.shareButtonImageName), for: .normal)
        shareButton.tintColor = UIColor(named: Constants.defaultOrange)
        shareButton.addTarget(self, action: #selector(shareButtonAction), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        navigationItem.title = movieTitle
    }
}
