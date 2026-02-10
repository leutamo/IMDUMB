//
//  RecommendViewController.swift
//  IMDUMB
//
//  Created by GiAn on 10/02/26.
//

import UIKit

class RecommendViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    

    var movieDescription: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDescriptionLabel.text = movieDescription
        
        commentTextView.delegate = self
        commentTextView.returnKeyType = .done
        
        setupUI()
    }

    private func setupUI() {
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.cornerRadius = 8
    }

    @IBAction func confirmTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "¡Éxito!",
                                      message: "Tu recomendación ha sido enviada.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Genial", style: .default, handler: { _ in
            self.dismiss(animated: true) // Cerramos el modal
        }))
        
        self.present(alert, animated: true)
    }

}

// MARK: - UITextViewDelegate
extension RecommendViewController {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
