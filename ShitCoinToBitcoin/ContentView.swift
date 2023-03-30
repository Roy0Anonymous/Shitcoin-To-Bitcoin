//
//  ContentView.swift
//  ShitCoinToBitcoin
//
//  Created by Rahul Roy on 29/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var coinManager = CoinManager()
    @State private var selectedCoin = "Ethereum"
    @State private var textFieldValue = ""
    @State var convertedValue: Double = 0.0
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Shit Coin to Bitcoin Convertor")
                .font(.title)
                .padding()
                .padding(.bottom, 30)
                .multilineTextAlignment(.center)
            HStack {
                ZStack {
                    Image("Cross")
                        .resizable()
                        .frame(width: 150, height: 150)
                    Image("TRX")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.bottom, 90)
                    
                    Image("DOGE")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 100)
                    
                    Image("BCD")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.top, 80)
                    
                    Image("SHIB")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.top, 60)
                        .padding(.trailing, 60)
                    
                    Image("DCN")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 100)
                    
                    Image("ETN")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.bottom, 80)
                        .padding(.leading, 60)
                    
                    Image("BTS")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 40)
                        .padding(.bottom, 40)
                }
                Spacer()
                Image("Convert")
                    .resizable()
                    .frame(width: 40, height: 40)
                Spacer()
                Image("BTC")
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            if let data = coinManager.data {
                Picker(selection: $selectedCoin, label: Text("")) {
                    Text("Get Rid of the Shit")
                    ForEach(data.data) { coin in
                        Text(coin.name).tag(coin.name)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                
                TextField("Enter the Amount", text: $textFieldValue)
                    .multilineTextAlignment(.center)
                    .frame(width: 150, height: 50, alignment: .center)
                    .padding(.bottom, 40)
                
                Button("Convert Your Shit Now") {
                    let currentSelection = data.data.firstIndex { currData in
                        return currData.name == selectedCoin
                    }
                    convertedValue = Double(textFieldValue)! * data.data[currentSelection!].quote.btc.price
                }
                .padding(.bottom, 60)
                Text("You'll get \(convertedValue) BTC after recycling your trash")
                    .multilineTextAlignment(.center)
            }
            

            
            Spacer()
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
