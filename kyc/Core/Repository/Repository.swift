import Foundation

class Repository<T:AnyObject> {
    
    var arrayOfData = Array<T>()
    var pList: String
    
    init(plist:String) {
        
        pList = plist + ".plist"
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as String
        let path = documentsDirectory.stringByAppendingPathComponent(pList)
        let fileManager = NSFileManager.defaultManager()
        
        // check if file exists
        if !fileManager.fileExistsAtPath(path) {
            // create an empty file if it doesn't exist
            if let bundle = NSBundle.mainBundle().pathForResource("DefaultFile", ofType: "plist") {
                fileManager.copyItemAtPath(bundle, toPath: path, error:nil)
            }
        }
        
        if let rawData = NSData(contentsOfFile: path) {
            
            if var array = NSKeyedUnarchiver.unarchiveObjectWithData(rawData) as? [T] {
                self.arrayOfData = array
            }
        }
    }
    
    func save(array: [T])->Bool {
        
        self.arrayOfData = array
        
        let saveData = NSKeyedArchiver.archivedDataWithRootObject(array);
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray;
        let documentsDirectory = paths.objectAtIndex(0) as NSString;
        let path = documentsDirectory.stringByAppendingPathComponent(self.pList);
        
        saveData.writeToFile(path, atomically: true);
        return true
    }
    
    func reset()->Bool{
        self.arrayOfData = Array<T>()
        return true
    }
    
    func get() -> [T]{
        return self.arrayOfData
    }
    
}
