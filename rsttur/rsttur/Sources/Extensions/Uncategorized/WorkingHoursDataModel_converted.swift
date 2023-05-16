import Foundation

// MARK: - Convert WorkingHoursDataModel to WorkingHoursItemModel

extension WorkingHoursDataModel {
    func convertedToItem() -> WorkingHoursItemModel {
        let shouldBeLocalized = [1: "Понедельник",
                                 2: "Вторник",
                                 3: "Среда",
                                 4: "Четверг",
                                 5: "Пятница",
                                 6: "Суббота",
                                 7: "Воскресенье"]
        return WorkingHoursItemModel(days: self.days.compactMap { shouldBeLocalized[$0 + 1] },
                                     available: "\(self.from) - \(self.to)")
    }
}
