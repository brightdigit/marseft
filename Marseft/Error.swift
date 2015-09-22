//
//  Errors.swift
//  TicTalkToc
//
//  Created by Leo G Dion on 2/13/15.
//  Copyright (c) 2015 BrightDigit. All rights reserved.
//

public enum Error: ErrorType {
  case Decompression, StringNSData
}
/*
import Foundation

public typealias ErrorInfo = (code: Int, description: String)

let ErrorDomain = "com.brightdigit.marseft"
let ErrorInfos:[ErrorType : ErrorInfo] = [
  .StringNSData : (code: 1001, description: "The application configuration string could not be rendered."),
  .Decompression : (code: 1002, description: "The application configuration string could not be parsed.")
]

public enum ErrorType : Int, Hashable {
  case StringNSData, Decompression
  public var hashValue: Int {
    return self.rawValue
  }
  public var info: ErrorInfo {
    return ErrorInfos[self]!
  }
}

public enum ErrorDetail {
  case ofType(ErrorType)
  case ofParent(NSError)
}

public func ==(lhs: ErrorType, rhs: ErrorType) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

public class Error : NSError {
  public let detail: ErrorDetail

  public init (type: ErrorType) {
    self.detail = ErrorDetail.ofType(type)
    super.init(domain: ErrorDomain, code: type.info.code, userInfo: [NSLocalizedDescriptionKey: type.info.description])
  }
  
  public init (innerError: NSError) {
    self.detail = ErrorDetail.ofParent(innerError)
    if let error = innerError as? Error {
      switch error.detail {
      case .ofType(let innerType):
        super.init(domain: ErrorDomain, code: innerType.info.code, userInfo: [NSLocalizedDescriptionKey: innerType.info.description])
      default:
        super.init(domain: innerError.domain, code: innerError.code, userInfo: innerError.userInfo)
      }
    } else {
      super.init(domain: innerError.domain, code: innerError.code, userInfo: innerError.userInfo)
    }
  }

  required public init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
*/
