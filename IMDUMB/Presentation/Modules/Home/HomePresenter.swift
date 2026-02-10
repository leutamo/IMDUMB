//
//  HomePresenter.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    private let getMoviesUseCase: GetMoviesUseCaseProtocol
    
    private var categories: [MovieCategory] = []
    
    init(view: HomeViewProtocol, getMoviesUseCase: GetMoviesUseCaseProtocol) {
        self.view = view
        self.getMoviesUseCase = getMoviesUseCase
    }
    
    func viewDidLoad() {
        view?.showLoading()
        
        getMoviesUseCase.execute { [weak self] result in
            self?.view?.hideLoading()
            switch result {
            case .success(let homeData):
                self?.categories = [
                    MovieCategory(title: "Tendencias", movies: homeData.trending),
                    MovieCategory(title: "Más Valoradas", movies: homeData.topRated),
                    MovieCategory(title: "Próximamente", movies: homeData.upcoming)
                ]
                
                self?.view?.reloadData()
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func numberOfCategories() -> Int { return categories.count }
    
    func getCategory(at index: Int) -> MovieCategory { return categories[index] }
}
