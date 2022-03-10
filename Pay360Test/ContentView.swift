//
//  ContentView.swift
//  Pay360Test
//
//  Created by Lukasz on 10/03/2022.
//

import SwiftUI
import Foundation
import Pay360

struct ContentView: View {
    @State private var showDetails = false
    
    var installationId = "5309726";
    var clientToken = "eyJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2NDY5MDU5ODQsImV4cCI6MTY0NjkyMDM4NCwiYXVkIjoiY2xpZW50Iiwic3ViIjoiTzVLTEhOM0pXNUJVWE5UQjdGRlI3Tk8zQVUiLCJzY29wZSI6WyJNT0JJTEVfVFJBTlNBQ1RfSU5TVEFMTEFUSU9OIl0sImluc3RhbGxhdGlvbiI6IjUzMDk3MjYiLCJzZXNzaW9uSWQiOiI3YjAzMzg4Ny0xZmM2LTRiMDgtOTFkMy0xMTkwMDc5YTBkYmQifQ.muEWXQ0owRAGbC0793o2Ij-9wtlEStRY7ALS_-Vsnn3IrZwH6w9HJY00_M9cTjL0H58Pyh3VR9AINkMJGny9HAsCtNDUwZ7CX-QvxqD0nMV2oQBKGdYt0F205KSF-0KDgZvOmyYV-17vxHyTAyKneuzdSo8JCVb9VN8AX5wb-f4KFNotvBfsxnp9QWZSthggPiDZIL4LaOvkwSwxeluI7LcFwnDer6TXP0xB4DDonN5vZJIM2vvZ255Z1YWN9kXdfdgIEdF8v8moRkI_S6keNO3XtGrnfQ-wJSkJeMmnD1MYRe_7-BRfReP7SyM4yQ6v9yf4qYXKFTn3N3rZosfqbQ";
    
    var body: some View {
        VStack(alignment: .leading) {
                    Button("Make test payment") {
                        showDetails.toggle()
                        self.makeTestPayment()
                    }

                    if showDetails {
                        Text("Please wait...")
                            .font(.title)
                    }
                }
    }
    
    func makeTestPayment() {
      let transaction = PPOTransaction()
          transaction.currency = "GBP"
          transaction.amount = 100.0
          transaction.transactionDescription = "Sample Transaction"
          transaction.merchantRef = "Pay360 Test"
          transaction.isRecurring = "false"
          transaction.isDeferred = "false"
        

      
      let card = PPOCard()
      // card.pan = "9902000000005132"
      card.pan = "9903000000000017"
      card.cvv = "123"
      card.expiry = "0125"
      card.cardHolderName = "John Smith"
    
      
      let billingAddress = PPOBillingAddress()
      billingAddress.line1 = "159 Winterthur Way"
      billingAddress.city = "Basingstoke"
      billingAddress.region = "Hampshire"
      billingAddress.postcode = "RG21"
      billingAddress.countryCode = "GBR"

      
      //let financialService = PPOFinancialService()
      //financialService.dateOfBirth = "01011975"
      //financialService.surname = "Wolnik"
      //financialService.accountNumber = "123456"
      //financialService.postCode = "RG21"
      
      let customer = PPOCustomer()
      customer.email = "lukaszwolnik@gmail.com"
      customer.dateOfBirth = "01011975"
      customer.telephone = "07770111111"

      
      let credentials = PPOCredentials()
  //    var credentials = PPOCredentials(environment: self.clientToken, installationId: self.installationId, environment: PPOEnvironmentTesting)
  //    credentials = PPOCredentials.init(environment: self.clientToken, installationId: self.installationId, environment: PPOEnvironmentTesting)
      credentials.clientToken = self.clientToken
      credentials.environment = PPOEnvironmentTesting
      credentials.installationId = self.installationId
      
      let payment = PPOPayment()
      payment.credentials = credentials
      payment.transaction = transaction
      payment.card = card
      payment.address = billingAddress
      payment.customer = customer
      //payment.financialServices = financialService
      //payment.providerId = "AP"
        
        payment.processGuestPayment { (Data: PPOPaymentResponse) in
            print(Data.processing.result)
            print(Data.processing.status)
         } failure: { (error) in
         print(error)
         }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
