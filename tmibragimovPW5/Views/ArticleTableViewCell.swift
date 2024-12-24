//
//  ArticleTableViewCell.swift
//  tmibragimovPW5
//
//  Created by тимур on 13.12.2024.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let wrapView: UIView = UIView()
    private let articleImageView: UIImageView = UIImageView()
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    private var imageFetchingTask: URLSessionDataTask?
    static let reuseId = "ArticleTableViewCell"

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    public func configure(with article: ArticleCellModel) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        
        articleImageView.image = nil
        imageFetchingTask?.cancel()
        imageFetchingTask = URLSession.shared.dataTask(with: article.imageUrl) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.articleImageView.image = image
                self.setNeedsLayout()
            }
        }
        imageFetchingTask?.resume()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        configureWrap()
        configureImageView()
        configureGradient()
        configureDescriptionLabel()
        configureTitleLabel()
    }
    
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.backgroundColor = Constants.backgroundColor
        wrapView.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrapView.pinTop(to: topAnchor, Constants.Wrap.inset)
        wrapView.pinBottom(to: bottomAnchor, Constants.Wrap.inset)
        wrapView.pinLeft(to: leadingAnchor, Constants.Wrap.inset)
        wrapView.pinRight(to: trailingAnchor, Constants.Wrap.inset)
    }
    
    private func configureImageView() {
        wrapView.addSubview(articleImageView)
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = Constants.Wrap.cornerRadius
        articleImageView.pinTop(to: wrapView)
        articleImageView.pinWidth(to: wrapView)
    }
    
    private func configureGradient() {
        gradientLayer.frame = .init(x: 0, y: 0, width: 382, height: 207)
        gradientLayer.colors = [UIColor.clear.cgColor, Constants.backgroundColor.cgColor]
        articleImageView.layer.addSublayer(gradientLayer)
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Constants.DescriptionLabel.textColor
        descriptionLabel.numberOfLines = 0
        descriptionLabel.pinBottom(to: wrapView, Constants.DescriptionLabel.inset)
        descriptionLabel.pinLeft(to: wrapView, Constants.DescriptionLabel.inset)
        descriptionLabel.pinRight(to: wrapView, Constants.DescriptionLabel.inset)
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.textColor = Constants.TitleLabel.textColor
        titleLabel.font = Constants.TitleLabel.font
        titleLabel.numberOfLines = 0
        titleLabel.pinBottom(to: descriptionLabel.topAnchor)
        titleLabel.pinLeft(to: wrapView, Constants.TitleLabel.inset)
        titleLabel.pinRight(to: wrapView, Constants.TitleLabel.inset)
    }
    
    // MARK: - Constants
    private struct Constants {
        static let backgroundColor: UIColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1)
        struct Wrap {
            static let cornerRadius: CGFloat = 10
            static let inset: CGFloat = 5
        }
        struct TitleLabel {
            static let textColor: UIColor = .white
            static let font: UIFont = .systemFont(ofSize: 24, weight: .semibold)
            static let inset: CGFloat = 15
        }
        struct DescriptionLabel {
            static let textColor: UIColor = .white
            static let inset: CGFloat = 15
        }
    }
}
