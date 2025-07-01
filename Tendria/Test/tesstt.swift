import SwiftUI
import Kingfisher

// MARK: – Schedule Screen (Week Navigation)
// ---------------------------------------------------------------------
/// • Curved white header card with large date & “Today” badge + calendar + week chevrons
/// • Horizontal drag gesture on header or week strip jumps whole weeks (±7 days)
/// • Slim week strip highlights selected date
/// • Time / Course row with sortable arrow
/// • Scrollable timeline with elegant rounded lesson cards
/// • Graphical DatePicker as bottom sheet
/// Replace `DemoData` with Firestore fetch when ready.
struct ScheduleScreen: View {
    // Selected day in the current week
    @State private var selectedDay: Date = .now
    // Sort order ▾ / ▴
    @State private var sortAscending = true
    // Lesson list (mock)
    @State var lectures: [EventDocumentModel]
    // Date‑picker sheet flag
    @State private var showPicker = false

    private let calendar = Calendar.current

    // Filter & sort for selected day (placeholder filter now)
    private var dayLectures: [EventDocumentModel] {
        lectures.sorted { sortAscending ? $0.startHour.dateValue() < $1.startHour.dateValue() : $0.startHour.dateValue() > $1.startHour.dateValue() }
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack(spacing: 24) {
                // Header card with gestures
                ScheduleHeaderContainer(selectedDay: $selectedDay,
                                         onCalendarTap: { showPicker = true },
                                         onChevronTap: moveWeek)
                .gesture(headerSwipe).fixedSize(horizontal: false, vertical: true)

                // Time / Course header row
                timelineHeader
                    .padding(.horizontal, 32)

                // Timeline list
                ScrollView{
                    VStack(alignment: .leading, spacing: 32) {
                        ForEach(dayLectures) { lec in
                            TimelineRow(item: lec) {
                                withAnimation { lectures.removeAll { $0.id == lec.id } }
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                }
            }
        }
        .ignoresSafeArea(.all, edges: .top)
        // Graphical DatePicker sheet
        .sheet(isPresented: $showPicker) {
            DatePicker(
                "Choose Date",
                selection: $selectedDay,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .presentationDetents([.medium])
            .padding()
        }
    }

    // MARK: Swipe gesture recogniser (±1 week)
    private var headerSwipe: some Gesture {
        DragGesture(minimumDistance: 24, coordinateSpace: .local)
            .onEnded { value in
                guard abs(value.translation.width) > abs(value.translation.height) else { return }
                if value.translation.width < 0 {
                    moveWeek(+1)
                } else {
                    moveWeek(-1)
                }
            }
    }

    // Moves selectedDay by whole weeks keeping same weekday index
    private func moveWeek(_ delta: Int) {
        if let newDate = calendar.date(byAdding: .day, value: 7 * delta, to: selectedDay) {
            withAnimation(.easeInOut) { selectedDay = newDate }
        }
    }

    // MARK: Timeline header row
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
            Button { withAnimation(.easeInOut) { sortAscending.toggle() } } label: {
                Image(systemName: sortAscending ? "arrow.down" : "arrow.up")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
            }
            .accessibilityLabel("Toggle sort order")
        }
    }
}

// MARK: – Header Card --------------------------------------------------------
struct ScheduleHeaderContainer: View {
    @Binding var selectedDay: Date
    var onCalendarTap: () -> Void
    var onChevronTap: (Int) -> Void // -1 left, +1 right
    private let calendar = Calendar.current

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)

            VStack(alignment: .leading, spacing: 24) {
                headerRow
                Divider().background(Color(.systemGray4))
                WeekStrip(selected: $selectedDay)
            }
            .padding(.horizontal, 32)
            .padding(.vertical,40)
        }
    }

    private var headerRow: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text(selectedDay, format: .dateTime.day())
                    .font(.system(size: 52, weight: .bold))
                Text(selectedDay, format: .dateTime.weekday())
                    .font(.headline)
                    .foregroundColor(.gray)
                Text(selectedDay, format: .dateTime.month(.abbreviated).year())
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if calendar.isDateInToday(selectedDay) {
                Text(StringKey.today)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.green)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 6)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color.green.opacity(0.15)))
            }

            Button(action: onCalendarTap) {
                Image(systemName: "calendar")
                    .font(.title3.weight(.semibold))
            }
            .buttonStyle(.plain)
            .padding(.leading, 4)
        }
    }
}

