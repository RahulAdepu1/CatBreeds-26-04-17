// Copyright © 2021 Intuit, Inc. All rights reserved.
import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let viewModel = ViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    private var isFiltering: Bool {
        return !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        navigationItem.searchController = searchController
        
        self.viewModel.catDataDelegate = self
        self.viewModel.getBreeds()
        self.setUpSearchBar()
    }
    
    func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Breeds"
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }

        viewModel.searchCatBreeds(for: searchText)
    }
}

// MARK: -
// MARK: TableView Delegate Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCatBreedList(isFiltering)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "catBreed") else {
            return UITableViewCell()
        }
        
        let catBreed = viewModel.getCatBreedList(isFiltering)?[indexPath.row]

        cell.textLabel?.text = catBreed?.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        
        cell.detailTextLabel?.text = catBreed?.description
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        cell.textLabel?.numberOfLines = 1
        cell.detailTextLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
        //navigation logic
        
        let repository = CatDetailsRepositoryImplementation(networkService: Network())
        let isVariantA = true
        
        let catBreed = viewModel.getCatBreedList(isFiltering)?[indexPath.row]

        let useCase = CatDetailsUseCaseImplemention(repository: repository)
        let viewModel = CatDetailsViewModelNew(breed: catBreed, useCase: useCase)
        
        let detailsVC = CatDetailsFactory.makeView(isVariant: isVariantA, viewModel: viewModel)
        navigationController?.pushViewController(detailsVC, animated: true)

        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let catDetailsVC = storyboard.instantiateViewController(withIdentifier: "CatDetailsViewController") as? CatDetailsViewController {
//            let catBreed = viewModel.getCatBreedList(isFiltering)?[indexPath.row]
//            catDetailsVC.breed = catBreed
//            navigationController?.pushViewController(catDetailsVC, animated: true)
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let threshold = 2
        let lastIndex = (viewModel.catBreeds?.count ?? 1) - 1
        
        guard indexPath.row >= lastIndex - threshold else { return }
        viewModel.fetchNextPage()
    }
}

// MARK: Cat Data Model Delegate Methods
extension ViewController: CatDataDelegate {
    func breedsChangedNotification() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
