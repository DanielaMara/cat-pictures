//
//  Gallery.swift
//  CatPictures
//
//  Created by Daniela Mara on 28/03/21.
//

import Foundation

class Gallery: Codable {
    var id: String = ""
    var title: String = ""
    var description: String? = ""
    var datetime: Int? = 0
    var cover: String? = ""
    var cover_width: Int? = 0
    var cover_height: Int? = 0
    var account_url: String? = ""
    var account_id: Int? = 0
    var privacy: String? = ""
    var layout: String? = ""
    var views: Int? = 0
    var link: String? = ""
    var ups: Int? = 0
    var downs: Int? = 0
    var points: Int? = 0
    var score: Int? = 0
    var is_album: Bool?
    var vote: Vote?
    var favorite: Bool?
    var nsfw: Bool?
    var section: String? = ""
    var comment_count: Int? = 0
    var favorite_count: Int? = 0
    var topic: Topic?
    var topic_id: TopicId?
    var images_count: Int? = 0
    var in_gallery: Bool?
    var is_ad: Bool?
    var tags: [Tag]?
    var ad_type: Int? = 0
    var ad_url: String? = ""
    var in_most_viral: Bool?
    var include_album_ads: Bool?
    var images: [Image]?
    var ad_config: AdConfig?
}
