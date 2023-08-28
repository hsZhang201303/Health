//
//  ContentView.swift
//  MyHealth
//
//  Created by zhs on 2023/7/6.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State var started = 0
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
//            TextField.init(text: "please input timeInterval") {
//                NSLog("inputed == %@", text)
//            }
            Button("Started: \(started)") {
                if self.started != 1 {
                    StartAlert(timeInterVal: TimeInterval(integerLiteral: 60 * 50))
                }
            }
    
        }
        .padding()
    }
    
    //time interval must be at least 60 if repeating
    func StartAlert(timeInterVal:TimeInterval) -> Void {
        print("==StartAlert==")
        self.started = 1
        UNUserNotificationCenter.current().requestAuthorization { granted, err in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Tips"
                content.body = "Time For Get Up!!!"
                content.sound = UNNotificationSound.default
                
                //time interval must be at least 60 if repeating
                let aTrigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterVal, repeats: true)
                
                let request = UNNotificationRequest(identifier: "Health", content: content, trigger: aTrigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
