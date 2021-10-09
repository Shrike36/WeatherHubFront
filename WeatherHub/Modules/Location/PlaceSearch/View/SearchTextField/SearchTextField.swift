import UIKit

final class SearchTextField: UITextField {

    // MARK: - Properties

    var onStartEditing: (() -> Void)?
    var onEndEditing: (() -> Void)?
    var onShouldReturn: (() -> Bool)?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }

}

// MARK: - UITextFieldDelegate

extension SearchTextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        onStartEditing?()
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        onEndEditing?()
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return onShouldReturn?() ?? false
    }

}
