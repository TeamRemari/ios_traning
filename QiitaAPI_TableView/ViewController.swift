//
//  ViewController.swift
//  QiitaAPI_TableView
//
//  Created by Sho Morita on 2019/04/02.
//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellId = "cellId"
    
    private var feedItems = [FeedItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "投稿一覧"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        fetchFeedItems(completion: {[weak self] in self?.tableView.reloadData()})
    }
    
    private func fetchFeedItems(completion: @escaping () -> ()) {
        let url = "https://qiita.com/api/v2/items"
        guard var urlComponents = URLComponents(string: url) else {return}
        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: "20"),
            URLQueryItem(name: "query", value: "iOS")
        ]
        
        
        guard let theUrl = urlComponents.url else {return}
        URLSession.shared.dataTask(with: theUrl) { [weak self] (data, _, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            do {
                let items = try JSONDecoder().decode([FeedItem].self, from: data)
                items.forEach({self?.feedItems.append($0)})
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print(error.localizedDescription)
                return
            }
        }.resume()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = feedItems[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = post.user.id
        cell.textLabel?.text = post.title
        return cell
    }
}

