//
//  SplashPresenter.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

protocol SplashViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func updateStatusMessage(_ message: String)
    func showSuccessPopup(title: String, message: String)
    func navigateToMain()
    func showError(message: String)
}

class SplashPresenter {
    
    weak var view: SplashViewProtocol?
    
    private let getConfigUseCase: GetConfigUseCaseProtocol
    
    // Inyección de dependencias (Principio SOLID: D)
    init(view: SplashViewProtocol, getConfigUseCase: GetConfigUseCaseProtocol) {
        self.view = view
        self.getConfigUseCase = getConfigUseCase
    }
    
    func fetchConfiguration() {

        view?.updateStatusMessage("Conectando con la compañía...")
        view?.showLoading()
        
        getConfigUseCase.execute { [weak self] result in
            self?.view?.hideLoading()
            
            switch result {
            case .success(let config):
                SessionManager.shared.appConfig = config
                
                self?.view?.updateStatusMessage("¡Configuración cargada!")
                
                self?.view?.showSuccessPopup(
                    title: "Ajustes Listos",
                    message: config.welcomeMessage
                )
                
            case .failure(let error):
                self?.view?.updateStatusMessage("Error al sincronizar")
                self?.view?.showError(message: error.localizedDescription)
            }
        }
    }
}
