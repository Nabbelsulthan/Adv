//
//  ViewModel.swift
//  Task-vajro
//
//  Created by Nabbel on 08/11/24.
//

import UIKit

class ViewModel {

    var articles: [Article] = []
    
    var reloadTableView: (() -> Void)?
    
    
    func numberOfRows() -> Int {
        return articles.count
    }
    
    func article(at indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
    
    func fetchArticles() {
        guard let url = URL(string: "https://run.mocky.io/v3/e45b34c9-195d-4a6e-922e-130335e8a657") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ArticleResponse.self, from: data)
                    self?.articles = response.articles
                    print("Response Data \(response)")
                    DispatchQueue.main.async {
                        self?.reloadTableView?()
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
        task.resume()
    }

}
