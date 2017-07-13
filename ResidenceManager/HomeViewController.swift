//
//  ViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-12.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var postersCollectionView: UICollectionView!
    
    var events = [HouseEvent]()
    var messages = [ChatThread]()
    var posters = [Poster]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prepare data
        prepareEvents()
        prepareMessages()
        preparePosters()
        
        // prepare UIs
        eventTableView.dataSource = self
        eventTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.delegate = self
        postersCollectionView.dataSource = self
        postersCollectionView.delegate = self
    }
    
    func prepareEvents() {
        let store = HouseEventStore()
        store.fetchAll() { (result) in
            self.events.removeAll()
            
            switch result {
            case let .success(events):
                self.events.append(contentsOf: events)
                
            case let .failure(error):
                print("ERROR at prepareEvents", error as Any)
            }
            
            self.eventTableView.reloadData()
        }
    }
    
    func prepareMessages() {
        let store = ChatThreadStore()
        store.fetchAll() { (result) in
            self.messages.removeAll()
            
            switch result {
            case let .success(messages):
                self.messages.append(contentsOf: messages)
                
            case let .failure(error):
                print("ERROR at prepareMessages", error as Any)
            }
            
            self.messageTableView.reloadData()
        }
    }
    
    func preparePosters() {
        let store = PosterStore()
        store.fetchAll() { (result) in
            self.posters.removeAll()
            
            switch result {
            case let .success(posters):
                self.posters.append(contentsOf: posters)
                
            case let .failure(error):
                print("ERROR at preparePosters", error as Any)
            }
            
            self.postersCollectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        if let vc = destination as? EventDetailViewController {
            let indexPath = eventTableView.indexPathForSelectedRow!
            let event = events[indexPath.row]
            vc.event = event
        }
        else if let vc = destination as? ChatThreadViewController {
            let indexPath = messageTableView.indexPathForSelectedRow!
            let thread = messages[indexPath.row]
            vc.thread = thread
        }
        else if let vc = destination as? PosterDetailViewController {
            let indexPath = postersCollectionView.indexPathsForSelectedItems?[0]
            let poster = posters[indexPath!.row]
            vc.poster = poster
        }
    }
}

extension HomeViewController: UITableViewDataSource, UICollectionViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case eventTableView:
            return events.count
        case messageTableView:
            return messages.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case postersCollectionView:
            return posters.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case eventTableView:
            return eventTableView(cellForRowAt: indexPath)
        case messageTableView:
            return messageTableView(cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case postersCollectionView:
            return posterCollectionView(cellForItemAt: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    func eventTableView(cellForRowAt indexPath: IndexPath) -> HomeEventTableViewCell {
        let event = events[indexPath.row]
        
        let cell = eventTableView.dequeueReusableCell(withIdentifier: HomeEventTableViewCell.identifier, for: indexPath) as! HomeEventTableViewCell
        cell.event = event
        
        return cell
    }
    
    func messageTableView(cellForRowAt indexPath: IndexPath) -> HomeMessageTableViewCell {
        let message = messages[indexPath.row]
        
        let cell = messageTableView.dequeueReusableCell(withIdentifier: HomeMessageTableViewCell.identifier, for: indexPath) as! HomeMessageTableViewCell
        cell.thread = message
        
        return cell
    }
    
    func posterCollectionView(cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let poster = posters[indexPath.row]
        
        let cell = postersCollectionView.dequeueReusableCell(withReuseIdentifier: HomePosterCollectionViewCell.identifier, for: indexPath) as! HomePosterCollectionViewCell
        cell.poster = poster
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate, UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case eventTableView:
            eventTableView.deselectRow(at: indexPath, animated: true)
        case messageTableView:
            messageTableView.deselectRow(at: indexPath, animated: true)
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case postersCollectionView:
            postersCollectionView.deselectItem(at: indexPath, animated: true)
        default: break
        }
    }
}
