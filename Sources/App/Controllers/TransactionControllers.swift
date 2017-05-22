////
////  TransactionControllers.swift
////  MonthlyBudget
////
////  Created by keith martin on 5/22/17.
////
////
//
//import Vapor
//import HTTP
//
//final class TransactionController: ResourceRepresentable {
//    
//    func index(request: Request) throws -> ResponseRepresentable {
//        return try Transaction.all().makeJSON()
//    }
//    
//    func create(request: Request) throws -> ResponseRepresentable {
//        let acronym = try request.acronym()
//        try acronym.save()
//        return acronym
//    }
//    
//    func show(request: Request, acronym: Acronym) throws -> ResponseRepresentable {
//        return acronym
//    }
//    
//    func update(request: Request, acronym: Acronym) throws -> ResponseRepresentable {
//        let new = try request.acronym()
//        let acronym = acronym
//        acronym.short = new.short
//        acronym.long = new.long
//        try acronym.save()
//        return acronym
//    }
//    
//    func delete(request: Request, acronym: Acronym) throws -> ResponseRepresentable {
//        try acronym.delete()
//        return JSON([:])
//    }
//    
//    func makeResource() -> Resource<Acronym> {
//        return Resource (
//            index: index,
//            store: create,
//            show: show,
//            update: update,
//            destroy: delete
//        )
//    }
//    
//}
//
//extension Request {
//    func budget() throws -> Acronym {
//        guard let json = json else { throw Abort.badRequest }
//        return try Acronym(json: json)
//    }
//}
