//
// Created by Zachary Gray on 2/25/21.
//

import Foundation

struct BESConfig {
    var target: NSURL = NSURL(scheme: "grpc://", host: "localhost:8005", path: "")!
    var authToken: String = "local_flare"
    var projectId: String = ""
    var keywords: [String] = []
}
