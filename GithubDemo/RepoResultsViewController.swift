//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    
    var repos: [GithubRepo]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Auto resizing rows
        tableView.dataSource = self
        tableView.estimatedRowHeight = self.tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Perform the first search when the view controller first loads
        doSearch()
    }
    
    // Perform the search.
    fileprivate func doSearch() {
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            self.repos = newRepos
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }, error: { (error) -> Void in
            print(error)
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = repos {
            return repos.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoCell
        let currRepo = repos![indexPath.row]
        cell.repoAuthor.text = currRepo.ownerHandle
        cell.repoDescription.text = currRepo.repoDescription
        cell.repoTitle.text = currRepo.name
        cell.repoStars.text = "\(currRepo.stars!)"
        cell.repoForks.text = "\(currRepo.forks!)"
//        cell.repoImageView.setImageWith(fileURLWithPath: URL(currRepo.ownerAvatarURL!))
        
        let urlString = currRepo.ownerAvatarURL
        let url = URL(string: urlString!)
        cell.repoImageView.setImageWith(url!)
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
        return cell
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
