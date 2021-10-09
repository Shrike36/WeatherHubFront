//
//  SearchResultCellTableViewCell.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 08.10.2021.
//

import UIKit
import ReactiveDataDisplayManager

class SearchResultCellTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = Asset.Colors.contrastBackground.color
        containerView.layer.cornerRadius = 10
//        containerView.layer.masksToBounds = true
        containerView.layer.shadowColor = Asset.Colors.border.color.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        containerView.layer.shadowRadius = 3
//        contentView.layer.shadowOpacity
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SearchResultCellTableViewCell: ConfigurableItem {

    func configure(with model: SearchResult) {
        cityLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }

}
