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
  let general:GeneralSettings
  let error:NSError? = nil
  let data:[String:AnyObject]?
  
	public init (keys: , decipher: Decipher) {
    var error: NSError? = nil
    self.general = GeneralSettings(debug: debug, edition: edition)
    self.data = decipher(string: _applicationInfo, error: &error)
    self.error = error != nil ? Error(innerError: error!) : nil
  }
  
  public subscript(key: String) -> ConfigurationElement? {
    if let item: AnyObject = self.data?[key] {
      return ConfigurationElement(element: item, general: general)
    } else {
      return nil
    }
  }
}