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
    
    
    func updateViews() {
        guard let character = character else {
            return
        }
        NetworkingController.fetchImage(with: character.imageString ?? "Photo Unavailable") { [weak self] result in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    self?.characterImage.image = image
                    self?.nameLabel.text = character.name
                    self?.statusLabel.text = "Status: \(character.status)"
                    self?.speciesLabel.text = character.species
                    self?.genderLabel.text = character.gender
                    self?.idLabel.text = "Character No:\(character.id)"
                    self?.originLabel.text = character.origin.name
                    self?.currentLocationLabel.text = character.location.name
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
        
        
        
        
    }
    
} // End of class
