import UIKit

struct BackgroundViewFactory {
    static func createBackView() -> UIView {
        let view = UIView()
        view.backgroundColor = AppColors.white
        view.layer.cornerRadius = 46
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func createSmallBackView() -> UIView {
        let view = UIView()
        view.backgroundColor = AppColors.white
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
