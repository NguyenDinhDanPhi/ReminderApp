//
//  ViewController.swift
//  Reminder
//
//  Created by dan phi on 23/07/2024.
//

import UIKit

class ReminderViewController: UIViewController {
    
    
    let datePicker = UIDatePicker()
      let setReminderButton = UIButton()

      override func viewDidLoad() {
          super.viewDidLoad()

          view.backgroundColor = .white

          // Setup DatePicker
          datePicker.datePickerMode = .dateAndTime
          datePicker.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(datePicker)

          // Setup Button
          setReminderButton.setTitle("Set Reminder", for: .normal)
          setReminderButton.backgroundColor = .systemBlue
          setReminderButton.translatesAutoresizingMaskIntoConstraints = false
          setReminderButton.addTarget(self, action: #selector(scheduleNotification), for: .touchUpInside)
          view.addSubview(setReminderButton)

          // Constraints
          NSLayoutConstraint.activate([
              datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),

              setReminderButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
              setReminderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              setReminderButton.widthAnchor.constraint(equalToConstant: 200),
              setReminderButton.heightAnchor.constraint(equalToConstant: 50)
          ])
      }

      @objc func scheduleNotification() {
          let content = UNMutableNotificationContent()
          content.title = "Daily Reminder"
          content.body = "This is your daily reminder."
          content.sound = .default

          let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: datePicker.date)
          let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) // Set repeats to false

          // Unique identifier for the notification request
          let identifier = "dailyReminder"

          // Cancel any existing notifications with the same identifier
          UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])

          let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

          UNUserNotificationCenter.current().add(request) { error in
              if let error = error {
                  print("Error: \(error.localizedDescription)")
              } else {
                  print("Notification scheduled")
              }
          }
      }
}

