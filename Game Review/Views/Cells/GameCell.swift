//
//  GameCell.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 17.04.2026.
//

import UIKit
import Kingfisher
import SnapKit

class GameCell: UITableViewCell{
    //MARK: - UI Elements
    private lazy var gameImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemGray5
        return iv
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.showsMenuAsPrimaryAction = true // To open the dropdown menu
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI()
    {
        contentView.addSubview(gameImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(statusButton)
    }
    
    private func setupConstraints() {
        //LEFt - image
        gameImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(56)
            
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        // Label next to image
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(gameImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(ratingLabel.snp.leading).offset(-8)
        }
        
        //CENTER - rating
        ratingLabel.snp.makeConstraints { make in
            make.trailing.equalTo(statusButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        //RIGHT - status
        statusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameImageView.kf.cancelDownloadTask()
        statusButton.menu = nil
    }
    
    func configure(with game: Game, onStatusChange: @escaping (GameStatus) -> Void){
        titleLabel.text = game.title
        
        if let rating = game.rating {
            ratingLabel.text = "\(rating) / 10"
        } else{
            ratingLabel.text = "NR"
        }
        
        if let urlString = game.imageURL, let url = URL(string: urlString) {
            gameImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "photo"), // "photo" is from Apple's SF Symbols Library, this actually exists.
                options: [.cacheOriginalImage]
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
    
    func updateStatusOnly(to status: GameStatus) {
        switch status {
        case .unplayed: statusButton.setTitle("Unplayed", for: .normal)
        case .playing:  statusButton.setTitle("Playing", for: .normal)
        case .finished: statusButton.setTitle("Finished", for: .normal)
        case .reviewed: statusButton.setTitle("Reviewed", for: .normal)
        }
    }
}
