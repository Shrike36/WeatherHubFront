//
//  DateCollecttionCell.swift
//  WeatherHub
//
//  Created by Дмитрий Демьянов on 23.05.2021.
//

import UIKit
import ReactiveDataDisplayManager

class DateCollecttionCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 15
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Private properties

    private lazy var ddm = tableView.rddm.baseBuilder
        .build()

    // MARK: - UICollectionViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        ddm.clearCellGenerators()
        ddm.forceRefill()
    }

}

extension DateCollecttionCell: ConfigurableItem {

    func configure(with model: DateViewModel) {
        for weatherInfoModel in model.weather {
            let generator = CalculatableHeightCellGenerator<WeatherInfoCell>(with: weatherInfoModel)
            ddm.addCellGenerator(generator)
        }
        ddm.forceRefill()
    }

}

private extension DateCollecttionCell {

    func configureAppearance() {
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.clipsToBounds = true
        configureTable()
    }

    func configureTable() {
        tableView.backgroundColor = Asset.Colors.contrastBackground.color
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

}
