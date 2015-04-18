import Foundation

class Repository<T:AnyObject where T:Equatable>{
    
    var arrayOfData = Array<T>()
    var pList: String
    
    init(plist:String) {
        
        pList = plist + ".plist"
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0] as! String
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
        
        let saveData = NSKeyedArchiver.archivedDataWithRootObject(self.arrayOfData);
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray;
        let documentsDirectory = paths.objectAtIndex(0) as! NSString;
        let path = documentsDirectory.stringByAppendingPathComponent(self.pList);
        
        saveData.writeToFile(path, atomically: true);
        return true
    }
    
    func reset()->Bool{
        self.arrayOfData = Array<T>()
        self.save(self.arrayOfData)
        return true
    }
    
    func get() -> [T]{
        return self.arrayOfData
    }
    
    func delete(element:T) -> Bool{
        self.arrayOfData = self.arrayOfData.filter({ !self.checkEquality($0, left: element) })
        self.save(self.arrayOfData)
        return true
    }
    
    func checkEquality(right:T, left:T) -> Bool{
        return right == left
    }
    
    func saveOne(element:T) -> Bool{
        
        var foundExisting: Bool?
        for (var i=0;i<self.arrayOfData.count;i++){
            if self.checkEquality(self.arrayOfData[i],left:element){
                self.arrayOfData[i] = element
                foundExisting = true
                break
            }
        }
        if foundExisting == nil{
           self.arrayOfData.append(element)
        }

        self.save(self.arrayOfData)
        return true
    }
    
}
