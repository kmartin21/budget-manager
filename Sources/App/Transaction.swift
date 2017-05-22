//
//  Transaction.swift
//  MonthlyBudget
//
//  Created by keith martin on 5/22/17.
//
//

import Vapor
import FluentProvider
import HTTP

final class Transaction: Model {
    
    let storage = Storage()
    
    var amount: Double
    
    init(amount: Double) {
        self.amount = amount
    }
    
    // MARK: Fluent Serialization
    
    init(row: Row) throws {
        amount = try row.get("amount")
    }
    
    // Serializes the Post to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("amount", amount)
        return row
    }
}

// MARK: Fluent Preparation

extension Transaction: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Money objects
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string("amount")
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: JSON

// How the model converts from / to JSON.

extension Transaction: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(
            amount: json.get("amount")
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("amount", amount)
        return json
    }
}

// MARK: HTTP

// This allows Post models to be returned
// directly in route closures
extension Transaction: ResponseRepresentable { }
    

