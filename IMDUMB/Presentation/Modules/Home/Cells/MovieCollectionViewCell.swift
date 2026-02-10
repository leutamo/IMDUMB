//
//  MovieCollectionViewCell.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w780"

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {

        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = .clear
                
        posterImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = nil
    }
    
    func configure(with movie: Movie) {
        guard let posterPath = movie.posterPath else {
            posterImageView.backgroundColor = .systemGray3
            return
        }
        
        let fullStringUrl = imageBaseUrl + posterPath
        
        guard let url = URL(string: fullStringUrl) else { return }
        
        posterImageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
        )
    }
}
