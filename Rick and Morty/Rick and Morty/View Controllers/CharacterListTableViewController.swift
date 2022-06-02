//
//  CharacterListTableViewController.swift
//  Rick and Morty
//
//  Created by Scott Cox on 6/1/22.
//

import UIKit

class CharacterListTableViewController: UITableViewController {
    
    @IBOutlet weak var characterSearchBar: UISearchBar!
    
    var characterList: [ResultsDictionary] = []
    var topLevelDictionary: TopLevelDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterSearchBar.delegate = self
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let topLevelDictionary = topLevelDictionary,
              let nextURL = URL(string: topLevelDictionary.info.nextURL) else {return}
        
        let lastCharacterIndex = characterList.count - 1
        
        if indexPath.row == lastCharacterIndex {
            NetworkingController.fetchTopLevelDictionary(with: nextURL) { result in
                switch result {
                case.success(let topLevelDict):
                    self.topLevelDictionary = topLevelDict
                    self.characterList.append(contentsOf: topLevelDict.results)
                    
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                    
                case.failure(let error):
                    print("God Damnit Morty! Error!!!", error.localizedDescription)
                }
            }
        }
    }
    
    
    
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

extension CharacterListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // use the search term to search the SOT for characters that have that search term text in their name.
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?name=\(searchText)") else {return}
        NetworkingController.fetchTopLevelDictionary(with: url) { [weak self] result in
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
}


