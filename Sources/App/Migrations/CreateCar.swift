import Fluent

struct CreateCar: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("cars")
            .id()
            .field("model", .string, .required)
            .field("power", .float, .required)
            .field("brandId", .uuid, .references("brands", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("cars").delete()
    }
}