// MARK: – Week Strip ---------------------------------------------------------
struct WeekStrip: View {
    @Binding var selected: Date
    private let calendar = Calendar.current

    var body: some View {
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: selected))!

        HStack(spacing: 18) {
            ForEach(0..<7) { offset in
                let day = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
                let isSel = calendar.isDate(day, inSameDayAs: selected)

                VStack(spacing: 4) {
                    Text(day, format: .dateTime.day())
                        .font(.subheadline.weight(.semibold))
                    Text(day, format: .dateTime.weekday(.narrow))
                        .font(.caption2)
                }
                .frame(width: 36, height: 52)
                .background(isSel ? Color.orange : .clear, in: RoundedRectangle(cornerRadius: 12))
                .foregroundColor(isSel ? .white : .primary)
                .onTapGesture { selected = day }
            }
        }
    }
}

// MARK: – Timeline Row & Card -----------------------------------------------
struct TimelineRow: View {
    let item: EventDocumentModel
    let onDelete: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .trailing, spacing: 4) {
                Text(item.startText).font(.body.bold())
                Text(item.finishText).foregroundColor(.secondary)
            }
            .frame(width: 60)

            Rectangle().fill(Color(.systemGray4)).frame(width: 1)

            CourseCard(item: item, onDelete: onDelete)
        }
    }
}

struct CourseCard: View {
    let item: EventDocumentModel
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title).font(.headline.weight(.semibold))
            Text(item.comment).font(.subheadline).foregroundColor(.secondary)

            HStack(spacing: 6) {
                Image(systemName: "mappin.and.ellipse")
                Text(item.location)
            }
            .font(.footnote)
            .foregroundColor(.secondary)

            HStack(spacing: 6) {
                KFImage.profile(item.createrProfileImage, size: 18)
                    .clipShape(Circle())
                Text(item.createrName)
            }
            .font(.footnote)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: item.category?.colorHex ?? "000000").opacity(0.3), in: RoundedRectangle(cornerRadius: 24))
        .overlay(menu, alignment: .topTrailing)
    }

    private var menu: some View {
        Menu {
            Button(role: .destructive) { onDelete() } label: {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
                .padding(12)
                .foregroundStyle(.blue500)
        }
    }
}

// MARK: – Data Model + Mock --------------------------------------------------
struct Lecture: Identifiable, Equatable {
    let id = UUID()
    let startTime: String  // "HH:mm" demo – replace with Date
    let endTime: String
    let title: String
    let subtitle: String
    let room: String
    let lecturer: String
    let lecturerAvatar: String
    let color: Color
}

enum DemoData {
    static func courses(for _: Date) -> [Lecture] {
        [
            .init(startTime: "11:35", endTime: "13:05", title: "Mathematics", subtitle: "Chapter 1: Introduction", room: "Room 6‑205", lecturer: "Brooklyn Williamson", lecturerAvatar: "avatar1", color: Color.green),
            .init(startTime: "13:15", endTime: "14:45", title: "Biology", subtitle: "Chapter 3: Animal Kingdom", room: "Room 2‑168", lecturer: "Julie Watson", lecturerAvatar: "avatar2", color: Color(UIColor.systemGray6)),
            .init(startTime: "15:10", endTime: "16:40", title: "Geography", subtitle: "Chapter 2: Economy USA", room: "Room 1‑403", lecturer: "Jenny Alexander", lecturerAvatar: "avatar3", color: Color(UIColor.systemGray6))
        ]
    }
}

// MARK: – Preview ------------------------------------------------------------
#Preview {
    //ScheduleScreen()
}
