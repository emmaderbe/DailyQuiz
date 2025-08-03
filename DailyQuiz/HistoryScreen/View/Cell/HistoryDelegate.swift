import UIKit

protocol HistoryDelegateProtocol: AnyObject {
    func quizSelected(_ id: Int)
}

final class HistoryDelegate: NSObject, UICollectionViewDelegate {
    private var items: [QuizResultModel] = []
    weak var delegate: HistoryDelegateProtocol?
}

extension HistoryDelegate {
    func updateItems(_ items: [QuizResultModel]) {
        self.items = items
    }
}

extension HistoryDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item < items.count else { return }
        let selectedItem = items[indexPath.item]
        delegate?.quizSelected(selectedItem.id)
    }
}
