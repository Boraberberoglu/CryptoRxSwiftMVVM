//
//  WebService.swift
//  CryptoRxSwiftMVVM
//
//  Created by Bora Berberoğlu on 31.01.2024.
//

import UIKit

enum CryptoError:Error {
    case serverError
    case parsingError
}


class WebService {
    
    
    func downloadCurrencies(url:URL, completion: @escaping (Result<[Crypto],CryptoError>)->()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.serverError))
            }else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                guard let cryptoList else {
                    completion(.failure(.parsingError))
                    return}
                completion(.success(cryptoList))
            }
        }
        .resume()
    }
    
}
