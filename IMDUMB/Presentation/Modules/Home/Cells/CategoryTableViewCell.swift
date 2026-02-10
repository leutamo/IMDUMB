//
//  CategoryTableViewCell.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
        private var movies: [Movie] = []
        var onMovieSelected: ((Movie) -> Void)?

        override func awakeFromNib() {
            super.awakeFromNib()
            setupCollectionView()
        }

        private func setupCollectionView() {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "MovieCell")
        }

        func configure(with movies: [Movie]) {
            self.movies = movies
            self.collectionView.reloadData()
        }
    }

    // MARK: - CollectionView DataSource
    extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return movies.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let movie = movies[indexPath.item]
            cell.configure(with: movie)
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 120, height: 180)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedMovie = movies[indexPath.item]
            onMovieSelected?(selectedMovie)
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
