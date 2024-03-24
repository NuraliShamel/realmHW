import RealmSwift
class UserInfo: Object {
    @Persisted var name : String
    @Persisted var surname: String
    @Persisted var password : String
}

