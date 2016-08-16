//
//  Configuration.swift
//  TicTalkToc
//
//  Created by Leo G Dion on 1/22/15.
//  Copyright (c) 2015 BrightDigit. All rights reserved.
//

import Foundation

public typealias Decipher = (_ string: String) throws -> [String : AnyObject]?

public protocol ConfigurationElementLookup {
  subscript(key: String) -> ConfigurationElementable? { get }
}

public protocol ConfigurationElementable : ConfigurationElementLookup {
  var value:AnyObject { get }
  var string: String? { get }
  var int: Int? { get }
  var timeInterval: TimeInterval?  { get }
  func bool (_ defaultValue: Bool) -> Bool
}

public struct Configuration : ConfigurationElementLookup {
  let data:[String:AnyObject]?
	let keys: [String]?
  
	public init (configuration: String, keys: [String]? = nil, decipher: Decipher? = nil) throws {
		let actualDecipher:Decipher
		if decipher != nil {
			actualDecipher = decipher!
		} else {
			actualDecipher = Configuration.decipher
		}
    self.data = try actualDecipher(configuration)
		self.keys = keys
  }
	
  public subscript(key: String) -> ConfigurationElementable? {
    if let item: AnyObject = self.data?[key] {
			return ConfigurationElement(element: item, keys: keys)
    } else {
      return nil
    }
  }
	
	
	static func decipher (_ string: String) throws -> [String : AnyObject]? {
    
		if let data = NSData(base64Encoded: string) {
			if let uncompressed = data.gunzipped() {
        do {
          if let jsonData = try JSONSerialization.jsonObject(with: uncompressed, options: JSONSerialization.ReadingOptions()) as? [String : AnyObject] {
            return jsonData
          }
        } catch let error {
          throw MarseftError.deserialization(parent: error)
        }
			} else {
				throw MarseftError.decompression
			}
		} else {
			throw MarseftError.base64
		}
		return nil
	}
}
