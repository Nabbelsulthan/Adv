//
//  ArticlesTableViewCell.swift
//  Task-vajro
//
//  Created by Nabbel on 08/11/24.
//

import UIKit


class ArticlesTableViewCell: UITableViewCell {
    
    let contentContainerView = UIView()
    let articleImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    var imageHeightConstraint: NSLayoutConstraint?
    var imageWidthConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
     required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    //MARK: - Cell setup and Constraints
    
    private func setupViews() {
        //view
    
        contentView.addSubview(contentContainerView)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 4
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 0.1
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.masksToBounds = true
    
        
        // Image
        articleImageView.contentMode = .scaleAspectFill
        contentContainerView.addSubview(articleImageView)
        
        // Title label
        titleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
        contentContainerView.addSubview(titleLabel)
        
        // Description label
        descriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        descriptionLabel.textColor = UIColor.gray
        descriptionLabel.numberOfLines = 2
        contentContainerView.addSubview(descriptionLabel)
  
    }
    
    
    
        private func setupConstraints() {
            
            contentContainerView.translatesAutoresizingMaskIntoConstraints = false
            articleImageView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    
        
            NSLayoutConstraint.activate([
    
                contentContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                contentContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                contentContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                contentContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
    

                // Article ImageView constraints
                articleImageView.topAnchor.constraint(equalTo: contentContainerView.topAnchor, constant: 8),
                articleImageView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor),
                articleImageView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor),
    
                // Title Label constraints
                titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -16),
    
                // Description Label constraints
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor, constant: 16),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor, constant: -16),
                descriptionLabel.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor, constant: -8)
            ])
        }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Ensure the corner radius is applied after layout is completed
        contentContainerView.layer.cornerRadius = 10
        contentContainerView.layer.masksToBounds = true

    
    }
    
    private func adjustImageViewSize(width: CGFloat, height: CGFloat) {
        imageWidthConstraint?.isActive = false
        imageHeightConstraint?.isActive = false

 
        let aspectRatio = height / width
        imageWidthConstraint = articleImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        imageHeightConstraint = articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor, multiplier: aspectRatio)
        
        imageWidthConstraint?.isActive = true
        imageHeightConstraint?.isActive = true
        layoutIfNeeded()
    }
    
 //MARK: - cell configuration
    
    func configure(with article: Article) {
        titleLabel.text = article.title

        print("Summary HTML: \(article.summary_html)")
        if let attributedString = article.summary_html.htmlToAttributedString {

            descriptionLabel.attributedText = attributedString
        } else {
            print("Error: Failed to convert HTML to string.")
        }

        let imageWidth = CGFloat(article.image.width)
        let imageHeight = CGFloat(article.image.height)
        adjustImageViewSize(width: imageWidth, height: imageHeight)

        if let url = URL(string: article.image.src) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.articleImageView.image = image
                    }
                }
            }
        }
    }
}

//MARK: - Html to NsAttributedString
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            print("Error: Failed to convert string to data using UTF-8 encoding.")
            return nil
        }
        
        do {
            let attributedString = try NSAttributedString(data: data,
                                                         options: [.documentType: NSAttributedString.DocumentType.html,
                                                                   .characterEncoding: String.Encoding.utf8.rawValue],
                                                         documentAttributes: nil)
            return attributedString
        } catch {
            print("Error: Failed to create NSAttributedString from HTML. Error: \(error.localizedDescription)")
            return nil
        }
    }
}





  
