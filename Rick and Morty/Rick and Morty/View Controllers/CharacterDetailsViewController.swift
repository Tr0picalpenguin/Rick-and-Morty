//
//  CharacterDetailsViewController.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    var character: ResultsDictionary? {
        didSet {
            updateViews()
        }
    }
    var origin: OriginDictionary? {
        didSet {
            updateViews()
        }
    }
    var location: LocationDictionary? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let character = character else {
            return
        }
        NetworkingController.fetchImage(with: character.imageString ?? "Photo Unavailable") { result in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    self.characterImage.image = image
                   
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
        
        self.character = character
        self.nameLabel.text = character.name
        self.statusLabel.text = character.status
        self.speciesLabel.text = character.species
        self.genderLabel.text = character.gender
        self.idLabel.text = "Character No:\(character.id)"
        self.originLabel.text = self.origin?.name
        self.currentLocationLabel.text = self.location?.name
        

    }

} // End of class
