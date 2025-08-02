import Foundation

struct QuizResultModel {
    let title: String
    let date: Date
    let stars: Int
}

extension QuizResultModel {
    var formateDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: date)
    }
    
    var formateTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
