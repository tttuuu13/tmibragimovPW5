//
//  ViewController.swift
//  tmibragimovPW5
//
//  Created by тимур on 12.12.2024.
//

import UIKit

final class NewsVC: UIViewController {
    private let newsView = NewsView()
    private let articleManager = ArticleManager()
    private var articles = [ArticleCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = newsView
        newsView.tableView.dataSource = self
        newsView.tableView.delegate = self
        articleManager.fetchNews(page: 1) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.newsView.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
