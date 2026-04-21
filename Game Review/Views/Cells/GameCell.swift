//
//  GameCell.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import UIKit

class GameCell: UITableViewCell{
    private let titleLabel = UILabel()
    private let ratingLabel = UILabel()
    private let statusLabel = UILabel()
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(statusLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 1
        ratingLabel.numberOfLines = 1
        statusLabel.numberOfLines = 1
        
        NSLayoutConstraint.activate([
            //LEFT - Game Name
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            
            //CENTER - Rating
            ratingLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ratingLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            
            //RIGHT
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statusLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
        ])
        
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        ratingLabel.font = .systemFont(ofSize: 14, weight: .medium)
        statusLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        ratingLabel.textAlignment = .center
        statusLabel.textAlignment = .right
        statusLabel.textColor = .systemBlue
    }

    func configure(with game: Game){
        titleLabel.text = game.title
        
        if let rating = game.rating {
            ratingLabel.text = "\(rating) / 10"
        } else{
            ratingLabel.text = "NR"
        }
        
        switch game.status {
        case .unplayed:
            statusLabel.text = "Unplayed"
        case .playing:
            statusLabel.text = "Playing"
        case .finished:
            statusLabel.text = "Finished"
        case .reviewed:
            statusLabel.text = "Reviewed"
        }
    }
}
