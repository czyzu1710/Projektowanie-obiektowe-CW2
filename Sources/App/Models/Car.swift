import Vapor
import Fluent

final class Car: Model, Content {
    static let schema = "cars"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "model")
    var model: String

    @Field(key: "power")
    var power: Float

    // @Field(key: "speed")
    // var speed: Bool

    @Parent(key: "brand_id")
    var brand: Brand


    // Creates a new, empty Car
    init() { }

    init(id: UUID? = nil, model: String, power: Float, brandId: UUID) {
        self.id = id
        self.model = model
        self.power = power
        // self.speed = speed
        self.$brand.id = brandId
    }
}
