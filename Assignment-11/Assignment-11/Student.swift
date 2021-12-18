import Foundation
class Student {
    var id:Int = 0
    var pwd:String = ""
    var name:String = ""
    var phone:String = ""
    var gmail:String = ""
    var gender:String = ""
    var course:String = ""
    var dob:String = ""
    
    init(id:Int, pwd:String, name:String, phone:String, gmail:String, gender:String, course:String, dob:String) {
        self.id = id
        self.pwd = pwd
        self.name = name
        self.phone = phone
        self.gmail = gmail
        self.gender = gender
        self.course = course
        self.dob = dob
    }
}
