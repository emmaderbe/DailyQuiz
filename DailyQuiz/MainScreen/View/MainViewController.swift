import UIKit

class MainViewController: UIViewController {
    private let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension MainViewController {
    func setupView() {
        setupText()
        mainView.showLoader(false)
        addBttn()
    }
    
    func setupText() {
        mainView.configureView(with: "Добро пожаловать в DailyQuiz!",
                               and: "Ошибка! Попробуйте ещё раз")
    }
    
    func addBttn() {
        mainView.onStartQuizTapped = { [weak self] in
              self?.startQuizFlow()
          }
    }
}

private extension MainViewController {
    func startQuizFlow() {
        mainView.errorHidden(true)
        mainView.showLoader(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            let success = Bool.random()
            self.mainView.showLoader(false)

            if success {
                print("sucess")
            } else {
                self.mainView.errorHidden(false)
            }
        }
    }

}

