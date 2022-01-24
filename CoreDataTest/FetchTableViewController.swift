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
    
    func fetchData() {
        let context = PersistenceManager.persistentContainer.viewContext
        
        do {
            datas = try context.fetch(Joke.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc
    func action() {
        fetchData()
        self.tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

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
