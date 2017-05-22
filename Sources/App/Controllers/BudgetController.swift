//
//  BudgetController.swift
//  MonthlyBudget
//
//  Created by keith martin on 5/22/17.
//
//

import Vapor
import HTTP

final class BudgetController: ResourceRepresentable {
    
    let view: ViewRenderer
    
    init(view: ViewRenderer) {
        self.view = view
        self.view.shouldCache = false
    }    
    func indexView(request: Request) throws -> ResponseRepresentable {
        return try view.make("index")
    }
    
    func index(request: Request) throws -> ResponseRepresentable {
        return try BudgetTable.all().makeJSON()
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        let acronym = try request.budgetTable()
        try acronym.save()
        return acronym
    }
    
    func show(request: Request, acronym: BudgetTable) throws -> ResponseRepresentable {
        return acronym
    }
    
    func update(request: Request, budgetTable: BudgetTable) throws -> ResponseRepresentable {
        let new = try request.budgetTable()
        let budgetTable = budgetTable
        budgetTable.name = new.name
        budgetTable.spendingAmount = new.spendingAmount
        try budgetTable.save()
        return budgetTable
    }
    
    func delete(request: Request, budgetTable: BudgetTable) throws -> ResponseRepresentable {
        try budgetTable.delete()
        return JSON([:])
    }
    
    func makeResource() -> Resource<BudgetTable> {
        return Resource (
            index: indexView,
            store: create,
            show: show,
            update: update,
            destroy: delete
        )
    }
    
}

extension Request {
    func budgetTable() throws -> BudgetTable {
        guard let json = json else { throw Abort.badRequest }
        return try BudgetTable(json: json)
    }
}
