import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    app.get("brands") { req -> EventLoopFuture<View> in
        return Brand.query(on: req.db).all().flatMap { brands in
            let data = ["brands": brands]
            return req.view.render("brandsList", data)
        }

      }

    let brandController = BrandController()
    app.get("test", use: brandController.listAll)

    // try app.register(collection: BrandController(app: app))
}
