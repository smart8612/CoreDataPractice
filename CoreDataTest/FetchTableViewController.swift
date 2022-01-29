//
//  FetchTableViewController.swift
//  CoreDataTest
//
//  Created by JeongTaek Han on 2022/01/24.
//

import UIKit

class FetchTableViewController: UITableViewController {
    
    var datas: [Joke] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(action), for: .valueChanged)
    }
    
    @objc
    func action() {
        fetchData()
        self.tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

// MARK: - CoreData Utilities
extension FetchTableViewController {
    
    private func fetchData() {
        let context = PersistenceManager.persistentContainer.viewContext
        
        do {
            datas = try context.fetch(Joke.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteData(with id: UUID) {
        let context = PersistenceManager.persistentContainer.viewContext
        
        do {
            let fetchRequest = Joke.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
            let fetchResult = try context.fetch(fetchRequest)
            guard let targetObject = fetchResult.first else { return }
            context.delete(targetObject)
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}

// MARK: - Table view data source
extension FetchTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let currentJoke = datas[indexPath.row]
        content.text = "\(currentJoke.category) : \(currentJoke.body)"
        cell.contentConfiguration = content
        return cell
    }
    
}

//MARK: - Table view delegate
extension FetchTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteData(with: datas[indexPath.row].id)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
