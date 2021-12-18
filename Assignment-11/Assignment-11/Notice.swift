import Foundation
class Notice {
    var id:Int = 0
    var name:String = ""
    var course:String = ""
    var notice_date:String = ""
    var desc:String = ""
    
    init(id:Int, name:String, course:String, notice_date:String, desc:String) {
        self.id = id
        self.name = name
        self.course = course
        self.notice_date = notice_date
        self.desc = desc
    }
}
