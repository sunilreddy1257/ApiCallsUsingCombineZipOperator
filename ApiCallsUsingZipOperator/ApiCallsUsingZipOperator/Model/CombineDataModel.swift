//
//  CombineDataModel.swift
//  ApiCallsUsingZipOperator
//
//  Created by Sunil Kumar Reddy Sanepalli on 22/05/23.
//

import Foundation

struct CombineDataModel: Codable {
    var postModel: [PostModel]
    let usersModel: [UsersModel]
}
