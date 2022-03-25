//
//  PromotionList.swift
//  yes
//
//  Created by MacBook on 2021-12-20.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let promotionList = try? newJSONDecoder().decode(PromotionList.self, from: jsonData)

import Foundation

// MARK: - PromotionList
struct PromotionList: Codable {
    let status: String
    let count, pages: Int
    let category: Category
    let posts: [Post]
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let slug, title, categoryDescription: String
    let parent, postCount: Int

    enum CodingKeys: String, CodingKey {
        case id, slug, title
        case categoryDescription = "description"
        case parent
        case postCount = "post_count"
    }
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let type, slug: String
    let url: String
    let status, title, titlePlain, content: String
    let excerpt, date, modified: String
    let categories: [Category]
    let tags: [JSONAny]
    let author: Author
    let comments: [JSONAny]
    let attachments: [Attachment]
    let commentCount: Int
    let commentStatus: String
    let thumbnail: String
    let customFields: CustomFields
    let thumbnailSize: String
    let thumbnailImages: Images

    enum CodingKeys: String, CodingKey {
        case id, type, slug, url, status, title
        case titlePlain = "title_plain"
        case content, excerpt, date, modified, categories, tags, author, comments, attachments
        case commentCount = "comment_count"
        case commentStatus = "comment_status"
        case thumbnail
        case customFields = "custom_fields"
        case thumbnailSize = "thumbnail_size"
        case thumbnailImages = "thumbnail_images"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let id: Int
    let url: String
    let slug, title, attachmentDescription, caption: String
    let parent: Int
    let mimeType: String
    let images: Images

    enum CodingKeys: String, CodingKey {
        case id, url, slug, title
        case attachmentDescription = "description"
        case caption, parent
        case mimeType = "mime_type"
        case images
    }
}

// MARK: - Images
struct Images: Codable {
    let full, thumbnail, medium, the1536X1536: The1536_X1536
    let the2048X2048, postThumbnail: The1536_X1536

    enum CodingKeys: String, CodingKey {
        case full, thumbnail, medium
        case the1536X1536 = "1536x1536"
        case the2048X2048 = "2048x2048"
        case postThumbnail = "post-thumbnail"
    }
}

// MARK: - The1536_X1536
struct The1536_X1536: Codable {
    let url: String
    let width, height: Int
}

// MARK: - Author
struct Author: Codable {
    let id: Int
    let slug, name, firstName, lastName: String
    let nickname: String
    let url: String
    let authorDescription: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname, url
        case authorDescription = "description"
    }
}
// MARK: - CustomFields
struct CustomFields: Codable {
}

