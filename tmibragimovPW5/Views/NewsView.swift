//
//  NewsView.swift
//  tmibragimovPW5
//
//  Created by тимур on 12.12.2024.
//

import UIKit

class NewsView: UIView {
    // MARK: - Properties
    public let tableView: UITableView = UITableView()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        backgroundColor = Constants.Colors.backgroundColor
        configureTable()
    }
    
    private func configureTable() {
        addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.pinTop(to: topAnchor)
        tableView.pinBottom(to: bottomAnchor)
        tableView.pinLeft(to: leadingAnchor, Constants.Table.offsetX)
        tableView.pinRight(to: trailingAnchor, Constants.Table.offsetX)
    }
    
    // MARK: - Constants
    struct Constants {
        struct Colors {
            static let backgroundColor: UIColor = .black
        }
        
        struct Table {
            static let offsetX: CGFloat = 5
        }
    }
}
