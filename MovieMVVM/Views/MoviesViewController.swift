// MoviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран фильмов
final class MoviesViewController: UIViewController {
    // MARK: Constants

    private enum Constants {
        static let backBarButtonTitleText = "Movies"
        static let soonButtonText = "Скоро"
        static let popularButtonText = "Популярное"
        static let bestButtonText = "Лучшее"
        static let fatallErrorText = "init(coder:) has not been implemented"
        static let movieCellIdentifier = "MovieTableViewCell"
        static let defaultOrange = "defaultOrange"
        static let defaultBlack = "defaultBlack"
        static let popularButtonLeftAnchorValue = 15.0
        static let popularButtonWidthAnchorValue = 100.0
        static let popularButtonHeightAnchorValue = 50.0
        static let popularButtonTopAnchorValue = 10.0
        static let topRatedButtonRightAnchorValue = -15.0
        static let topRatedButtonWidthAnchorValue = 100.0
        static let topRatedButtonHeightAnchorValue = 50.0
        static let topRatedButtonTopAnchorValue = 10.0
        static let comingSoonButtonCornerRadiusValue = 9.0
        static let comingSoonButtonBorderWidth = 1.0
        static let comingSoonButtonWidthAnchorValue = 100.0
        static let comingSoonButtonHeightAnchorValue = 50.0
        static let comingSoonButtonTopAnchorValue = 10.0
        static let comingSoonButtonLeftAnchorValue = 30.0
        static let tableViewLeftAnchorValue = 0.0
        static let tableViewRightAnchorValue = 0.0
        static let tableViewTopAnchorValue = 75.0
        static let tableViewBottomAnchorValue = 0.0
        static let topRatedButtonText = "Топ"
        static let comingSoonButtonText = "Cкоро"
        static let movieTableViewIdentifier = "moviesTableViewIdentifier"
    }

    // MARK: Private Visual Components

