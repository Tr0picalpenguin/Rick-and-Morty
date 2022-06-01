//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!
 
    
    func updateViews(with name: String) {
        NetworkingController.fetchCharacter(with: name) { result in
            switch result {
            case.success(let character):
                self.fetchCharacterName(for: character)
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
        
    }
    
    
    func fetchCharacterName(for character: ResultsDictionary) {
        NetworkingController.fetchCharacter(with: character.name) { result in
            switch result {
            case.success(let character):
                DispatchQueue.main.async {
                    self.characterNameLabel.text = character.name
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    
    }
    
    
} // end of class
