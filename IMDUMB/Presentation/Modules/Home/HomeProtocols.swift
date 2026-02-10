//
//  HomeProtocols.swift
//  IMDUMB
//
//  Created by GiAn on 9/02/26.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func reloadData()
    func showError(_ message: String)
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfCategories() -> Int
    func getCategory(at index: Int) -> MovieCategory
}
