//
//  MPXTracker.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 6/1/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import UIKit

/*
protocol MPXTracker {
    static var mpxPublicKey: String {get}
    static var mpxCheckoutVersion: String {get}
    static var mpxPlatform: String {get}
    static var mpxSiteId: String {get}
    static var mpxPlatformType: String {get}
}
*/

class MPXTracker {

    static let sharedInstance = MPXTracker()

    var trackingStrategy: TrackingStrategy = PersistAndTrack()

    static func trackScreen(screenId: String, screenName: String) {
        let screenTrack = ScreenTrackInfo(screenName: screenName, screenId: screenId)
        sharedInstance.trackingStrategy.trackScreen(screenTrack: screenTrack)
    }

    static func generateJSONDefault() -> [String:Any] {
        let clientId = UIDevice.current.identifierForVendor!.uuidString
        let deviceJSON = MPTDevice().toJSON()
        let applicationJSON = MPTApplication(publicKey: MercadoPagoContext.sharedInstance.publicKey(), checkoutVersion: MercadoPagoContext.sharedInstance.sdkVersion(), platform: MercadoPagoContext.platformType).toJSON()
        let obj: [String:Any] = [
            "client_id": clientId,
            "application": applicationJSON,
            "device": deviceJSON,
            ]
        return obj
    }
    static func generateJSONScreen(screenId: String, screenName: String) -> [String:Any] {
        var obj = generateJSONDefault()
        let screenJSON = MPXTracker.screenJSON(screenId: screenId, screenName: screenName)
        obj["events"] = [screenJSON]
        return obj
    }
    static func generateJSONEvent(screenId: String, screenName: String, action: String, category: String, label: String, value: String) -> [String:Any] {
        var obj = generateJSONDefault()
        let eventJSON = MPXTracker.eventJSON(screenId: screenId, screenName: screenName, action: action, category: category, label: label, value: value)
        obj["events"] = [eventJSON]
        return obj
    }
    static func eventJSON(screenId: String, screenName: String, action: String, category: String, label: String, value: String) -> [String:Any] {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let timestamp = formatter.string(from: date).replacingOccurrences(of: " ", with: "T")
        let obj: [String:Any] = [
            "timestamp": timestamp,
            "type": "action",
            "screen_id": screenId,
            "screen_name": screenName,
            "action": action,
            "category": category,
            "label": label,
            "value": value
        ]
        return obj
    }
    static func screenJSON(screenId: String, screenName: String) -> [String:Any] {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let timestamp = formatter.string(from: date).replacingOccurrences(of: " ", with: "T")
        let obj: [String:Any] = [
            "timestamp": timestamp,
            "type": "screenview",
            "screen_id": screenId,
            "screen_name": screenName
        ]
        return obj
    }
}
