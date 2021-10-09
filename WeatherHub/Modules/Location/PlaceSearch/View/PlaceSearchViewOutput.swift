//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol PlaceSearchViewOutput {
    func viewLoaded()
    func inputChanged(text: String)
    func resultSelected(at index: Int)
}
