//
//  ArticleManager.swift
//  tmibragimovPW5
//
//  Created by тимур on 12.12.2024.
//

import Foundation
import UIKit


final class ArticleManager {
    // MARK: - Properties
    private let decoder = JSONDecoder()
    private var currentPage = 0;
    
    // MARK: - Fetch news
    public func fetchNews(completion: @escaping (Result<[ArticleCellModel], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.API.URL)?page=\(currentPage + 1)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                do {
                    var articles = [ArticleCellModel]()
                    let newsArchive = try self.decoder.decode(NewsArchive.self, from: data)
                    for group in newsArchive.articlesByMonth {
                        for article in group.articles {
                            guard let link = URL(string: "https://apple.com\(article.link)") else {
                                return
                            }
                            
                            let imageUrl: URL = URL(string: article.imageSrcs.large!)!
                            
                            articles.append(ArticleCellModel(title: article.title, description: article.description, link: link, imageUrl: imageUrl))
                        }
                    }
                    self.currentPage += 1;
                    completion(.success(articles))
                } catch {
                    completion(.failure(error))
                    print(error)
                    return
                }
            }
        }.resume()
    }
}
// MARK: - Constants
struct Constants {
    struct API {
        static let URL = "https://www.apple.com/newsroom/archive.json"
    }
}
