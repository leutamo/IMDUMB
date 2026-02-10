//
//  HomeViewController.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "IMDUMB"

        self.view.backgroundColor = .systemBlue
        
        print("HomeViewController cargado correctamente")
            
        setupDependencies()
        //setupUI()
        setupTableView()
        presenter.viewDidLoad()
    }

    private func setupDependencies() {        
        let dataStore = MovieRemoteDataStore()
        let useCase = GetMoviesUseCase(repository: dataStore)
        self.presenter = HomePresenter(view: self, getMoviesUseCase: useCase)
    }
    
    private func setupUI() {
        self.title = "Películas"
        self.view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CategoryCell")
    }
}

extension HomeViewController: HomeViewProtocol {
    func showLoading() {
        // TODO: Mostrar spinner
    }
    
    func hideLoading() {
        // TODO: Ocultar spinner
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfCategories()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        let category = presenter.getCategory(at: indexPath.section)
        
        cell.configure(with: category.movies)
        
        cell.onMovieSelected = { [weak self] movie in
                self?.goToDetail(with: movie)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category = presenter.getCategory(at: section)
        return category.title
    }
    
    private func goToDetail(with movie: Movie) {

        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        let repository = MovieRemoteDataStore()
        let useCase = GetMovieImagesUseCase(repository: repository)
        
        let presenter = DetailPresenter(view: detailVC, movie: movie, getMovieImagesUseCase: useCase)
        detailVC.presenter = presenter
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}



// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
