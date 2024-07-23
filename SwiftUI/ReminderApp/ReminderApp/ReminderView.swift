//
//  ContentView.swift
//  ReminderApp
//
//  Created by dan phi on 23/07/2024.
//

import SwiftUI

struct ReminderView: View {
    @State private var reminderTime = Date()

    var body: some View {
        VStack {
            DatePicker("Chọn thời gian nhắc nhở", selection: $reminderTime)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()

            Button(action: scheduleNotification) {
                Text("Đặt nhắc nhở")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Nhắc nhở"
        content.body = "Đây là nhắc nhở của bạn."
        content.sound = .default

        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: reminderTime)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
#Preview {
    ReminderView()
}
