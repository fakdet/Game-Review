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
    private var isEditingReview: Bool = false
    
    
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
    
    // MARK: - Fields
    private let graphicsField = GameDetailViewController.makeRatingField()
    private let soundField = GameDetailViewController.makeRatingField()
    private let artField = GameDetailViewController.makeRatingField()
    private let gameplayField = GameDetailViewController.makeRatingField()
    private let storyField = GameDetailViewController.makeRatingField()
    private let overallField = GameDetailViewController.makeRatingField()
    
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
        reviewTextView.delegate = self
        
        view.backgroundColor = .systemBackground
        title = viewModel.title

        setupUI()
        populateData()
        setupActions()
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
            editButton.trailingAnchor.constraint(equalTo: reviewCard.trailingAnchor, constant: -16),
        ])
        
        //Special to sliders
        var lastAnchor = reviewTitleLabel.bottomAnchor
        
        lastAnchor = addRatingRow(name: "Graphics",     field: graphicsField,  topAnchor: lastAnchor)
        lastAnchor = addRatingRow(name: "Sound Design", field: soundField,     topAnchor: lastAnchor)
        lastAnchor = addRatingRow(name: "Art Design",   field: artField,       topAnchor: lastAnchor)
        lastAnchor = addRatingRow(name: "Gameplay",     field: gameplayField,  topAnchor: lastAnchor)
        lastAnchor = addRatingRow(name: "Story",        field: storyField,     topAnchor: lastAnchor)
        lastAnchor = addRatingRow(name: "Overall",      field: overallField,   topAnchor: lastAnchor)

        
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

            reviewCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
        ])
    }
    
    private func addRatingRow(name: String, field: UITextField, topAnchor: NSLayoutYAxisAnchor) -> NSLayoutYAxisAnchor {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = name
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let row = UIStackView(arrangedSubviews: [titleLabel, field])
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
    
    private func setupActions() {
        let fields = [graphicsField, soundField, artField, gameplayField, storyField, overallField]
        fields.forEach { $0.delegate = self }
        
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    private func setEditingMode(_ editing: Bool) {
        isEditingReview = editing
        
        let fields = [graphicsField, soundField, artField, gameplayField, storyField, overallField]
        fields.forEach { $0.isUserInteractionEnabled = editing }
        fields.forEach { $0.alpha = editing ? 1.0 : 0.5 }
        
        reviewTextView.isEditable = editing
        reviewTextView.alpha = editing ? 1.0 : 0.8
        
        saveButton.isHidden = !editing
        editButton.setTitle(editing ? "Cancel" : "Edit", for: .normal)
    }
    
    private static func makeRatingField() -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        tf.textAlignment = .center
        tf.placeholder = "0.0"
        tf.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return tf
    }
    
    @objc private func editTapped() {
        if isEditingReview {
            //reload original data
            populateData()
            setEditingMode(false)
        } else {
            setEditingMode(true)
        }
    }
    
    @objc private func saveTapped() {
        viewModel.saveReview(
            graphics:    Double(graphicsField.text ?? "0") ?? 0,
            soundDesign: Double(soundField.text ?? "0") ?? 0,
            artDesign:   Double(artField.text ?? "0") ?? 0,
            gameplay:    Double(gameplayField.text ?? "0") ?? 0,
            story:       Double(storyField.text ?? "0") ?? 0,
            overall:     Double(overallField.text ?? "0") ?? 0,
            text:        reviewTextView.text ?? ""
        )
        
        setEditingMode(false)
        editButton.isHidden = false
        statusLabel.text = "Status: \(viewModel.status)"
    }
    
    private func populateData(){
        gameTitleLabel.text = viewModel.title
        publisherLabel.text = "Publisher: \(viewModel.publisher)"
        releaseDateLabel.text = "Release Date: \(viewModel.releaseDate)"
        statusLabel.text = "Status: \(viewModel.status)"
        
        if viewModel.hasReview {
            graphicsField.text = String(format: "%.1f", viewModel.graphics)
            soundField.text    = String(format: "%.1f", viewModel.soundDesign)
            artField.text      = String(format: "%.1f", viewModel.artDesign)
            gameplayField.text = String(format: "%.1f", viewModel.gameplay)
            storyField.text    = String(format: "%.1f", viewModel.story)
            overallField.text  = String(format: "%.1f", viewModel.overallRating)
            
            reviewTextView.text = viewModel.reviewText
            reviewTextView.textColor = .label
            
            setEditingMode(false)
            editButton.isHidden = false
        } else {
            setEditingMode(true)
            editButton.isHidden = true
        }
    }
    
}


extension GameDetailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let fields = [graphicsField, soundField, artField, gameplayField, storyField, overallField]
        guard fields.contains(textField) else { return }
        
        var value = Double(textField.text ?? "0") ?? 0
        value = min(max(value, 0), 10)
        value = (value * 10).rounded() / 10 // 1 decimal
        textField.text = String(format: "%.1f", value)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fields = [graphicsField, soundField, artField, gameplayField, storyField, overallField]
        guard fields.contains(textField) else { return true }
        
        if string.isEmpty { return true }
        
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        guard string.rangeOfCharacter(from: allowedCharacters.inverted) == nil else { return false }
        
        let currentText = textField.text ?? ""
        if string == "." && currentText.contains(".") { return false }
        
        return true
    }
}

extension GameDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write Your Review Here.."
            textView.textColor = .placeholderText
        }
    }
}
