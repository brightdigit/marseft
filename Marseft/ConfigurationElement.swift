//
//  ConfigurationElement.swift
//  TicTalkToc
//
//  Created by Leo G Dion on 1/23/15.
//  Copyright (c) 2015 BrightDigit. All rights reserved.
//

import Foundation

public struct ConfigurationElement : ConfigurationElementable {
  let element:AnyObject
	let keys:[String]?
  
  public var value:AnyObject {
    if let map = element as? [String: AnyObject], let keys = self.keys {
			for key in keys {
				if let child:AnyObject = map[key] {
					return child
				}
			}
    }
    return element
  }
  
  public var string: String? {
    return self.value as? String
  }
  
  public var int: Int? {
    return self.value as? Int
  }
  
  public var timeInterval: TimeInterval? {
    return self.value as? TimeInterval
  }
  
  public func bool (_ defaultValue: Bool) -> Bool {
    let boolValue = self.value as? Bool
    return boolValue ?? defaultValue
  }
  
  public subscript(key: String) -> ConfigurationElementable? {
    if let item: AnyObject = self.value[key] {
      return ConfigurationElement(element: item, keys: self.keys)
    } else {
      return nil
    }
  }
}
