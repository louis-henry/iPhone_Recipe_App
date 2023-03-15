import UIKit

class BaseViewController: UIViewController {

    var navigationTitle: String = ""

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !navigationTitle.isEmpty {
            navigationItem.title = navigationTitle
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationTitle = navigationItem.title ?? ""
        navigationItem.title = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        guard let navigationController = navigationController else {
            return
        }
        if navigationController.viewControllers.count > 1 {
            self.setupCustomBackButton()
        }
    }

    func setupCustomBackButton(isDismiss: Bool = false) {
        if navigationController != nil {
            if isDismiss {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back_black"), style: .plain, target: self, action: #selector(self.dismissCurrentViewController))
            } else {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back_black"), style: .plain, target: self, action: #selector(self.popCurrentViewController))
            }
            self.navigationItem.hidesBackButton = true
        }
    }

    // MARK: Actions
    @objc func popCurrentViewController() {
        navigationController?.popViewController(animated: true)
    }

    @objc func dismissCurrentViewController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}
