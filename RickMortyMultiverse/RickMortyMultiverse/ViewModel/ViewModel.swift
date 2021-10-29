//
//  ViewModel.swift
//  RickMortyMultiverse
//
//  Created by Pedro Boga on 28/10/21.
//

import Foundation
import UIKit

class ViewModel {
    let service = Service()
    var characters: [RMCharacter]?
    var image: UIImage?
    
    func getCharacters(){
        service.getCharacter { characters in
            DispatchQueue.main.async {
                self.characters = characters
            }
        }
    }
    
    func getCharactersCount(_ completion: @escaping (Int) -> Void){
        service.getCharacter { [weak self] characters in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.characters = characters
                completion(characters.count)
            }
        }
    }
    
    func getImage(with indexPath: Int, _ completion: @escaping (UIImage) -> Void) {
        guard let url = characters?[indexPath].image else { return completion(UIImage()) }
        service.setImage(with: url) { [weak self] avatar in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = avatar
                completion(self.image ?? UIImage())
            }
        }
    }
}
