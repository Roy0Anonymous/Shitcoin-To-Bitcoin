//
//  CoinModel.swift
//  CoinModel
//
//  Created by Rahul Roy on 29/03/23.
//

import Foundation

// MARK: - CoinsModel
struct CoinsModel: Codable {
    let status: Status
    var data: [Datum]
}

// MARK: - Datum
struct Datum: Codable, Identifiable {
    let id: Int
    let name, symbol, slug: String
    let numMarketPairs: Int
    let dateAdded: String
    let tags: [String]
    let maxSupply: Int?
    let circulatingSupply, totalSupply: Double
    let platform: Platform?
    let cmcRank: Int
    let selfReportedCirculatingSupply, selfReportedMarketCap, tvlRatio: Double?
    let lastUpdated: String
    let quote: Quote

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case numMarketPairs = "num_market_pairs"
        case dateAdded = "date_added"
        case tags
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case platform
        case cmcRank = "cmc_rank"
        case selfReportedCirculatingSupply = "self_reported_circulating_supply"
        case selfReportedMarketCap = "self_reported_market_cap"
        case tvlRatio = "tvl_ratio"
        case lastUpdated = "last_updated"
        case quote
    }
}

// MARK: - Platform
struct Platform: Codable {
    let id: Int
    let name: Name
    let symbol: Symbol
    let slug: Slug
    let tokenAddress: String

    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case tokenAddress = "token_address"
    }
}

enum Name: String, Codable {
    case aptos = "Aptos"
    case arbitrum = "Arbitrum"
    case bnb = "BNB"
    case ethereum = "Ethereum"
    case optimism = "Optimism"
    case tron = "TRON"
}

enum Slug: String, Codable {
    case aptos = "aptos"
    case arbitrum = "arbitrum"
    case bnb = "bnb"
    case ethereum = "ethereum"
    case optimismEthereum = "optimism-ethereum"
    case tron = "tron"
}

enum Symbol: String, Codable {
    case apt = "APT"
    case arb = "ARB"
    case bnb = "BNB"
    case eth = "ETH"
    case op = "OP"
    case trx = "TRX"
}

// MARK: - Quote
struct Quote: Codable {
    let btc: Btc

    enum CodingKeys: String, CodingKey {
        case btc = "BTC"
    }
}

// MARK: - Btc
struct Btc: Codable {
    let price, volume24H, volumeChange24H, percentChange1H: Double
    let percentChange24H, percentChange7D, percentChange30D, percentChange60D: Double
    let percentChange90D, marketCap, marketCapDominance, fullyDilutedMarketCap: Double
    let tvl: Double?
    let lastUpdated: String

    enum CodingKeys: String, CodingKey {
        case price
        case volume24H = "volume_24h"
        case volumeChange24H = "volume_change_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange24H = "percent_change_24h"
        case percentChange7D = "percent_change_7d"
        case percentChange30D = "percent_change_30d"
        case percentChange60D = "percent_change_60d"
        case percentChange90D = "percent_change_90d"
        case marketCap = "market_cap"
        case marketCapDominance = "market_cap_dominance"
        case fullyDilutedMarketCap = "fully_diluted_market_cap"
        case tvl
        case lastUpdated = "last_updated"
    }
}

// MARK: - Status
struct Status: Codable {
    let timestamp: String
    let errorCode: Int
    let errorMessage: JSONNull?
    let elapsed, creditCount: Int
//    let notice: JSONNull?
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case timestamp
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case elapsed
        case creditCount = "credit_count"
//        case notice
        case totalCount = "total_count"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
