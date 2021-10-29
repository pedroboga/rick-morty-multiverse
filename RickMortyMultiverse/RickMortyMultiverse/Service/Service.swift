//
//  Service.swift
//  RickMortyMultiverse
//
//  Created by Pedro Boga on 21/10/21.
//

import Foundation
import UIKit

struct Service {
    private var endPoint = "https://rickandmortyapi.com/api/"
    
    func getCharacter(_ completion: @escaping ([RMCharacter]) -> Void) {
        guard let url = URL(string: "\(endPoint)/character") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { return }
            //if let _ = response { return }
            
            if let data = data {
                let jsonDecode = JSONDecoder()
                //jsonDecode.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decode = try jsonDecode.decode(RMCharacters.self, from: data)
                    DispatchQueue.main.async {
                        guard let result = decode.results else { return }
                        completion(result)
                    }
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    func setImage(with urlString: String, _ completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //guard let self = self else { return }
            guard let data = data, error == nil else {
                return
            }
            //let image = UIImage(data: data)
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image ?? UIImage())
                //self.imageHeader = image ?? UIImage()
            }
        }
        task.resume()
    }
    
//    func fetchCharacter(_ completion: @escaping (Character?) -> Void) {
//        let url = URL(string: "https://rickandmortyapi.com/api/character/19")!
//
//        performRequest(url, completion: completion)
//    }
//
//    func fetchEpisodes(_ completion: @escaping([Episodes]?) -> Void) {
//        let url = URL(string: "https://rickandmortyapi.com/api/character/19/episode")!
//
//        performRequest(url, completion: completion)
//    }
//
//    func performRequest<T: Decodable>(_ url: URL, completion: @escaping (T?) -> Void) {
//
//        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completion(nil)
//                return
//            }
//
//            if let data = data {
//                let jsonDecodable = JSONDecoder()
//                do {
//                    let result = try jsonDecodable.decode(T.self, from: data)
//                    completion(result)
//
//                } catch {
//                    print(error)
//                    completion(nil)
//                }
//            }
//        }
//        dataTask.resume()
//    }
}