    private let refresherControl = UIRefreshControl()
    private let tableView = UITableView()
    private let popularButton = UIButton()
    private let topRatedButton = UIButton()
    private let comingSoonButton = UIButton()
    private let mainActivityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = UIColor.systemPink
        activity.startAnimating()
        return activity
    }()

    // MARK: - Public Properties

    var toDetailMovie: ((Movie) -> ())?
    var movieViewModel: MoviesViewModelProtocol
    var onFinishFlow: (() -> ())?
    var listMoviesState: ListMoviesState = .initial {
        didSet {
            view.setNeedsLayout()
        }
    }

    // MARK: - Private Properties

    private var movies: [Movie] = []

    // MARK: - Initializers

    init(movieViewModel: MoviesViewModel) {
        self.movieViewModel = movieViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatallErrorText)
    }

    // MARK: - Public Methods

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        switch listMoviesState {
        case .initial:
            initMethods()
            movieViewModel.fetchMovies()
        case .loading:
            movieViewModel.fetchMovies()
            mainActivityIndicatorView.startAnimating()
            mainActivityIndicatorView.isHidden = false
        case .success:
            mainActivityIndicatorView.stopAnimating()
            mainActivityIndicatorView.isHidden = true
            tableView.reloadData()
        case .failure:
            mainActivityIndicatorView.stopAnimating()
            mainActivityIndicatorView.isHidden = true
        }
    }

    // MARK: - Private Methods

    @objc private func handleRefreshAction() {
        refresherControl.endRefreshing()
    }

    private func initMethods() {
        setupListMoviesState()
        tableViewSettings()
        configureView()
        addTargets()
        setupNavigationBar()
        setupButtons()
        createConstraints()
    }

    private func setupListMoviesState() {
        movieViewModel.listMoviesState = { [weak self] states in
            self?.listMoviesState = states
        }
    }

    private func setupButtons() {
        setButtonSettings(button: popularButton, title: Constants.popularButtonText)
        setButtonSettings(button: topRatedButton, title: Constants.topRatedButtonText)
        setButtonSettings(button: comingSoonButton, title: Constants.soonButtonText)
    }

    private func setButtonSettings(button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = UIColor(named: Constants.defaultOrange)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = Constants.comingSoonButtonCornerRadiusValue
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = Constants.comingSoonButtonBorderWidth
    }

    private func addTargets() {
        refresherControl.addTarget(self, action: #selector(handleRefreshAction), for: .valueChanged)
    }

    private func createConstraints() {
        createTableViewConstraints()
        createPopularButtonConstraints()
        createTopRatedButtonConstraints()
        createCommingSoonButtonConstraints()
    }

    private func createPopularButtonConstraints() {
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        popularButton.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: Constants.popularButtonLeftAnchorValue
        ).isActive = true
        popularButton.widthAnchor.constraint(equalToConstant: Constants.popularButtonWidthAnchorValue).isActive = true
        popularButton.heightAnchor.constraint(equalToConstant: Constants.popularButtonHeightAnchorValue).isActive = true
        popularButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: Constants.popularButtonTopAnchorValue
        ).isActive = true
    }

    private func createTopRatedButtonConstraints() {
        topRatedButton.translatesAutoresizingMaskIntoConstraints = false
        topRatedButton.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: Constants.topRatedButtonRightAnchorValue
        )
        .isActive = true
        topRatedButton.widthAnchor.constraint(equalToConstant: Constants.topRatedButtonWidthAnchorValue).isActive = true
        topRatedButton.heightAnchor.constraint(equalToConstant: Constants.topRatedButtonHeightAnchorValue)
            .isActive = true
        topRatedButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: Constants.topRatedButtonTopAnchorValue
        ).isActive = true
    }

    private func createCommingSoonButtonConstraints() {
        comingSoonButton.translatesAutoresizingMaskIntoConstraints = false
        comingSoonButton.leftAnchor.constraint(
            equalTo: popularButton.rightAnchor,
            constant: Constants.comingSoonButtonLeftAnchorValue
        ).isActive = true
        comingSoonButton.widthAnchor.constraint(equalToConstant: Constants.comingSoonButtonWidthAnchorValue)
            .isActive = true
        comingSoonButton.heightAnchor.constraint(equalToConstant: Constants.comingSoonButtonHeightAnchorValue)
            .isActive = true
        comingSoonButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: Constants.comingSoonButtonTopAnchorValue
        ).isActive = true
    }

    private func createTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.leftAnchor,
            constant: Constants.tableViewLeftAnchorValue
        ).isActive = true
        tableView.rightAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.rightAnchor,
            constant: Constants.tableViewRightAnchorValue
        ).isActive = true
        tableView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: Constants.tableViewTopAnchorValue
        ).isActive = true
        tableView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: Constants.tableViewBottomAnchorValue
        ).isActive = true
    }

    private func configureView() {
        view.addSubview(popularButton)
        view.addSubview(topRatedButton)
        view.addSubview(comingSoonButton)
        view.addSubview(tableView)
        view.backgroundColor = UIColor(named: Constants.defaultBlack)
    }

    private func tableViewSettings() {
        tableView.accessibilityIdentifier = Constants.movieTableViewIdentifier
        tableView.addSubview(refresherControl)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.frame
        tableView.register(
            MovieTableViewCell.self,
            forCellReuseIdentifier: Constants.movieCellIdentifier
        )
        tableView.separatorStyle = .none
    }

    private func setupNavigationBar() {
        let backButtonItem = UIBarButtonItem()
        backButtonItem.tintColor = .orange
        backButtonItem.title = Constants.backBarButtonTitleText

        navigationItem.backBarButtonItem = backButtonItem
    }
}

/// UITableViewDelegate, UITableViewDataSource
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Public Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        movieViewModel.movies.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section < movieViewModel.movies.count, let toDetailMovie = toDetailMovie else { return }
        toDetailMovie(movieViewModel.movies[indexPath.section])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieCell = tableView
            .dequeueReusableCell(withIdentifier: Constants.movieCellIdentifier)
            as? MovieTableViewCell else { return UITableViewCell() }
        movieCell.accessibilityIdentifier = "\(indexPath.section)"
        movieViewModel.setupMovie(index: indexPath.section)
        movieCell.configure(moviesViewModel: movieViewModel)

        return movieCell
    }
}
