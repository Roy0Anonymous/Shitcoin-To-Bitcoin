//
//  ContentView.swift
//  ShitCoinToBitcoin
//
//  Created by Rahul Roy on 29/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var coinManager = CoinManager()
    @State private var selectedCoin = "Select a Coin"
    @State private var textFieldValue = ""
    @State private var resultText = "Please Select a Coin to Convert"
    @State private var convertedValue: String = "0.0"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Circle()
                .foregroundColor(.orange)
                .frame(width: 400, height: 400)
                .blur(radius: 100)
                .offset(x: 0, y: 275)
            VStack(alignment: .center, spacing: 0) {
                HeadingView(title: "Shitcoin to Bitcoin Convertor", subtitle: "Don't just flush your coins away")
                HStack {
                    ZStack {
                        Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "Cross")))
                            .resizable()
                            .frame(width: 150, height: 150)
                            .padding(.leading)
                            .shadow(color: .red.opacity(0.5), radius: 10, x: 2, y: 7)
                        Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "TRX")))
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.bottom, 90)

                        Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "DOGE")))
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 60)

                        Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "BCD")))
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.leading, 10)
                            .padding(.top, 80)

                        Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "SHIB")))
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.top, 60)
                            .padding(.trailing, 60)

                        Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "DCN")))
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.leading, 100)

                        Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "ETN")))
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.bottom, 80)
                            .padding(.leading, 60)

                        Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "BTS")))
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.leading, 40)
                            .padding(.bottom, 40)
                    }
                    Spacer()
                    Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "Convert")))
                        .resizable()
                        .frame(width: 40, height: 40)
                        .shadow(color: .blue.opacity(0.5), radius: 4, x: 2, y: 4)
                    Spacer()
                    Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "BTC")))
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding(.trailing)
                        .shadow(color: .orange.opacity(0.5), radius: 10, x: 2, y: 7)
                }

                if let data = coinManager.data {
                    Menu {
                        ForEach(data.data) { coin in
                            Button(coin.name) {
                                selectedCoin = coin.name
                            }
                        }
                    } label: {
                        Text(selectedCoin)
                            .padding(.trailing, 40)
                            .padding(.leading)
                            .frame(height: 30)
                            .padding(.trailing, 5)
                            .background(.orange.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(7)
                            .overlay (
                                ZStack(alignment: .trailing) {
                                    HStack {
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.white)
                                            .padding(.trailing)
                                    }
                                }
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .shadow(color: Color.orange, radius: 10, x: 5, y: 5)

                    ZStack {
                        TextField("", text: $textFieldValue)
                            .multilineTextAlignment(.center)
                            .frame(width: 150, height: 50, alignment: .center)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .shadow(color: .orange.opacity(0.5), radius: 15, x: 5, y: 5)
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                            .keyboardType(.decimalPad)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.orange, lineWidth: 2)
                            .shadow(color: Color.orange, radius: 10, x: 0, y: 5)
                            .frame(width: 150, height: 50, alignment: .center)
                            .padding(.bottom, 30)
                        if textFieldValue.isEmpty {
                            Text("Enter the Amount")
                                .frame(width: 150, height: 50, alignment: .center)
                                .foregroundColor(.gray.opacity(0.4))
                                .padding(.bottom, 30)
                                .allowsHitTesting(false)
                        }
                    }
                    Button(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        if selectedCoin == "Select a Coin" || textFieldValue.isEmpty {
                            return
                        }
                        let currentSelection = data.data.firstIndex { currData in
                            return currData.name == selectedCoin
                        }
                        let value = Double(textFieldValue)! * data.data[currentSelection!].quote.btc.price
                        convertedValue = String(format: "%.10f", value)
                        resultText = "You'll get \(convertedValue) BTC after recycling your trash"
                    }, label: {
                        Text("Get Bitcoins Now!")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                            .shadow(color: .orange.opacity(0.8), radius: 10, x: 5, y: 5)
                    })
                    .padding(.bottom, 20)
                    Spacer()
                    Text(resultText)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .padding(.horizontal)
                }
                Spacer()
                HStack() {
                    Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "SOB")))
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.bottom, 40)
                    Text("Summer of Bitcoin")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                        .padding(.trailing, 15)
                    Image(uiImage: compressImage(image: UIImage(imageLiteralResourceName: "BDK")))
                        .resizable()
                        .frame(width: 70, height: 20)
                        .padding(.bottom, 40)
                }
            }
            if coinManager.fetchingData {
                Color.black
                    .opacity(0.7)
                    .ignoresSafeArea()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .foregroundColor(.white)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HeadingView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.orange)
                .shadow(color: .orange.opacity(0.5), radius: 10, x: 2, y: 7)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .truncationMode(.tail)
                .padding(.top, 30)
            
            Text(subtitle)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}

func compressImage(image: UIImage) -> UIImage {
    let resizedImage = image.aspectFittedToHeight(200)
    
    return resizedImage
}

extension UIImage {
    func aspectFittedToHeight(_ newHeight: CGFloat) -> UIImage {
        let scale = newHeight / self.size.height
        let newWidth = self.size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
