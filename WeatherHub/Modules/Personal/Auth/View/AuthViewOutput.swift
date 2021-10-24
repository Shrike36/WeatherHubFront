//
//  Copyright © 2021 Dmitry Demyanov. All rights reserved.
//

protocol AuthViewOutput {
    func viewLoaded()
    func performMainAction()
    func handlePasswordReset()
    func chooseAnotherAction()
}
