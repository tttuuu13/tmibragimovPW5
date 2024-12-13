//
//  ArticleManager.swift
//  tmibragimovPW5
//
//  Created by тимур on 12.12.2024.
//

import Foundation
import UIKit


final class ArticleManager {
    private let decoder = JSONDecoder()
    // MARK: - Fetch news
    public func fetchNews(page: Int, completion: @escaping (Result<[ArticleCellModel], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.API.URL)?page=\(page)") else { return }
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
                            
                            let imageUrl: URL? = (article.imageSrcs.large2x ?? article.imageSrcs.large).flatMap { URL(string: $0) }
                            
                            articles.append(ArticleCellModel(title: article.title, description: article.description, link: link, imageLink: imageUrl))
                        }
                    }
                    
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
