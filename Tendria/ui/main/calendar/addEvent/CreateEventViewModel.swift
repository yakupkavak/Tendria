//
//  HistoryViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import Foundation
import SwiftUICore

class CreateEventViewModel: BaseViewModel{
    
    @Published var dateList = [EventDateModel]()
    @Published var selectDate = Date(){
        didSet {
            print("date changed \(selectDate)")
            onDateChanged()
        }
    }
    
    @Published var startHour: Date = {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = 12
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    @Published var finishHour: Date = {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = 14
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    @Published var categories = [CategoryModel]()
    @Published var selectedCategory: CategoryModel? = nil
    @Published var titleInput = ""
    @Published var commentInput = ""
    @Published var newCategoryName = ""
    @Published var newCategoryColor = Color.blue
    @Published var success = false
    @Published var loading = false
    @Published var error = ""
    @Published var tenMinuteSelected = false
    @Published var savedPalette: [Color] = []
    
    private let categoryKey = CalendarConstants.CATEGORYKEY
    
    override init() {
        super.init()
        let today = Date()
        self.dateList = generateDateList(startDate: today)
        loadSavedCategories()
    }
    
    private func generateDateList(startDate: Date) -> [EventDateModel]{
        var dateList = [EventDateModel]()
        let calendar = Calendar.current
        for i in 0...2{
            guard let newDate = calendar.date(byAdding: .day, value: i, to: startDate) else { continue }
            let weekIndex = calendar.component(.weekday, from: newDate) - 1
            let day = calendar.component(.day, from: newDate)
            let eventModel = EventDateModel(number: String(day), text: getLocalizedString(Tables.days[weekIndex]))
            dateList.append(eventModel)
        }
        dateList.append(EventDateModel(number: getLocalizedString(StringKey.other), text: getLocalizedString(StringKey.date)))
        return dateList
    }
    
    func onDateChanged() {
        self.dateList = generateDateList(startDate: selectDate)
    }
    
    func addCategoryFromInput() {
        let hex = newCategoryColor.toHex() ?? "#000000"
        let newCategory = CategoryModel(colorHex: hex, name: newCategoryName)
        addCategory(category: newCategory)
        clearCategoryInput()
    }
    
    func addCategory(category: CategoryModel) {
        categories.append(category)
        selectedCategory = category
        saveCategoriesToUserDefaults()
    }
    
    func clearCategoryInput() {
        newCategoryName = ""
        newCategoryColor = .blue
    }
    
    private func saveCategoriesToUserDefaults() {
        let encoded = try? JSONEncoder().encode(categories)
        UserDefaults.standard.set(encoded, forKey: categoryKey)
    }
    
    private func loadSavedCategories() {
        guard let data = UserDefaults.standard.data(forKey: categoryKey),
              let decoded = try? JSONDecoder().decode([CategoryModel].self, from: data) else { return }
        categories = decoded
    }
    
    func saveEvent(){
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.hour, .minute], from: startHour)
        let finishComponents = calendar.dateComponents([.hour, .minute], from: finishHour)
        
        if startComponents.hour == finishComponents.hour &&
            startComponents.minute == finishComponents.minute {
            self.error = getLocalizedString(StringKey.sameTimeError) // ← Localized key
            return
        }
    }
}
