//
//  NotificationService.swift
//  CalendarMemo
//
//  Created by 이가을 on 12/21/24.
//

import UserNotifications

struct NotificationService {
    
    var notiCenter = UNUserNotificationCenter.current()
    
    /// 알림 설정
    func setNotification(memo: Memo)  {
        if memo.notificatoinType == .noNoti {
            return
        }
        
        // Requests a person’s authorization to allow local and remote notifications for your app.
        notiCenter.requestAuthorization(options: [.alert]) { granted, _ in
            if granted { // 사용자에게 알림 허용을 받았으면
                // The editable content for a notification.
                let content = UNMutableNotificationContent()
                content.title = memo.title
                switch memo.notificatoinType {
                case .onTheDay:
                    content.body = "작성한 일정이 오늘입니다."
                case .aDayBefore:
                    content.body = "작성한 일정이 내일입니다."
                case .twoDaysBefore:
                    content.body = "작성한 일정이 이틀 후입니다."
                default:
                    content.body = ""
                }
                
                var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: memo.date)
                dateComponents.hour = 09
                dateComponents.minute = 00
                
                
                // A trigger condition that causes the system to deliver a notification after the amount of time you specify elapses.
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                // A request to schedule a local notification, which includes the content of the notification and the trigger conditions for delivery.
                let request = UNNotificationRequest(
                    identifier: memo.id,
                    content: content,
                    trigger: trigger
                )
                print("setNotification -> \(request.identifier)")
                
                notiCenter.add(request) // Schedules the delivery of a local notification.
            }
        }
    }
    
    ///  특정 알림이 존재하는지 확인
    func findPendingNotification(id: String) -> Bool {
        var result = false
        print("findPendingNotification with: \(id)")
        notiCenter.getPendingNotificationRequests { requests in
            for request in requests {
                if request.identifier == id {
                    result = true
                    print("\(request.identifier) -> 알림 존재")
                }
            }
        }
        
        return result
    }
    
    func test() {
        notiCenter.getPendingNotificationRequests { requests in
            for request in requests {
                print("requests identifier -> \(request.identifier)")
            }
        }
    }
    
    /// 대기 중인 알람 삭제
    func removePendingNotification(identifier: String){
        let arr = [ "\(identifier)" ]
        notiCenter.removePendingNotificationRequests(withIdentifiers: arr)
        print("\(identifier) -> 알림 삭제 완료")
    }

    /// 전달된 알람 삭제
    func removeDeliveredNotification(identifiers: [String]){
        notiCenter.removeDeliveredNotifications(withIdentifiers: identifiers)
    }
}
