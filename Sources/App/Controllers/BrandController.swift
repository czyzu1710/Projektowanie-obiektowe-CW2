import Fluent
import Vapor


struct BrandController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let brands = routes.grouped("brands")
        brands.get(use: listAll)
        brands.post(use: create)
        brands.group(":brandID") { Brand in
            Brand.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Brand]> {
        return Brand.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Brand> {
        let brand = try req.content.decode(Brand.self)
        return brand.save(on: req.db).map { brand }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Brand.find(req.parameters.get("brandID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }

    func listAll(req: Request) throws -> EventLoopFuture<View> {
        let brands = Brand.query(on: req.db).all()
        return brands.flatMap { brands in
          print(brands)
          let d = ["brands": brands]
          return req.view.render("brandsList", d)
        }
        // return Brand.query(on: req.db).all().flatMap { brands in
        //     let data = ["brands": brands]
        //     return req.view.render("brandsList", data)
        // }
      }

}
