//
// Created by Zachary Gray on 2/25/21.
//

import Foundation

class BESMetricsRepository : MetricsRepository {
    let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    func insertBuildMetrics(_ buildMetrics: BuildMetrics, using eventLoop: EventLoop) -> EventLoopFuture<Void> {

    }

}
