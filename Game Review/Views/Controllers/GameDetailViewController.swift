//
//  GameDetailViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 21.04.2026.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    //MARK: - Properties
    private var viewModel: GameDetailViewModel
    
    
    //MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let infoCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let reviewCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Review"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    // MARK: - Sliders
    private let graphicsSlider = GameDetailViewController.makeSlider()
    private let soundSlider = GameDetailViewController.makeSlider()
    private let artSlider = GameDetailViewController.makeSlider()
    private let gameplaySlider = GameDetailViewController.makeSlider()
    private let storySlider = GameDetailViewController.makeSlider()
    private let overallSlider = GameDetailViewController.makeSlider()
    
    ///To create sliders fastly and to decrease the amount of code
    private static func makeSlider() -> UISlider {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 10
        return slider
    }
    
    // MARK: Slider Value Labels
    private let graphicsValueLabel = GameDetailViewController.makeValueLabel()
    private let soundValueLabel = GameDetailViewController.makeValueLabel()
    private let artValueLabel = GameDetailViewController.makeValueLabel()
    private let gameplayValueLabel = GameDetailViewController.makeValueLabel()
    private let storyValueLabel = GameDetailViewController.makeValueLabel()
    private let overallValueLabel = GameDetailViewController.makeValueLabel()

    private static func makeValueLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .right
        label.text = "0.0"
        label.widthAnchor.constraint(equalToConstant: 36).isActive = true
        return label
    }
    
    //MARK: - Review Text
    private let reviewTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = .systemFont(ofSize: 15)
        tv.backgroundColor = .systemBackground
        tv.layer.cornerRadius = 8
        tv.isScrollEnabled = false
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        tv.text = "Write Your Review Here.."
        tv.textColor = .placeholderText
        return tv
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save Review", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    
    init(game: Game) {
        self.viewModel = GameDetailViewModel(game: game)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        
        setupUI()
        populateData()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gameTitleLabel)
        contentView.addSubview(infoCard)
        //Info Card
        infoCard.addSubview(publisherLabel)
        infoCard.addSubview(releaseDateLabel)
        infoCard.addSubview(statusLabel)
        //Review Card
        contentView.addSubview(reviewCard)
        reviewCard.addSubview(reviewTitleLabel)
        reviewCard.addSubview(editButton)
        reviewCard.addSubview(reviewTextView)
        reviewCard.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            gameTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            gameTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            gameTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            infoCard.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 20),
            infoCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            publisherLabel.topAnchor.constraint(equalTo: infoCard.topAnchor, constant: 16),
            publisherLabel.leadingAnchor.constraint(equalTo: infoCard.leadingAnchor, constant: 16),
            publisherLabel.trailingAnchor.constraint(equalTo: infoCard.trailingAnchor, constant: -16),
            
            releaseDateLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: infoCard.leadingAnchor, constant: 16),
            releaseDateLabel.trailingAnchor.constraint(equalTo: infoCard.trailingAnchor, constant: -16),
            
            statusLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: infoCard.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: infoCard.trailingAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: infoCard.bottomAnchor, constant: -16),
            
            reviewCard.topAnchor.constraint(equalTo: infoCard.bottomAnchor, constant: 20),
            reviewCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            reviewCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            reviewTitleLabel.topAnchor.constraint(equalTo: reviewCard.topAnchor, constant: 16),
            reviewTitleLabel.leadingAnchor.constraint(equalTo: reviewCard.leadingAnchor, constant: 16),
            
            editButton.centerYAnchor.constraint(equalTo: reviewTitleLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: reviewCard.trailingAnchor, constant: -16)
        ])
        
        //Special to sliders
        var lastAnchor = reviewTitleLabel.bottomAnchor
        
        lastAnchor = addSliderRow(name: "Graphics", slider: graphicsSlider, valueLabel: graphicsValueLabel, topAnchor: lastAnchor)
        lastAnchor = addSliderRow(name: "Sound Design", slider: soundSlider, valueLabel: soundValueLabel, topAnchor: lastAnchor)
        lastAnchor = addSliderRow(name: "Art Design", slider: artSlider, valueLabel: artValueLabel, topAnchor: lastAnchor)
        lastAnchor = addSliderRow(name: "Gameplay", slider: gameplaySlider, valueLabel: gameplayValueLabel, topAnchor: lastAnchor)
        lastAnchor = addSliderRow(name: "Story", slider: storySlider, valueLabel: storyValueLabel, topAnchor: lastAnchor)
        lastAnchor = addSliderRow(name: "Overall", slider: overallSlider, valueLabel: overallValueLabel, topAnchor: lastAnchor)
        
        NSLayoutConstraint.activate([
            reviewTextView.topAnchor.constraint(equalTo: lastAnchor, constant: 16),

            reviewTextView.leadingAnchor.constraint(equalTo: reviewCard.leadingAnchor, constant: 16),
            reviewTextView.trailingAnchor.constraint(equalTo: reviewCard.trailingAnchor, constant: -16),
            reviewTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            saveButton.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: reviewCard.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: reviewCard.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.bottomAnchor.constraint(equalTo: reviewCard.bottomAnchor, constant: -16),
        ])
    }
    
    private func addSliderRow(name: String, slider: UISlider, valueLabel: UILabel, topAnchor: NSLayoutYAxisAnchor) -> NSLayoutYAxisAnchor {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = name
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true

        let row = UIStackView(arrangedSubviews: [titleLabel, slider, valueLabel])
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.spacing = 8
        row.alignment = .center
        
        reviewCard.addSubview(row)
        
        NSLayoutConstraint.activate([
            row.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            row.leadingAnchor.constraint(equalTo: reviewCard.leadingAnchor, constant: 16),
            row.trailingAnchor.constraint(equalTo: reviewCard.trailingAnchor, constant: -16),
        ])
        
        return row.bottomAnchor
    }
    
    private func populateData(){
        gameTitleLabel.text = viewModel.title
        publisherLabel.text = "Publisher: \(viewModel.publisher)"
        releaseDateLabel.text = "Release Date: \(viewModel.releaseDate)"
        statusLabel.text = "Status: \(viewModel.status)"
    }
}
