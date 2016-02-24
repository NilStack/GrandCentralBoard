//
//  Created by Oktawian Chojnacki on 23.02.2016.
//  Copyright © 2016 Oktawian Chojnacki. All rights reserved.
//

import UIKit

final class WhosHereWidget : Widget  {

    private unowned let widgetView: WhosHereWidgetView
    let source: RemoteCollectionOfImages

    init(source: RemoteCollectionOfImages) {
        self.widgetView = WhosHereWidgetView.fromNib()
        self.source = source
    }

    var interval: NSTimeInterval {
        return source.optimalInterval
    }

    var view: UIView {
        return widgetView
    }

    @objc func update() {

        let result = source.read()

        switch result {
        case .Success(let images):
            let timeViewModel = WhosHereWidgetViewModel(faces: images)
            widgetView.render(timeViewModel)
        case .Failure:
            widgetView.failure()
        }
    }
}