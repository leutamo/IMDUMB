//
//  DetailViewController.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var recommendButton: UIButton!
    
    // MARK: - SOLID: Dependency Inversion Principle
    // La Vista depende de la abstracción DetailPresenterProtocol en lugar de
    // una clase concreta. Esto me permite desacoplar los módulos y facilita
    // la inyección de dependencias o MockPresenters para pruebas unitarias.
    
    var presenter: DetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        presenter.viewDidLoad()
    }
}

extension DetailViewController: DetailViewProtocol {
    
    func showLoading() {
        DispatchQueue.main.async {
            print("Cargando detalles e imágenes...")
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            print("Carga finalizada")
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showMovieDetails(_ movie: Movie) {
        
        titleLabel.text = movie.title
        
        if let rating = movie.voteAverage {
            ratingLabel.text = String(format: "⭐ %.1f / 10", rating)
        } else {
            ratingLabel.text = "⭐ N/A"
        }
        overviewLabel.text = movie.overview
        
        if let htmlData = movie.overview.data(using: .utf8) {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            let attributedString = try? NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
            self.overviewLabel.attributedText = attributedString
        }
        
        if let path = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            posterImageView.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }
    }
    
    @IBAction func recommendTapped(_ sender: UIButton) {
        let recommendVC = RecommendViewController(nibName: "RecommendViewController", bundle: nil)
        
        recommendVC.movieDescription = overviewLabel.text
        
        if #available(iOS 15.0, *) {
            if let sheet = recommendVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()] // Permite que crezca
                sheet.prefersGrabberVisible = true
            }
        }
        
        self.present(recommendVC, animated: true)
    }
}



extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.imagesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.backgroundView = nil // Asegúrate de limpiar el backgroundView anterior
        
        let imageView = UIImageView(frame: cell.contentView.bounds)
        
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        if let url = presenter.getImageURL(at: indexPath.item) {
            imageView.kf.setImage(with: url, options: [.transition(.fade(0.3))])
        }
        
        cell.contentView.addSubview(imageView)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
