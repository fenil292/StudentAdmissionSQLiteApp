import Foundation
class  FileManagerService {
    static func getDocDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Doc Dir: \(paths[0])")
        return paths[0]
    }

}
