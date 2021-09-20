import Fluent
import Vapor

final class Brand: Model, Content {
    static let schema = "brands"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "established")
    var est: String

    @Field(key: "residence")
    var residence: String

    @Field(key: "country")
    var country: String

    @Children(for: \.$brand)
    var cars: [Car]

    init() {}
    init (id:UUID? = nil, name:String, est:String, residence: String, country:String){
      self.id = id
      self.name = name
      self.est = est
      self.country = country
    }
}
