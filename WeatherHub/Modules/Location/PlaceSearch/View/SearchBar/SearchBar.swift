import UIKit
import SurfUtils

public final class SearchBar: UIView {

    // MARK: - IBOutlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchIconImageView: UIImageView!
    @IBOutlet private weak var textField: SearchTextField!
    @IBOutlet private weak var clearButton: CommonButton!
    @IBOutlet private weak var cancelButton: CommonButton!
    @IBOutlet private weak var voiceButton: CommonButton!

    // MARK: - NSLayoutConstraints

    @IBOutlet private weak var containerRightConstraint: NSLayoutConstraint!

    // MARK: - Private Properties

    private var isVisibleCancelButton = false
    private var isVoiceSearchAvailable = false

    // MARK: - Public Properties

    public var onStartEditing: (() -> Void)?
    public var onEndEditing: (() -> Void)?
    public var onShouldReturn: (() -> Bool)?
    public var onTextChanged: ((String) -> Void)?
    public var onCancel: (() -> Void)?
    public var onVoice: (() -> Void)?

    public var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
            textFieldEditingChanged(textField)
        }
    }

    public var placeholder: String? {
        didSet {
            let color = Constants.Colors.placeholder
            textField.attributedPlaceholder = placeholder?.with(attributes: [
                .font(Constants.font),
                .foregroundColor(color)
            ])
        }
    }

    public var returnKeyType: UIReturnKeyType = .search {
        didSet {
            textField.returnKeyType = returnKeyType
        }
    }

    public var containerBackgroundColor: UIColor = Constants.Colors.searchField {
        didSet {
            containerView.backgroundColor = containerBackgroundColor
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        configureAppearance()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        configureAppearance()
    }

    // MARK: - UIView

    override public var intrinsicContentSize: CGSize {
      return UIView.layoutFittingExpandedSize
    }

    // MARK: - Public Methods

    public func makeFirstResponder() {
        textField.becomeFirstResponder()
    }

    public func changeCancelButonVisibility(isVisible: Bool, completionBlock: (() -> Void)? = nil) {
        guard isVisibleCancelButton != isVisible else {
            return
        }
        isVisibleCancelButton = isVisible
        animateCancelButonVisibility(isVisible: isVisibleCancelButton,
                                     completionBlock: completionBlock)
    }

    public func setVoiceSearch(available: Bool) {
        isVoiceSearchAvailable = available
        guard clearButton.alpha == 0 else {
            return
        }
        voiceButton.alpha = available ? 1 : 0
    }

}

// MARK: - Appearance

private extension SearchBar {

    func configureAppearance() {
        [self, subviews.first].forEach {
            $0?.backgroundColor = .clear
        }
        configureContainerView()
        configureSearchIcon()
        configureTextField()
        configureButtons()
        configureTapGesture()
    }

    func configureContainerView() {
        containerView.backgroundColor = containerBackgroundColor
        containerView.layer.cornerRadius = Constants.searchFieldCornerRadius
        containerView.clipsToBounds = true
    }

    func configureSearchIcon() {
        searchIconImageView.contentMode = .scaleAspectFit
        let image = UIImage(systemSymbol: .magnifyingglass).mask(with: Asset.Colors.action.color)
        searchIconImageView.image = image
    }

    func configureTextField() {
        textField.borderStyle = .none
        textField.font = Constants.font
        textField.textColor = Constants.Colors.text
        textField.tintColor = Constants.Colors.cancelButton
        textField.autocorrectionType = .no
        textField.returnKeyType = returnKeyType
        textField.addTarget(self,
                            action: #selector(textFieldEditingChanged(_:)),
                            for: .editingChanged)

        textField.onStartEditing = { [weak self] in
            self?.onStartEditing?()
        }
        textField.onEndEditing = { [weak self] in
            self?.onEndEditing?()
        }
        textField.onShouldReturn = { [weak self] in
            return self?.onShouldReturn?() ?? false
        }
    }

    func configureButtons() {
        clearButton.applyImageStyle(icon: UIImage(systemSymbol: .xmarkCircle).mask(with: Asset.Colors.action.color))
        clearButton.alpha = 0

        voiceButton.applyImageStyle(icon: UIImage(systemSymbol: .mic))
        voiceButton.alpha = isVoiceSearchAvailable ? 1 : 0

        configure(cancelButton: cancelButton)

        cancelButton.setTitle(Constants.cancelTitle, for: .normal)

        cancelButton.contentEdgeInsets = .zero
        cancelButton.alpha = 0
    }

    func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        containerView.addGestureRecognizer(tapGesture)
    }

}

// MARK: - Actions

private extension SearchBar {

    @objc
    func textFieldEditingChanged(_ textField: UITextField) {
        let isEmptyText = textField.text?.isEmpty ?? true
        animateClearButtonVisibility(isVisible: !isEmptyText)
        onTextChanged?(textField.text ?? "")
    }

    @IBAction private func clear(_ sender: UIButton) {
        textField.text = ""
        animateClearButtonVisibility(isVisible: false)
        onTextChanged?(textField.text ?? "")
    }

    @IBAction private func cancel(_ sender: UIButton) {
        onCancel?()
    }

    @IBAction private func voice(_ sender: UIButton) {
        onVoice?()
    }

    @objc
    func tapOnView() {
        textField.becomeFirstResponder()
    }

}

// MARK: - Animations

private extension SearchBar {

    func animateCancelButonVisibility(isVisible: Bool, completionBlock: (() -> Void)?) {
        let containerOffset = isVisibleCancelButton
            ? Constants.containerRightBigOffset
            : Constants.containerRightDefaultOffset
        let buttonAlpha: CGFloat = isVisibleCancelButton ? 1 : 0
        containerRightConstraint.constant = containerOffset

        UIView.animate(
            withDuration: 0.2,
            animations: { [weak self] in
                self?.layoutIfNeeded()
                self?.cancelButton.alpha = buttonAlpha
            },
            completion: { _ in
                completionBlock?()
            }
        )
    }

    func animateClearButtonVisibility(isVisible: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.clearButton.alpha = isVisible ? 1 : 0
            guard self.isVoiceSearchAvailable else {
                return
            }
            self.voiceButton.alpha = isVisible ? 0 : 1
        }
    }

}
