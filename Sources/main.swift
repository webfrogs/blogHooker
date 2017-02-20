import Vapor
import Foundation

#if os(Linux)
    typealias CommandProcess = Task
#else
    typealias CommandProcess = Process
#endif




let drop = Droplet()

drop.post("/hooker/updateBlog") { (request) in
    guard request.uri.host == "127.0.0.1" else {
        throw Abort.notFound
    }

    let task = CommandProcess()
    task.launchPath = "/carl/bin/blogRefresh"

    task.launch()

    return JSON(["isReceived": true])
}

drop.run(servers: [
    "default": (host: "127.0.0.1", port: 8080, securityLayer: .none)
    ])
