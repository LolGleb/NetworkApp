//
//  Course.swift
//  NetworkApp
//
//  Created by g.semshchikov on 29.01.2023.
//

import Foundation

struct Course: Decodable {
    let name: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct WebsiteDescription: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
