//
//  JWTHeader.swift
//  SwiftyJWT
//
//  Created by Shuo Wang on 2018/1/17.
//  Copyright © 2018年 Yufu. All rights reserved.
//

import Foundation

public struct JWTHeader: Codable {
    // Registered Claim Names
    // alg
    public var algorithm: String?
    // typ
    public var type: String = "JOSE"
    // kid
    public var keyId: String?
    
    public var jku: String?
    
    public init(keyId: String? = nil, jku: String? = nil) {
        self.keyId = keyId
        self.jku = jku
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicKey.self)
        algorithm = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.algorithm.rawValue))
        keyId = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.keyId.rawValue))
        if let type = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.type.rawValue)) {
    			self.type = type
    		}
        jku = try container.decodeIfPresent(String.self, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.jku.rawValue))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicKey.self)
        try container.encodeIfPresent(algorithm, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.algorithm.rawValue))
        try container.encodeIfPresent(keyId, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.keyId.rawValue))
        try container.encodeIfPresent(type, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.type.rawValue))
        try container.encodeIfPresent(jku, forKey: DynamicKey(stringValue: JWTHeaderCodingKeys.jku.rawValue))
    }

    enum JWTHeaderCodingKeys: String {
        case algorithm = "alg"
        case keyId = "kid"
        case type = "typ"
        case jku = "jku"
    }
}
