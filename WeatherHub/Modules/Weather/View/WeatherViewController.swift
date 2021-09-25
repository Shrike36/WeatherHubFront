//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

import UIKit
import ReactiveDataDisplayManager
import SurfUtils

final class WeatherViewController: UIViewController {

    // MARK: - Constants

    private enum Constants {
        static let addedTouchRadius: CGFloat = 7

        static let dateCellHorizontalInset: CGFloat = 16
        static let dateCellVerticalInset: CGFloat = 16
        static let dateCellInsets = UIEdgeInsets(top: dateCellVerticalInset,
                                                 left: dateCellHorizontalInset,
                                                 bottom: dateCellVerticalInset,
                                                 right: dateCellHorizontalInset)
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var heartButton: CommonButton!

    @IBOutlet private weak var prevDateButton: CommonButton!
    @IBOutlet private weak var nextDateButton: CommonButton!
    @IBOutlet private weak var dateLabel: UILabel!

    @IBOutlet private weak var datesCollectionView: UICollectionView!

    // MARK: - Properties

    var output: WeatherViewOutput?

    // MARK: - Private properties

    private lazy var ddm = datesCollectionView.rddm.baseBuilder
        .add(plugin: .scrollableBehaviour(scrollProvider: self))
        .build()

    private var dateCellSize: CGSize {
        return .init(width: datesCollectionView.bounds.width - 2 * Constants.dateCellHorizontalInset,
                     height: datesCollectionView.bounds.height - 2 * Constants.dateCellVerticalInset)
    }

    private lazy var scrollManager = ItemsScrollManager(cellWidth: dateCellSize.width,
                                                        cellOffset: Constants.dateCellHorizontalInset,
                                                        insets: Constants.dateCellInsets)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.layoutFinished()
    }

}

// MARK: - WeatherViewInput

extension WeatherViewController: WeatherViewInput {

    func setupInitialState() {
        configureAppearance()
        configureCityLabel()
        configureHeartButton()
        configureDateLabel()
        configurePrevDateButton()
        configureNextDateButton()
    }

    func configure(with model: WeatherScreenViewModel) {
        cityLabel.text = model.cityName
        setDateText(model.dates.first!.date)
        configureCollection()
        fillCollection(with: model.dates)
    }

    func setDateChangeButtonsVisisble(left leftVisible: Bool, right rightVisible: Bool) {
        prevDateButton.alpha = leftVisible ? 1 : 0
        prevDateButton.isUserInteractionEnabled = leftVisible
        nextDateButton.alpha = rightVisible ? 1 : 0
        nextDateButton.isUserInteractionEnabled = rightVisible
    }

    func setDateScrollIndex(_ index: Int) {
        datesCollectionView.scrollToItem(at: IndexPath(item: index, section: 0),
                                         at: .centeredHorizontally,
                                         animated: true)
    }

    func setDateText(_ date: Date) {
        dateLabel.text = DateStringBuilder().buildString(for: date, withDayName: true)
    }

}

// MARK: - CollectionScrollProvider

extension WeatherViewController: CollectionScrollProvider {

    func setBeginDraggingOffset(_ contentOffsetX: CGFloat) {
        scrollManager.setBeginDraggingOffset(contentOffsetX)
    }

    func setTargetContentOffset(_ targetContentOffset: UnsafeMutablePointer<CGPoint>, for scrollView: UIScrollView) {
        scrollManager.setTargetContentOffset(targetContentOffset, for: scrollView)
        let currentIndex = targetContentOffset.pointee.x / (datesCollectionView.bounds.width - Constants.dateCellHorizontalInset)
        output?.scrolledToIndex(Int(currentIndex))
    }

}

// MARK: - Appearance

private extension WeatherViewController {

    func configureAppearance() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = Asset.Colors.background.color
    }

    func configureCityLabel() {
        cityLabel.font = .systemFont(ofSize: 36, weight: .bold)
        cityLabel.adjustsFontSizeToFitWidth = true
        cityLabel.adjustsFontForContentSizeCategory = true
        cityLabel.textAlignment = .center
    }

    func configureDateLabel() {
        dateLabel.font = .systemFont(ofSize: 24, weight: .medium)
        dateLabel.textAlignment = .center
    }

    func configureHeartButton() {
        heartButton.addedTouchArea = Constants.addedTouchRadius
        heartButton.setTitleForAllState(nil)
        setFavoriteState(isSaved: true) // remove
    }

    func configurePrevDateButton() {
        prevDateButton.addedTouchArea = Constants.addedTouchRadius
        prevDateButton.setTitleForAllState(nil)
        prevDateButton.adjustsImageWhenHighlighted = false
        prevDateButton.setImage(Asset.Assets.left.image.withTintColor(Asset.Colors.contrastAction.color), for: .normal)
        prevDateButton.setImage(Asset.Assets.left.image.withTintColor(Asset.Colors.action.color), for: .highlighted)
    }

    func configureNextDateButton() {
        nextDateButton.addedTouchArea = Constants.addedTouchRadius
        nextDateButton.setTitleForAllState(nil)
        nextDateButton.adjustsImageWhenHighlighted = false
        nextDateButton.setImage(Asset.Assets.right.image.withTintColor(Asset.Colors.contrastAction.color), for: .normal)
        nextDateButton.setImage(Asset.Assets.right.image.withTintColor(Asset.Colors.action.color), for: .highlighted)
    }

    func configureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = dateCellSize
        layout.sectionInset = Constants.dateCellInsets
        layout.minimumLineSpacing = Constants.dateCellHorizontalInset

        datesCollectionView.collectionViewLayout = layout
        datesCollectionView.backgroundColor = .clear
        datesCollectionView.showsVerticalScrollIndicator = false
        datesCollectionView.showsHorizontalScrollIndicator = false
        datesCollectionView.decelerationRate = .fast
        datesCollectionView.contentInset = .zero
    }

}

// MARK: - Configuration

private extension WeatherViewController {

    func setFavoriteState(isSaved: Bool) {
        let buttonColor: UIColor = isSaved ? .red : .gray
        heartButton.setImage(Asset.Assets.heartFill.image.withTintColor(buttonColor), for: .normal)
    }

    func fillCollection(with models: [DateViewModel]) {
        for model in models {
            let generator = DateCollecttionCell.rddm.baseGenerator(with: model)
            ddm.addCellGenerator(generator)
        }
        ddm.forceRefill()
    }

}

// MARK: - Actions

private extension WeatherViewController {

    @IBAction func heartTapped(_ sender: Any) {
//        output
    }

    @IBAction func previousTapped(_ sender: Any) {
        output?.prevDateAsked()
    }

    @IBAction func nextTapped(_ sender: Any) {
        output?.nextDateAsked()
    }

}
