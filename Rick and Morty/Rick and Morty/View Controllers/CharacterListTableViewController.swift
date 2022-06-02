//
//  CharacterListTableViewController.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import UIKit

class CharacterListTableViewController: UITableViewController {

    var characterList: [ResultsDictionary] = []
    var topLevelDictionary: TopLevelDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingController.fetchTopLevelDictionary(with: URL(string: "https://rickandmortyapi.com/api/character")!) { [weak self] result in
            switch result {
            case.success(let topLevelDictionary):
                self?.characterList = topLevelDictionary.results
                self?.topLevelDictionary = topLevelDictionary
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell()}
        
        let character = characterList[indexPath.row]
        cell.setConfiguration(with: character)
        return cell
    }
    
    // MARK: - TODO: Pagination ..... We need this to view more than 20 characters.
    
    
    
    
    
    // MARK: - Navigation
    
        // Segue needs some work.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? CharacterDetailsViewController {
                    let characterToSend = characterList[indexPath.row]
                    destination.character = characterToSend
                        }
                    }
                }
            }
} // End of class



// MARK: - TODO: Searchbar functionality
