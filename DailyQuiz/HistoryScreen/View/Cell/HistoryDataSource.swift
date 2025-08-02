import UIKit

final class HistoryDataSource: NSObject, UICollectionViewDataSource {
    private var results: [QuizResultModel] = []
}

extension HistoryDataSource {
    func updateResults(_ results: [QuizResultModel]) {
            self.results = results
        }
}

//MARK: - numberOfItemsInSection
extension HistoryDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
}

//MARK: - cellForItemAt
extension HistoryDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as?  HistoryCell else { return UICollectionViewCell() }
        let result = results[indexPath.row]
        cell.configure(with: result)
        return cell
    }
}
