import Fluent

struct CreateBrand: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("brands")
            .id()
            .field("name", .string, .required)
            .field("established", .string, .required)
            .field("residence", .string, .required)
            .field("country", .string, .required)
            // .field("brandId", .uuid, .references("brands"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("brands").delete()
    }
}
