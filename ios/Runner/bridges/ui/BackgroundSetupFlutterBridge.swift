//
//  BackgroundSetupFlutterBridge.swift
//  Runner
//
//  Created by crc32 on 17/10/2021.
//

import Foundation

extension NSNotification.Name {
    static let abc = NSNotification.Name("abc")
}

class BackgroundSetupFlutterBridge: NSObject, BackgroundSetupControl {
    func setupBackgroundCallbackHandle(_ callbackHandle: NumberWrapper, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let persistentState = UserDefaults.standard
        persistentState.set(callbackHandle.value! as! Int64, forKey: "FlutterBackgroundHandle")

        NotificationCenter.default.post(name: .abc, object: nil)
    }
}
