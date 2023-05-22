//
//  PostModel.swift
//  ApiCallsUsingZipOperator
//
//  Created by Sunil Kumar Reddy Sanepalli on 22/05/23.
//

import Foundation

struct PostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
