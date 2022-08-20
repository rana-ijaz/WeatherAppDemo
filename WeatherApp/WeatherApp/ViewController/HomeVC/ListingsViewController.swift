//
//  ListingsViewController.swift
//  ListingsApp
//
//  Created by Rana Ijaz Ahmad on 20/08/2022.
//

import UIKit


class ListingsViewController: UITableViewController {

    var detailViewController: ListingDetailViewController? = nil
    
    let activity: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    let listingViewModel = ListingViewModel()
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)

    func fetchListings() {
        activity.startAnimating()
        listingViewModel.fetchListings()
    }
    
    func setupUI() {
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ListingDetailViewController
        }
    }
    
    func showErrorAlert(error: NetworkError) {
        // Error alert have Retry button as this is the only screen for interaction
        let alert = UIAlertController(title: error.title, message: error.errorMessage, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.activity.stopAnimating()
        }
        alert.addAction(cancelAction)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
            self.fetchListings()
        }
        
        alert.addAction(retryAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /*@objc func refresh(sender:AnyObject) {
        fetchListings()
    }*/
    
}

// MARK: View Controller Life Cycle

extension ListingsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupSearchBar()
        
        // [weak self] help to avoid retain cycle
        listingViewModel.listings.bind { (listings) in
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                if listings.count > 0 {
                    print("Success")
                    //self?.detailViewController?.listing = listings[0]
                }
                self?.activity.stopAnimating()
            }
        }
        listingViewModel.apiError?.bind(listener: { (error) in
            if error.errorMessage != nil && error.title != nil {
                self.showErrorAlert(error: error)
            }
        })
        view.addSubview(activity)
        activity.center = view.center
        
        fetchListings()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search by City name"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}
// MARK: UITableView delegate and Data source
extension ListingsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  listingViewModel.listings.value.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Height to look UI better
        return 120.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingTableViewCell
        let listing = listingViewModel.listings.value[indexPath.row]
        cell.listing = listing
        return cell
    }
}

// MARK: Segue

extension ListingsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segue is set from the UITableViewCell in Main Storyboard
        /*if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! ListingDetailViewController
                controller.listing = listingViewModel.listings.value[indexPath.row]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }*/
    }
}

extension ListingsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        listingViewModel.filterList(cityName: searchText)
    }
}
