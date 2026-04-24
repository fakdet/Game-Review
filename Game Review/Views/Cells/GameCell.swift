//
//  GameCell.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import UIKit
import Kingfisher

class GameCell: UITableViewCell{
    //MARK: - UI Elements
    private let gameImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemGray5
        return iv
    }()
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private let statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.showsMenuAsPrimaryAction = true // To open the dropdown menu
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    //MARK: This is not used, but required to be implemented.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI()
    {
        contentView.addSubview(gameImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(statusButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 2
        ratingLabel.numberOfLines = 1
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        ratingLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        ratingLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            //LEFT - image
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            gameImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            gameImageView.widthAnchor.constraint(equalToConstant: 56),
            gameImageView.heightAnchor.constraint(equalToConstant: 56),
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            //Label next to image
            titleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -8),
            
            // CENTER - rating
            
            ratingLabel.trailingAnchor.constraint(equalTo: statusButton.leadingAnchor, constant: -8),
            ratingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 50),
            
            //RIGHT - status
            statusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            statusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusButton.widthAnchor.constraint(equalToConstant: 80),
        ])

    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.kf.cancelDownloadTask()
        gameImageView.image = nil
    }
    
    func configure(with game: Game, onStatusChange: @escaping (GameStatus) -> Void){
        titleLabel.text = game.title
        
        if let rating = game.rating {
            ratingLabel.text = "\(rating) / 10"
        } else{
            ratingLabel.text = "NR"
        }
        
        if let urlString = game.imageURL, let url = URL(string: urlString) {
            let processor = DownsamplingImageProcessor(size: gameImageView.bounds.size)

            gameImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"),
                options: [
                    .processor(processor),
                    .scaleFactor(gameImageView.traitCollection.displayScale),
                    .cacheOriginalImage
                ]
            )
        } else {
            gameImageView.image = UIImage(systemName: "photo")
        }
        
        switch game.status {
        case .unplayed: statusButton.setTitle("Unplayed", for: .normal)
        case .playing:  statusButton.setTitle("Playing", for: .normal)
        case .finished: statusButton.setTitle("Finished", for: .normal)
        case .reviewed: statusButton.setTitle("Reviewed", for: .normal)
        }
        
        //Dropdown menu build
        statusButton.menu = UIMenu(title: "Change Status", children: [
            UIAction(title: "Unplayed", image: UIImage(systemName: "circle")) { _ in
                onStatusChange(.unplayed)
            },
            UIAction(title: "Playing", image: UIImage(systemName: "play.circle")) { _ in
                onStatusChange(.playing)
            },
            UIAction(title: "Finished", image: UIImage(systemName: "checkmark.circle")) { _ in
                onStatusChange(.finished)
            },
        ])
    }
}
