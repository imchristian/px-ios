//
//  MockBuilder.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 22/1/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import Foundation

class MockBuilder: NSObject {
    
    class func buildCheckoutPreference() -> CheckoutPreference {
        let preference = CheckoutPreference()
        preference._id = "xxx"
        preference.items = [self.buildItem("itemId", quantity: 1, unitPrice: 10), self.buildItem("itemId2", quantity: 2, unitPrice: 10)]
        preference.payer = self.buildPayer(1, type: "type")
        return preference
    }
    
    class func buildItem(id : String, quantity : Int, unitPrice : Double) -> Item {
        return Item(_id: id, title : "item title", quantity: quantity, unitPrice: unitPrice)
    }
    
    class func buildPayer(id : NSNumber, type : String) -> Payer {
        let payer =  Payer()
        payer._id = id
        payer.type = type
        return payer
    }
    
    class func buildPreferencePaymentMethods() -> PreferencePaymentMethods {
        let preferencePM = PreferencePaymentMethods()
        preferencePM.defaultInstallments = 1
        preferencePM.defaultPaymentMethodId = "visa"
        preferencePM.excludedPaymentMethods = ["amex"]
        preferencePM.excludedPaymentTypes = self.getMockPaymentTypeIds()
        return preferencePM
    }
    
    
    class func buildPaymentMethod(id : String) -> PaymentMethod {
        let paymentMethod = PaymentMethod()
        paymentMethod._id = id
        return paymentMethod
    }
    
    class func buildSecurityCode() -> SecurityCode {
        let securityCode = SecurityCode()
        securityCode.length = 3
        securityCode.mode = "mode"
        securityCode.cardLocation = "back"
        return securityCode
    }
    
    class func buildIdentification() -> Identification {
        let identification = Identification()
        identification.type = "type"
        identification.number = "number"
        return identification
    }
    
    class func buildCard() -> Card {
        let card = Card()
        card.idCard = 1234567890
        return card
    }
    
    
    class func buildPaymentMethodSearchItem(paymentMethodId : String, type : PaymentMethodSearchItemType? = nil) -> PaymentMethodSearchItem{
        let paymentMethodSearchItem = PaymentMethodSearchItem()
        paymentMethodSearchItem.idPaymentMethodSearchItem = paymentMethodId
        if type != nil {
            paymentMethodSearchItem.type = type
        }
        return paymentMethodSearchItem
    }
    
    class func getMockPaymentMethods() -> [PaymentMethod] {
        return [self.buildPaymentMethod("amex"), self.buildPaymentMethod("oxxo")]
    }
    
    
    class func getMockPaymentTypeIds() -> Set<PaymentTypeId>{
        return Set([PaymentTypeId.BITCOIN, PaymentTypeId.ACCOUNT_MONEY])
    }
}