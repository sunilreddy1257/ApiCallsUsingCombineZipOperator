//
//  ViewModel.swift
//  ApiCallsUsingZipOperator
//
//  Created by Sunil Kumar Reddy Sanepalli on 22/05/23.
//

import Foundation
import Combine

class ViewModel {
  
    func getData() {
        
        let publishers = Publishers.Zip(
            getPublisherData(url: UrlsList.usersList, type: UsersModel.self),
            getPublisherData(url: UrlsList.postsList, type: PostModel.self)
        )
        publishers.map { (usersData, postsData) in
            
        }
        
    }
    
    func getPublisherData<T: Decodable>(url: String, type: T.Type) -> Future<[T], Error>{
        NetworkManager.shared.getData(url: url, type: T.self)
    }
}
