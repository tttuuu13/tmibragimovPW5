//
//  ArticleModels.swift
//  tmibragimovPW5
//
//  Created by тимур on 12.12.2024.
//

import Foundation

struct NewsArchive: Decodable {
    let articlesByMonth: [ArticlesByMonth]
    enum CodingKeys: String, CodingKey {
        case articlesByMonth = "results"
    }
}

struct ArticlesByMonth: Decodable {
    let articles: [Article]
    enum CodingKeys: String, CodingKey {
        case articles = "result"
    }
}

struct Article: Decodable {
    let title: String
    let description: String
    let date: String
    let link: String
    let imageSrcs: ImageSrcs
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case date
        case link
        case imageSrcs = "image_srcs"
    }
}

struct ImageSrcs: Decodable {
    let large: String?
    let large2x: String?
}
