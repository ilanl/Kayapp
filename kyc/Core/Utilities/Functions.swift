import Dispatch

func afterDelay(seconds: Double, closure: () -> ()) {
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(when, dispatch_get_main_queue(), closure)
}

func synchronized(sync: AnyObject, fn: ()->()) {
    objc_sync_enter(sync)
    fn()
    objc_sync_exit(sync)
}

