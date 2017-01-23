import Vapor
import Foundation

#if os(Linux)
    typealias CommandProcess = Task
#else
    typealias CommandProcess = Process
#endif




let drop = Droplet()

drop.post("/hooker/updateBlog") { _ in

    let task = CommandProcess()
    task.launchPath = "/carl/bin/blogRefresh"

    task.launch()

    return JSON([:])
}

drop.run()
