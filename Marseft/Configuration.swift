//
//  Configuration.swift
//  TicTalkToc
//
//  Created by Leo G Dion on 1/22/15.
//  Copyright (c) 2015 BrightDigit. All rights reserved.
//

import Foundation

public typealias Decipher = (string: String, error: NSErrorPointer) -> [String : AnyObject]?

public struct Configuration {
  let error:NSError?
  let data:[String:AnyObject]?
	let keys: [String]?
  
	public init (configuration: String, keys: [String]? = nil, decipher: Decipher? = nil) {
    var error: NSError? = nil
		let actualDecipher:Decipher
		if decipher != nil {
			actualDecipher = decipher!
		} else {
			actualDecipher = Configuration.decipher
		}
    self.data = actualDecipher(string: configuration, error: &error)
		self.keys = keys
    self.error = error != nil ? Error(innerError: error!) : nil
  }
	
  public subscript(key: String) -> ConfigurationElement? {
    if let item: AnyObject = self.data?[key] {
			return ConfigurationElement(element: item, keys: keys)
    } else {
      return nil
    }
  }
	
	
	static func decipher (string: String, error: NSErrorPointer) -> [String : AnyObject]? {
		if let data = NSData(base64EncodedString: string, options: NSDataBase64DecodingOptions.allZeros) {
			let str = NSString(data: data, encoding: NSUTF8StringEncoding)
			if let uncompressed = data.gunzippedData() {
				let str = NSString(data: uncompressed, encoding: NSUTF8StringEncoding)
				var jsonError:NSError? = nil
				if let jsonData = NSJSONSerialization.JSONObjectWithData(uncompressed, options: NSJSONReadingOptions.allZeros, error: &jsonError) as? [String : AnyObject] {
					return jsonData
				}
			} else {
				error.memory = Error(type: .Decompression)
				return nil
			}
		} else {
			error.memory = Error(type: .StringNSData)
			return nil
		}
		return nil
	}
}