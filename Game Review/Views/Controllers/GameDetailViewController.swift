//
//  GameDetailViewController.swift
//  Game Review
//
//  Created by M.  Azizcan Erdoğan on 21.04.2026.
//

import UIKit
import Kingfisher
import SnapKit

class GameDetailViewController: BaseViewController<GameDetailViewModel> {
    
    //MARK: - Properties
    private var isEditingReview: Bool = false
    weak var delegate: GameDetailDelegate?
    
    
    //MARK: - UI Elements
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .automatic
        return sv
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var gameImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.backgroundColor = .systemGray5
        return iv
    }()
    private lazy var gameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var infoCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    private lazy var publisherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    private lazy var reviewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    private lazy var reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.GameDetail.review
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.GameDetail.edit, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    // MARK: - Fields
    private lazy var graphicsField = makeRatingField()
    private lazy var soundField = makeRatingField()
    private lazy var artField = makeRatingField()
    private lazy var gameplayField = makeRatingField()
    private lazy var storyField = makeRatingField()
    private lazy var overallField = makeRatingField()
    //MARK: - Review Text
    private lazy var reviewTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 15)
        tv.backgroundColor = .systemBackground
        tv.layer.cornerRadius = 8
        tv.isScrollEnabled = false
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        tv.text = L10n.GameDetail.reviewPlaceholder
        tv.textColor = .placeholderText
        tv.delegate = self
        return tv
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.GameDetail.save, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        populateData()
        setupActions()
        setupKeyboardDismissal()
        viewModel.fetchPublisher()
    }
    
    override func setupUI() {
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
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
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
        
        lastView = addRatingRow(name: L10n.GameDetail.graphics, field: graphicsField, topView: lastView)
        lastView = addRatingRow(name: L10n.GameDetail.sound,    field: soundField, topView: lastView)
        lastView = addRatingRow(name: L10n.GameDetail.art,      field: artField, topView: lastView)
        lastView = addRatingRow(name: L10n.GameDetail.gameplay, field: gameplayField, topView: lastView)
        lastView = addRatingRow(name: L10n.GameDetail.story,    field: storyField, topView: lastView)
        lastView = addRatingRow(name: L10n.GameDetail.overall,  field: overallField, topView: lastView)
        
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
    
    override func bindViewModel() {
        viewModel.onPublisherLoaded = { [weak self] publisher in
            self?.publisherLabel.text = "\(L10n.GameDetail.publisher): \(publisher)"
        }
        
        viewModel.onDataUpdated = { [weak self] in
            self?.populateData()
        }
    }
    
    //MARK: - Logic & Actions
    private func setupActions() {
        let fields = [graphicsField, soundField, artField, gameplayField, storyField, overallField]
        fields.forEach { $0.delegate = self }
        
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
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
    
    private func setEditingMode(_ editing: Bool) {
        isEditingReview = editing
        if !editing { view.endEditing(true) }
        
        let fields = [graphicsField, soundField, artField, gameplayField, storyField, overallField]
        fields.forEach { 
            $0.isUserInteractionEnabled = editing
            $0.alpha = editing ? 1.0 : 0.5
        }
        
        reviewTextView.isEditable = editing
        reviewTextView.alpha = editing ? 1.0 : 0.8
        
        saveButton.isHidden = !editing
        editButton.setTitle(editing ? L10n.GameDetail.cancel : L10n.GameDetail.edit, for: .normal)
    }
    
    @objc private func editTapped() {
        if isEditingReview {
            populateData() //reload original data
            setEditingMode(false)
        } else {
            setEditingMode(true)
        }
    }
    
    @objc private func saveTapped() {
        viewModel.saveReview(
            graphics:    graphicsField.doubleValue,
            soundDesign: soundField.doubleValue,
            artDesign:   artField.doubleValue,
            gameplay:    gameplayField.doubleValue,
            story:       storyField.doubleValue,
            overall:     overallField.doubleValue,
            text:        reviewTextView.text ?? ""
        )
        
        setEditingMode(false)
        editButton.isHidden = false
        statusLabel.text = "\(L10n.GameDetail.status): \(viewModel.status)"
        
        delegate?.didUpdateGame(viewModel.game)
    }
    
    private func populateData(){
        gameTitleLabel.text = viewModel.title
        publisherLabel.text = "\(L10n.GameDetail.publisher): \(viewModel.publisher)"
        releaseDateLabel.text = "\(L10n.GameDetail.releaseDate): \(viewModel.releaseDate)"
        statusLabel.text = "\(L10n.GameDetail.status): \(viewModel.status)"
        
        if viewModel.hasReview {
            graphicsField.text = viewModel.graphics.ratingString
            soundField.text    = viewModel.soundDesign.ratingString
            artField.text      = viewModel.artDesign.ratingString
            gameplayField.text = viewModel.gameplay.ratingString
            storyField.text    = viewModel.story.ratingString
            overallField.text  = viewModel.overallRating.ratingString
            
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
    
    //MARK: - Helpers
    private func makeRatingField() -> UITextField {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        tf.textAlignment = .center
        tf.placeholder = "0.0"
        tf.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        return tf
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
}

//MARK: - Extensions
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
            textView.text = L10n.GameDetail.reviewPlaceholder
            textView.textColor = .placeholderText
        }
    }
}

protocol GameDetailDelegate: AnyObject {
    func didUpdateGame(_ game: Game)
}
