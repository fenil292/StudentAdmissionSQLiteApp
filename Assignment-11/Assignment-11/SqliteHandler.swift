import Foundation
import SQLite3

class SqliteHandler {
    static let shared = SqliteHandler()
    let dbPath = "StudPortal.sqlite"
    var db:OpaquePointer?
    private init() {
        db = openDatabase()
        createTable()
    }
    private func openDatabase() -> OpaquePointer? {
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = docURL.appendingPathComponent(dbPath)
        print(docURL)
        var database:OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK {
            print("opened")
            return database
        } else {
            print("error in open")
            return nil
        }
    }
    private func createTable() {
        let createstudstr = """
            create table if not exists student(
            spid integer primary key,
            pwd text,
            name text,
            phone text,
            gmail text,
            gender text,
            course text,
            dob text);
        """
        var createstudst:OpaquePointer? = nil
        if  sqlite3_prepare_v2(db,createstudstr, -1, &createstudst, nil) == SQLITE_OK {
            if sqlite3_step(createstudst) == SQLITE_DONE {
                print("stud table ceated")
            } else {
                print("stud table not created")
            }
        } else {
            print("stud not prepared")
        }
        sqlite3_finalize(createstudst)
        let createnoticestr = """
            create table if not exists notice(
            id integer primary key AUTOINCREMENT,
            name text,
            course text,
            notice_date text,
            desc text);
        """
        var createnoticest:OpaquePointer? = nil
        if  sqlite3_prepare_v2(db,createnoticestr, -1, &createnoticest, nil) == SQLITE_OK {
            if sqlite3_step(createnoticest) == SQLITE_DONE {
                print("notice table ceated")
            } else {
                print("notice table not created")
            }
        } else {
            print("notice not prepared")
        }
        sqlite3_finalize(createnoticest)
    }
    func insert(s:Student, completion: @escaping ((Bool) -> Void)) {
        let insertstr = "INSERT INTO student VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
        
        var insertst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertstr, -1, &insertst, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_int(insertst,1 , Int32(s.id))
            sqlite3_bind_text(insertst, 2, (s.pwd as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 3, (s.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 4, (s.phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 5, (s.gmail as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 6, (s.gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 7, (s.course as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 8, (s.dob as NSString).utf8String, -1, nil)
            if sqlite3_step(insertst) == SQLITE_DONE {
                print("inserted")
                completion(true)
            } else {
                print("not inserted")
                completion(false)
            }
            
        } else {
            print("Insert statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(insertst)
    }
    func update(s:Student, completion: @escaping ((Bool) -> Void)) {
        let updatestr = "UPDATE student set name = ?, phone = ?, gmail = ?, gender = ?, course = ?, dob = ? where spid = ?;"
        
        var updatest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updatestr, -1, &updatest, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_int(updatest,7 , Int32(s.id))
            //sqlite3_bind_text(insertst, 2, (s.pwd as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 1, (s.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 2, (s.phone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 3, (s.gmail as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 4, (s.gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 5, (s.course as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 6, (s.dob as NSString).utf8String, -1, nil)
            if sqlite3_step(updatest) == SQLITE_DONE {
                print("updated")
                completion(true)
            } else {
                print("not updated")
                completion(false)
            }
            
        } else {
            print("update statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(updatest)
    }
    func delete(for id:Int, completion: @escaping ((Bool) -> Void)) {
        let deletestr = "DELETE FROM student WHERE spid = ?;"
        
        var deletest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deletestr, -1, &deletest, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            
            sqlite3_bind_int(deletest, 1, Int32(id))
            if sqlite3_step(deletest) == SQLITE_DONE {
                print("deleted")
                completion(true)
            } else {
                print("not deleted")
                completion(false)
            }
            
        } else {
            print("delete statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(deletest)
    }
    func insert_notice(s:Notice, completion: @escaping ((Bool) -> Void)) {
        let insertstr = "INSERT INTO notice(name,course,notice_date,desc) VALUES (?, ?, ?, ?);"
        
        var insertst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertstr, -1, &insertst, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_text(insertst, 1, (s.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 2, (s.course as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 3, (s.notice_date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertst, 4, (s.desc as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertst) == SQLITE_DONE {
                print("inserted")
                completion(true)
            } else {
                print("not inserted")
                completion(false)
            }
            
        } else {
            print("Insert statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(insertst)
    }
    func update_notice(n:Notice, completion: @escaping ((Bool) -> Void)) {
        let updatestr = "UPDATE notice set name = ?, course = ?, notice_date = ?, desc = ? where id = ?;"
        
        var updatest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updatestr, -1, &updatest, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_text(updatest, 1, (n.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 2, (n.course as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 3, (n.notice_date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 4, (n.desc as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updatest,5 , Int32(n.id))
            if sqlite3_step(updatest) == SQLITE_DONE {
                print("updated")
                completion(true)
            } else {
                print("not updated")
                completion(false)
            }
            
        } else {
            print("update statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(updatest)
    }
    func delete_notice(for id:Int, completion: @escaping ((Bool) -> Void)) {
        let deletestr = "DELETE FROM notice WHERE id = ?;"
        
        var deletest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deletestr, -1, &deletest, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            
            sqlite3_bind_int(deletest, 1, Int32(id))
            if sqlite3_step(deletest) == SQLITE_DONE {
                print("deleted")
                completion(true)
            } else {
                print("not deleted")
                completion(false)
            }
            
        } else {
            print("delete statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(deletest)
    }
    
    func fetch_id() -> Int {
        let fetchstr = "SELECT max(spid) FROM student;"
        //var emp = [Emp]()
        var res:Int = 0
        var cnt:Int = 0
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            
            while sqlite3_step(fetchst) == SQLITE_ROW {
                print("fetched")
                res = Int(sqlite3_column_int(fetchst, 0))
                cnt = cnt + 1
            }
            if cnt == 0 {
                return cnt
            }
        } else {
            print("fetch statement could not be prepared")
            
        }
        sqlite3_finalize(fetchst)
        return res
    }
    func check_login(id: Int, pass: String) -> Student {
        let fetchstr = "SELECT spid,name FROM student where spid = ? and pwd = ?;"
        var stud = Student(id: 0, pwd: "", name: "", phone: "", gmail: "", gender: "", course: "", dob: "")
        //var res:Int = 0
        //var cnt:Int = 0
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            sqlite3_bind_int(fetchst,1 , Int32(id))
            sqlite3_bind_text(fetchst, 2, (pass as NSString).utf8String, -1, nil)
            while sqlite3_step(fetchst) == SQLITE_ROW {
                print("fetched")
                let id = Int(sqlite3_column_int(fetchst, 0))
                let name = String(cString: sqlite3_column_text(fetchst, 1))
                stud = Student(id: id, pwd: "", name: name, phone: "", gmail: "", gender: "", course: "", dob: "")
                //cnt = cnt + 1
            }
            /*if cnt == 0 {
                return cnt
            }*/
        } else {
            print("fetch statement could not be prepared")
            
        }
        sqlite3_finalize(fetchst)
        return stud
    }
    func fetch() -> [Student] {
        let fetchstr = "SELECT * FROM student;"
        var studs = [Student]()
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            
            while sqlite3_step(fetchst) == SQLITE_ROW {
                print("fetched")
                let id = Int(sqlite3_column_int(fetchst, 0))
                let name = String(cString: sqlite3_column_text(fetchst, 2))
                //let age = Int(sqlite3_column_int(fetchst, 2))
                let phone = String(cString: sqlite3_column_text(fetchst, 3))
                let gmail = String(cString: sqlite3_column_text(fetchst, 4))
                let gender = String(cString: sqlite3_column_text(fetchst, 5))
                let course = String(cString: sqlite3_column_text(fetchst, 6))
                let dob = String(cString: sqlite3_column_text(fetchst, 7))
                let p = ""
                studs.append(Student(id: id, pwd: p, name: name, phone: phone, gmail: gmail, gender: gender, course: course, dob: dob))
            }
            
        } else {
            print("fetch statement could not be prepared")
            
        }
        sqlite3_finalize(fetchst)
        return studs
    }
    func fetch_notice() -> [Notice] {
        let fetchstr = "SELECT * FROM notice;"
        var notices = [Notice]()
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            
            while sqlite3_step(fetchst) == SQLITE_ROW {
                print("fetched")
                let id = Int(sqlite3_column_int(fetchst, 0))
                let name = String(cString: sqlite3_column_text(fetchst, 1))
                let course = String(cString: sqlite3_column_text(fetchst, 2))
                let ndate = String(cString: sqlite3_column_text(fetchst, 3))
                let desc = String(cString: sqlite3_column_text(fetchst, 4))
                notices.append(Notice(id: id, name: name, course: course, notice_date: ndate, desc: desc))
            }
            
        } else {
            print("fetch statement could not be prepared")
            
        }
        sqlite3_finalize(fetchst)
        return notices
    }
    func fetch_stud_notice(name: String) -> [Notice] {
        let fetchstr = "SELECT * FROM notice where course = 'All Courses' or course = ?;"
        var notices = [Notice]()
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            sqlite3_bind_text(fetchst, 1, (name as NSString).utf8String, -1, nil)
            while sqlite3_step(fetchst) == SQLITE_ROW {
                print("fetched")
                let id = Int(sqlite3_column_int(fetchst, 0))
                let name = String(cString: sqlite3_column_text(fetchst, 1))
                let course = String(cString: sqlite3_column_text(fetchst, 2))
                let ndate = String(cString: sqlite3_column_text(fetchst, 3))
                let desc = String(cString: sqlite3_column_text(fetchst, 4))
                notices.append(Notice(id: id, name: name, course: course, notice_date: ndate, desc: desc))
            }
            
        } else {
            print("fetch statement could not be prepared")
            
        }
        sqlite3_finalize(fetchst)
        return notices
    }
    func fetch_stud_course(id: Int) -> String {
        let fetchstr = "SELECT course FROM student where spid = \(id);"
        //var emp = [Emp]()
        var res = ""
        
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            sqlite3_bind_int(fetchst,1 , Int32(id))
            while sqlite3_step(fetchst) == SQLITE_ROW {
                print("fetched")
                res = String(cString: sqlite3_column_text(fetchst, 0))
                
            }
            
        } else {
            print("fetch statement could not be prepared")
            
        }
        sqlite3_finalize(fetchst)
        return res
    }
    func fetch_stud_info(id: Int) -> Student {
        let fetchstr = "SELECT * FROM student where spid = ?;"
        var stud:Student = Student(id: 0, pwd: "", name: "", phone: "", gmail: "", gender: "", course: "", dob: "")
        var fetchst:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &fetchst, nil) == SQLITE_OK {
            sqlite3_bind_int(fetchst,1 , Int32(id))
            while sqlite3_step(fetchst) == SQLITE_ROW {
                print("fetched")
                let sid = Int(sqlite3_column_int(fetchst, 0))
                let name = String(cString: sqlite3_column_text(fetchst, 2))
                //let age = Int(sqlite3_column_int(fetchst, 2))
                let phone = String(cString: sqlite3_column_text(fetchst, 3))
                let gmail = String(cString: sqlite3_column_text(fetchst, 4))
                let gender = String(cString: sqlite3_column_text(fetchst, 5))
                let course = String(cString: sqlite3_column_text(fetchst, 6))
                let dob = String(cString: sqlite3_column_text(fetchst, 7))
                
                stud = Student(id: sid, pwd: "", name: name, phone: phone, gmail: gmail, gender: gender, course: course, dob: dob)
                //studs.append(Student(id: id, pwd: p, name: name, phone: phone, gmail: gmail, gender: gender, course: course, dob: dob))
            }
            
        } else {
            print("fetch statement could not be prepared")
            
        }
        sqlite3_finalize(fetchst)
        return stud
    }
    func update_password(pass: String,id: Int, completion: @escaping ((Bool) -> Void)) {
        let updatestr = "UPDATE student set pwd = ? where spid = ?;";
        
        var updatest:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updatestr, -1, &updatest, nil) == SQLITE_OK {
            //int sqlite3_bind_text(sqlite3_stmt*,int,const char*,int,void(*)(void*));
            sqlite3_bind_int(updatest,2 , Int32(id))
            //sqlite3_bind_text(insertst, 2, (s.pwd as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatest, 1, (pass as NSString).utf8String, -1, nil)
            
            if sqlite3_step(updatest) == SQLITE_DONE {
                print("updated")
                completion(true)
            } else {
                print("not updated")
                completion(false)
            }
            
        } else {
            print("update statement could not be prepared")
            completion(false)
        }
        sqlite3_finalize(updatest)
    }
}
