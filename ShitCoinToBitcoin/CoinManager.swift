//
//  CoinManager.swift
//  ShitCoinToBitcoin
//
//  Created by Rahul Roy on 29/03/23.
//

import Foundation

class CoinManager: ObservableObject {
    init() {
        fetchData()
    }
    
    @Published var data: CoinsModel?

    func fetchData() {
        let urlString = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
        let api = "8484ca59-40e1-4527-973d-96b714fc5199"
        
        guard let url = URL(string: urlString) else { return }
        let parameters: [URLQueryItem] = [URLQueryItem(name: "start", value: "1"), URLQueryItem(name: "limit", value: "100"), URLQueryItem(name: "convert", value: "BTC")]
        let urlWithParams = url.appending(queryItems: parameters)
        var request = URLRequest(url: urlWithParams)
        request.setValue(api, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            if let response = response as? HTTPURLResponse {
                debugPrint(response.statusCode)
            }
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(CoinsModel.self, from: data)
                DispatchQueue.main.async {
                    self.data = decodedData
                    self.data?.data.remove(at: 0)
                    print("Try")
//                    print(self.data?.data[0].quote.btc)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}
