//
//  HistoryUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct CalendarUI: View {
    @StateObject private var viewModel = CalendarViewModel()
    @State private var showPicker = false
    
    var body: some View {
            VStack(spacing: 24) {
                // Header
                ScheduleHeaderContainer(selectedDay: $viewModel.selectedDay,
                                        onCalendarTap: { showPicker = true },
                                        onChevronTap: viewModel.moveWeek)
                    .gesture(headerSwipe)
                    .fixedSize(horizontal: false, vertical: true)   // ← sabit yükseklik
                
                // Timeline başlığı
                timelineHeader
                    .padding(.horizontal, 32)
                
                // ScrollView kalan alanı tek başına alır
                ZStack(alignment: .bottomTrailing){
                    ScrollView {
                        VStack(alignment: .leading, spacing: 32) {
                            ForEach(viewModel.dayEvents) { evt in
                                TimelineRow(item: evt) {
                                    withAnimation { viewModel.delete(evt) }
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                    .frame(maxHeight: .infinity)
                    btnAddIcon(iconName: "plus") {
                        print("")
                    }.padding(.trailing,24)
                }
            }
        .ignoresSafeArea(.all, edges: .top)
        .sheet(isPresented: $showPicker) { datePicker }
    }
    
    private var headerSwipe: some Gesture {
        DragGesture(minimumDistance: 24)
            .onEnded { v in
                guard abs(v.translation.width) > abs(v.translation.height) else { return }
                viewModel.moveWeek(by: v.translation.width < 0 ? +1 : -1)
            }
    }
    
    // Timeline Header (binding yok, VM fonksiyonunu çağırıyor)
    private var timelineHeader: some View {
        HStack(spacing: 12) {
            Text(StringKey.time)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.secondary)
                .frame(width: 60, alignment: .trailing)
            Text(StringKey.event)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.secondary)
            Spacer()
            Button { withAnimation { viewModel.toggleSort() } } label: {
                Image(systemName: viewModel.sortAscending ? "arrow.down" : "arrow.up")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var datePicker: some View {
        DatePicker("Choose Date",
                   selection: $viewModel.selectedDay,
                   displayedComponents: [.date])
            .datePickerStyle(.graphical)
            .presentationDetents([.medium])
            .padding()
    }
}

#Preview {
    CalendarUI()
}
