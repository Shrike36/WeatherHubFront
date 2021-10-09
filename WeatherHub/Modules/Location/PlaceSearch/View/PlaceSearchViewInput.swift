//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol PlaceSearchViewInput: AnyObject {
    func setupInitialState()
    func fillResults(_ results: [SearchResult])
}
