// swiftlint:disable nesting

import UIKit
import SurfUtils

extension SearchBar {

    public enum Constants {

        // MARK: Constants

        static let font: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let searchFieldCornerRadius: CGFloat = 10
        static let containerRightBigOffset: CGFloat = 91
        static let containerRightDefaultOffset: CGFloat = 4

        // MARK: Strings

        static let cancelTitle = L10n.Search.cancel

        // MARK: Colors

        public enum Colors {
            static let placeholder = Asset.Colors.action.color
            static let text = Asset.Colors.contrastAction.color
            static let searchField = Asset.Colors.contrastBackground.color
            static let cancelButton = Asset.Colors.action.color
            static let searchIcon = UIColor.black
            static let voiceIcon = Asset.Colors.action.color
            static let background = Asset.Colors.background.color
        }
    }

    // MARK: - Public Methods

    public func configure(cancelButton: CommonButton) {
        cancelButton.titleLabel?.font = Constants.font
        cancelButton.setTitleColor(Constants.Colors.cancelButton, for: .normal)
        cancelButton.setTitleColor(Constants.Colors.cancelButton.withAlphaComponent(0.5), for: .highlighted)
        cancelButton.setTitleColor(Constants.Colors.cancelButton.withAlphaComponent(0.5), for: [.highlighted, .selected])
        cancelButton.setBackgroundImage(UIImage(color: .clear), for: [.highlighted, .selected])
        cancelButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cancelButton.setTitleColor(Constants.Colors.placeholder, for: .disabled)
    }
}

// swiftlint:enable nesting
