//
//  GameDetailViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 21.04.2026.
//

import UIKit
import Kingfisher
import SnapKit

class GameDetailViewController: UIViewController {
    
    //MARK: - Properties
    private var viewModel: GameDetailViewModel
    private var isEditingReview: Bool = false
    
    //MARK: - Delegate
    weak var delegate: GameDetailDelegate?
    
    
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
    private let gameImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.backgroundColor = .systemGray5
        return iv
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
        
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .automatic

        view.backgroundColor = .systemBackground
        title = viewModel.title

        setupUI()
        populateData()
        setupActions()
        setupKeyboardDismissal()
        viewModel.onPublisherLoaded = { [weak self] publisher in
            self?.publisherLabel.text = "Publisher: \(publisher)"
        }
        viewModel.fetchPublisher()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gameImageView)
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
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
//          make.top.equalToSuperview()
//          make.leading.trailing.equalToSuperview()
//          make.bottom.equalToSuperview()
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        gameImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        gameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(gameImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        infoCard.snp.makeConstraints { make in
            make.top.equalTo(gameTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        publisherLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(publisherLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        
        reviewCard.snp.makeConstraints { make in
            make.top.equalTo(infoCard.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            
            make.bottom.equalToSuperview().inset(24)
        }
        
        reviewTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(reviewTitleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        
        var lastView: UIView = reviewTitleLabel
        
        lastView = addRatingRow(name: "Graphics", field: graphicsField, topView: lastView)
        lastView = addRatingRow(name: "Sound Design", field: soundField, topView: lastView)
        lastView = addRatingRow(name: "Art Design", field: artField, topView: lastView)
        lastView = addRatingRow(name: "Gameplay", field: gameplayField, topView: lastView)
        lastView = addRatingRow(name: "Story", field: storyField, topView: lastView)
        lastView = addRatingRow(name: "Overall", field: overallField, topView: lastView)
        
        
        reviewTextView.snp.makeConstraints { make in
            make.top.equalTo(lastView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(100)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(reviewTextView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().inset(24)
        }
    }
    private func setupKeyboardDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        scrollView.keyboardDismissMode = .onDrag
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func addRatingRow(name: String, field: UITextField, topView: UIView) -> UIView {

        let titleLabel = UILabel()
        titleLabel.text = name
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        let row = UIStackView(arrangedSubviews: [titleLabel, field])
        row.axis = .horizontal
        row.spacing = 8
        row.alignment = .center

        reviewCard.addSubview(row)

        row.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        return row
    }
    
    private func setupActions() {
        let fields = [graphicsField, soundField, artField, gameplayField, storyField, overallField]
        fields.forEach { $0.delegate = self }
        
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    private func setEditingMode(_ editing: Bool) {
        isEditingReview = editing
        
        if !editing {
            view.endEditing(true)
        }
        
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
        
        delegate?.didUpdateGame(viewModel.game)
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
        
        if let urlString = viewModel.game.imageURL, let url = URL(string: urlString) {
            gameImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
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


protocol GameDetailDelegate: AnyObject {
    func didUpdateGame(_ game: Game)
}
