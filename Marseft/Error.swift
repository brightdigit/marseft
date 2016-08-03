//
//  Errors.swift
//  TicTalkToc
//
//  Created by Leo G Dion on 2/13/15.
//  Copyright (c) 2015 BrightDigit. All rights reserved.
//

public enum MarseftError: Error {
  case decompression, base64, deserialization(parent: Error)
}
