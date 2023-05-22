//
//  NetworkManager.swift
//  ApiCallsUsingZipOperator
//
//  Created by Sunil Kumar Reddy Sanepalli on 22/05/23.
//

import Foundation
import Combine

class NetworkManager {
    static var shared = NetworkManager()
    private init() {}
    
    private var cancellables = Set<AnyCancellable>()
    
    func getData<T: Decodable>(url: String, type: T.Type) -> Future<[T], Error> {
        return Future<[T], Error> { [weak self] promise in
            guard let url = URL(string: url) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let responseData = response as? HTTPURLResponse, 200...299 ~= responseData.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let error as DecodingError:
                            promise(.failure(error))
                        default:
                            promise(.failure(NetworkError.decodingError))
                        }
                    }
                } receiveValue: { decodeData in
                    promise(.success(decodeData))
                }
                .store(in: &self!.cancellables)
        }
        
    }
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case responseError
}
