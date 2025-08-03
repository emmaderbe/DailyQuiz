import UIKit

protocol HistoryDelegateProtocol: AnyObject {
    func quizSelected(_ id: Int)
    func quizDeleted(_ id: Int)
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

extension HistoryDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        guard indexPath.item < items.count else { return nil }
        let id = items[indexPath.item].id

        return UIContextMenuConfiguration(
            identifier: id as NSNumber,
            previewProvider: nil) { [weak self] _ in
                let delete = UIAction(title: "Удалить",
                                      image: UIImage(systemName: "trash"),
                                      attributes: .destructive) { _ in
                    
                    self?.delegate?.quizDeleted(id)
                }
                return UIMenu(title: "", children: [delete])
            }
    }
}
