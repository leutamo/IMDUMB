//
//  SplashViewController.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import UIKit

class SplashViewController: UIViewController, SplashViewProtocol {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var presenter: SplashPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("🚀 PASO 1: viewDidLoad ejecutado")
        setupDependencies()
        print("🚀 PASO 2: Dependencias listas")
        presenter.fetchConfiguration()
    }
    
    private func setupDependencies() {
        
        let dataStore = FirebaseDataStore()
        let repository = ConfigRepository(remoteDataStore: dataStore)
        
        let useCase = GetConfigUseCase(repository: repository)
        
        self.presenter = SplashPresenter(view: self, getConfigUseCase: useCase)
    }

    // MARK: - SplashViewProtocol
    
    func showLoading() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
    }
    
    func updateStatusMessage(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.statusLabel?.backgroundColor = .yellow
            self.statusLabel?.text = message
        }
    }
    
    func navigateToMain() {
        print("Configuración cargada: \(SessionManager.shared.appConfig?.welcomeMessage ?? "")")
        
        DispatchQueue.main.async {
            
            let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            
            let navController = UINavigationController(rootViewController: homeVC)
            
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = navController
                
                UIView.transition(with: sceneDelegate.window!,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: nil,
                                  completion: nil)
            }
        }
    }
    
    func showSuccessPopup(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Continuar", style: .default) { _ in
            self.navigateToMain()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
        present(alert, animated: true)
    }
}
