//
//  PlaceTableViewCell.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 08.10.2021.
//

import UIKit
import ReactiveDataDisplayManager

class PlaceTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = Asset.Colors.contrastBackground.color
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PlaceTableViewCell: ConfigurableItem {

    func configure(with model: PlaceViewModel) {
        cityLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }

}
