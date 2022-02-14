import UIKit

class SearchResultsViewController: UIViewController {
    
    public var titles: [TitleResult] = [TitleResult]()
    
    public let searchResultsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)

        tableConfigurations()
    }
}

//MARK: - View Life Cycle (LayoutSubviews)

extension SearchResultsViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchResultsCollectionView.frame = view.bounds
                
    }
}

//MARK: - UICollectionView Delegate and DataSources

extension SearchResultsViewController {
    
    func tableConfigurations() {
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.fetchingCollectionViewCellItems(with: title.poster_path ?? "")
        return cell
    }
    

}


