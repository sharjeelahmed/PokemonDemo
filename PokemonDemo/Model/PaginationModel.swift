//
//  PaginationModel.swift
//
//  Created by Shairjeel Ahmed on 25/06/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PaginationModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let last = "last"
    static let current = "current"
    static let previous = "previous"
    static let total = "count"
    static let next = "next"
    static let first = "first"
    static let pages = "pages"
  }

  // MARK: Properties
  public var last: Int?
  public var current: Int?
  public var previous: Int?
  public var total: Int?
  public var next: Int?
  public var first: Int?
  public var pages: [Int]?
  public var offset: Int?
  public var limit: Int?
  public var loadMore: Bool = true



  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    last = json[SerializationKeys.last].int
    current = json[SerializationKeys.current].int
    previous = json[SerializationKeys.previous].int
    total = json[SerializationKeys.total].int
    next = json[SerializationKeys.next].int
    first = json[SerializationKeys.first].int
    if let items = json[SerializationKeys.pages].array { pages = items.map { $0.intValue } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = last { dictionary[SerializationKeys.last] = value }
    if let value = current { dictionary[SerializationKeys.current] = value }
    if let value = previous { dictionary[SerializationKeys.previous] = value }
    if let value = total { dictionary[SerializationKeys.total] = value }
    if let value = next { dictionary[SerializationKeys.next] = value }
    if let value = first { dictionary[SerializationKeys.first] = value }
    if let value = pages { dictionary[SerializationKeys.pages] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.last = aDecoder.decodeObject(forKey: SerializationKeys.last) as? Int
    self.current = aDecoder.decodeObject(forKey: SerializationKeys.current) as? Int
    self.previous = aDecoder.decodeObject(forKey: SerializationKeys.previous) as? Int
    self.total = aDecoder.decodeObject(forKey: SerializationKeys.total) as? Int
    self.next = aDecoder.decodeObject(forKey: SerializationKeys.next) as? Int
    self.first = aDecoder.decodeObject(forKey: SerializationKeys.first) as? Int
    self.pages = aDecoder.decodeObject(forKey: SerializationKeys.pages) as? [Int]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(last, forKey: SerializationKeys.last)
    aCoder.encode(current, forKey: SerializationKeys.current)
    aCoder.encode(previous, forKey: SerializationKeys.previous)
    aCoder.encode(total, forKey: SerializationKeys.total)
    aCoder.encode(next, forKey: SerializationKeys.next)
    aCoder.encode(first, forKey: SerializationKeys.first)
    aCoder.encode(pages, forKey: SerializationKeys.pages)
  }

}
