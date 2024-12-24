//
//  ViewController.swift
//  tmibragimovPW5
//
//  Created by тимур on 12.12.2024.
//

import UIKit

final class NewsVC: UIViewController {
    // MARK: - Properties
    private let newsView = NewsView()
    private let articleManager = ArticleManager()
    private var articles = [ArticleCellModel]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = newsView
        configureNavbar()
        configureTable()
        fetchNews()
    }
    
    // MARK: - UI Configuration
    private func configureNavbar() {
        navigationItem.title = "Apple Newsroom"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTable() {
        newsView.tableView.dataSource = self
        newsView.tableView.delegate = self
        newsView.tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.reuseId)
    }
    
    // MARK: - Data Fetching
    private func fetchNews() {
        articleManager.fetchNews() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self?.articles.append(contentsOf: articles)
                    self?.newsView.tableView.reloadData()
                case .failure(let error):
                    // Show an alert in case of error
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: - NewsVC Extension
extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // load more articles when bottom reached
        if (indexPath.row == self.articles.count - 1) {
            fetchNews()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseId, for: indexPath)
        guard let articleCell = cell as? ArticleTableViewCell else { return cell }
        articleCell.configure(with: articles[indexPath.row])
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = WebVC(url: articles[indexPath.row].link)
        self.present(webVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let share = UIContextualAction(style: .normal, title: "Share") { _, _, completion in
            let items = [self.articles[indexPath.row].link]
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            self.present(activityVC, animated: true)
            completion(true)
        }
        
        share.image = UIImage(systemName: "square.and.arrow.up.fill")
        share.backgroundColor = .black
        return UISwipeActionsConfiguration(actions: [share])
    }
}
