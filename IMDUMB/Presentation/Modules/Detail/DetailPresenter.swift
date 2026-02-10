//
//  DetailPresenter.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

// MARK: - SOLID: Single Responsibility Principle (SRP)
// Este Presenter cumple con SRP ya que su única responsabilidad es gestionar
// la lógica de presentación y la comunicación con el Use Case.
// No conoce detalles de la implementación de la UI (UIKit), delegando
// el renderizado a la View a través de un protocolo.

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    private let movie: Movie
    private let getMovieImagesUseCase: GetMovieImagesUseCaseProtocol
    
    private var images: [MovieImage] = []

    init(view: DetailViewProtocol, movie: Movie, getMovieImagesUseCase: GetMovieImagesUseCaseProtocol) {
        self.view = view
        self.movie = movie
        self.getMovieImagesUseCase = getMovieImagesUseCase
    }

    var imagesCount: Int {
        return images.count
    }

    func getImageURL(at index: Int) -> URL? {
        guard index < images.count else { return nil }
        return images[index].fullURL
    }

    func viewDidLoad() {
        view?.showMovieDetails(movie)
        fetchImages()
    }

    private func fetchImages() {

        view?.showLoading()
        
        getMovieImagesUseCase.execute(movieId: movie.id) { [weak self] (result: Result<[MovieImage], Error>) in
            
            self?.view?.hideLoading()
            
            switch result {
            case .success(let movieImages):
                self?.images = movieImages
                self?.view?.reloadData()
                
            case .failure(let error):                
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
}
