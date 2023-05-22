//
//  ViewModel.swift
//  ApiCallsUsingZipOperator
//
//  Created by Sunil Kumar Reddy Sanepalli on 22/05/23.
//

import Foundation
import Combine

class ViewModel {
  
    var allData: CombineDataModel?
    private var cancellable = Set<AnyCancellable>()
    func getData() {
        let publishers = Publishers.Zip(
            getPublisherData(url: UrlsList.usersList, type: UsersModel.self),
            getPublisherData(url: UrlsList.postsList, type: PostModel.self)
        )
        publishers.map { (usersData, postsData) in
            CombineDataModel(postModel: postsData, usersModel: usersData)
        }
        .sink { completion in
            if case let .failure(error) = completion {
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] combineDataModel in
            self?.allData = combineDataModel
        }
        .store(in: &self.cancellable)
    }
    
    func getPublisherData<T: Decodable>(url: String, type: T.Type) -> Future<[T], Error>{
        NetworkManager.shared.getData(url: url, type: T.self)
    }
}
