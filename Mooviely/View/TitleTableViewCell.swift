import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"

//MARK: - Basic Components of Table View Cell
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.numberOfLines = 2
        return label
    }()
    
    private let releaseDate: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.text = "selam"
        return label
    }()
    
    private let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
//MARK: - Override Section
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(releaseDate)
        contentView.backgroundColor = .systemBackground
        
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }


}

//MARK: - Basic Components of Table View Cell

extension TitleTableViewCell {
    
    private func applyConstraints() {
        
        let titlesPosterUIImageViewConstraints = [
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 10)
        ]
        
        let overviewConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            overviewLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 10),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        
        let releaseDateConstraints = [
            releaseDate.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 40),
            releaseDate.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 10),
            releaseDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewConstraints)
        NSLayoutConstraint.activate(releaseDateConstraints)
        
    }

}

//MARK: - Basic Components of Table View Cell

extension TitleTableViewCell {
    
    public func fetchingTableViewCellItems(with model: TitleViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.titlesPosterUIImageView.image = image
            }
        }
        
        task.resume()
        titleLabel.text = model.titleName
        overviewLabel.text = model.overview
        releaseDate.text = "Release Date: \(model.release_date)"
        
        
    }

}
