import UIKit

class HomeViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a movie"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    //Variables
    
    private var titles: [TitleResult] = [TitleResult]()
    
}
//MARK: - View Life Cycle (DidLoad)

extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
        navigationConfigurations()
        tableConfigurations()
        fetchingPopular()
        
        searchController.searchResultsUpdater = self
        
                
    }
}

//MARK: - View Life Cycle (LayoutSubviews)

extension HomeViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        upcomingTable.frame = view.bounds
                
    }
}

// MARK: - Fetching Data

extension HomeViewController {
    
    private func fetchingPopular() {
        
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


// MARK: - Navigation Configurations

extension HomeViewController {
    
    func navigationConfigurations() {
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .black
        navigationItem.searchController = searchController
    }
}

//MARK: - UICollectionView Delegate and DataSources

extension HomeViewController {
    
    func tableConfigurations() {
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        view.addSubview(upcomingTable)
        
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.fetchingTableViewCellItems(with: TitleViewModel(titleName: title.original_title ?? "Error Detected.", posterURL: title.poster_path ?? "Error Detected."))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

//MARK: - UICollectionView Delegate and DataSources

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count > 3,
              
                let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                    return
                }
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}
