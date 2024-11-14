//
//  Model.swift
//  Task-vajro
//
//  Created by Nabbel on 08/11/24.
//


import Foundation

struct ArticleResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let id: Int
    let title: String
    let created_at :String
    let body_html: String
    let blog_id :Int
    let author : String
    let user_id : Int
    let published_at : String
    let updated_at : String
    let summary_html : String
    let template_suffix : String
    let handle : String
    let tags : String
    let admin_graphql_api_id : String
    let image: ImageInfo
}

struct ImageInfo: Codable {
    let alt : String
    let width: Int
    let height: Int
    let src: String
}

