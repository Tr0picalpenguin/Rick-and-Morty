//
//  CharacterTableViewCell.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!

    var image: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image = nil
    }

    func setConfiguration(with character: ResultsDictionary) {
        fetchImage(for: character)
        var configuration = defaultContentConfiguration()
        configuration.text = character.name
        configuration.secondaryText = character.species
        configuration.imageProperties.maximumSize = CGSize(width: 100, height: 150)
        contentConfiguration = configuration
    }
    
    func fetchImage(for character: ResultsDictionary) {
        guard let imageString = character.imageString else {return}
        NetworkingController.fetchImage(with: imageString) { result in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }
//
//
//    func fetchCharacterName(for character: ResultsDictionary) {
//        NetworkingController.fetchTopLevelDictionary(with: character.name) { result in
//            switch result {
//            case.success(let character):
//                DispatchQueue.main.async {
//                    self.characterNameLabel.text = character.name
//                }
//            case.failure(let error):
//                print("There was an error!", error.errorDescription!)
//            }
//        }
//
//    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        guard var configuration = contentConfiguration as? UIListContentConfiguration else { return }
        configuration.image = self.image
        contentConfiguration = configuration
    }
    
} // End of class
