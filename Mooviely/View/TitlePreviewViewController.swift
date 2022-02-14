import UIKit

class TitlePreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.text = "Title Gelecek"
        return label
    }()
    
    private let overviewLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 8
        label.textAlignment = .justified
        label.text = "Overview Gelecek"
        return label
    }()
    
    private let mainImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let releaseDate: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.text = "selam"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mainImageView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(releaseDate)
        
        configureConstraints()
        
        
    }
    
    func configureConstraints() {
        let mainImageViewComainImageViewnstraints = [
            mainImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let releaseDateConstraints = [
            releaseDate.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 15),
            releaseDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            releaseDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
        ]
        
        NSLayoutConstraint.activate(mainImageViewComainImageViewnstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(releaseDateConstraints)
        
    }
    
    public func fetchingTableViewCellItems(with model: TitlePreviewViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.mainImageView.image = image
            }
        }
        
        task.resume()
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        releaseDate.text = "Release Date: \(model.release_date)"
        
        
    }

}
