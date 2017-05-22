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

final class BudgetTable: Model {
    
    let storage = Storage()
    
    var name: String
    var spendingAmount: Double
    
    init(name: String, spendingAmount: Double) {
        self.name = name
        self.spendingAmount = spendingAmount
    }
    
    // MARK: Fluent Serialization
    
    init(row: Row) throws {
        name = try row.get("name")
        spendingAmount = try row.get("spendingAmount")
    }
    
    // Serializes the Post to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("name", name)
        try row.set("spendingAmount", spendingAmount)
        return row
    }
}

// MARK: Fluent Preparation

extension BudgetTable: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Money objects
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string("name")
            builder.double("spendingAmount")
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: JSON

// How the model converts from / to JSON.

extension BudgetTable: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(
            name: json.get("name"),
            spendingAmount: json.get("spendingAmount")
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("name", name)
        try json.set("spendingAmount", spendingAmount)
        return json
    }
}

// MARK: HTTP

// This allows Post models to be returned
// directly in route closures
extension BudgetTable: ResponseRepresentable { }


