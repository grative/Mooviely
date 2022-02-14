import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"

//MARK: - Basic Components of Table View Cell
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(titlesPosterUIImageView)
        contentView.backgroundColor = .systemCyan
        
        
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
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        
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
        
        
    }

}
