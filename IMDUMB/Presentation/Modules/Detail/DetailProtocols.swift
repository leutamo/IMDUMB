//
//  DetailProtocols.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

// MARK: - SOLID: Interface Segregation Principle
// Se define protocolos granulares (ViewProtocol, PresenterProtocol) para que
// cada capa solo tenga acceso a los métodos que realmente necesita.
// La View no necesita conocer métodos de red, y el Presenter no necesita
// conocer métodos de ciclo de vida de UI de iOS.
protocol DetailViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func reloadData()
    func showMovieDetails(_ movie: Movie)
}

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    var imagesCount: Int { get }
    func getImageURL(at index: Int) -> URL?
}
