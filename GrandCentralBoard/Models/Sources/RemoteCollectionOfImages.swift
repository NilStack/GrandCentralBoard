//
//  Created by Oktawian Chojnacki on 02.01.2016.
//  Copyright © 2016 Oktawian Chojnacki. All rights reserved.
//

import UIKit
import Alamofire

struct Images : Timed {
    let value: [UIImage]
    let time: NSDate
}

final class RemoteCollectionOfImages : Asynchronous {

    typealias ResultType = Result<Images>

    let optimalInterval: NSTimeInterval
    let sourceType: SourceType = .Momentary

    private let url: NSURL

    init(url: NSURL, optimalInterval: NSTimeInterval = 10) {
        self.optimalInterval = optimalInterval
        self.url = url
    }

    func read(closure: (ResultType) -> Void) {
        Alamofire.request(.GET, url).response { (request, response, data, error) in

            if let data = data, image = UIImage(data: data) {
                let image = Images(value: [image], time: NSDate())
                closure(.Success(image))
                return
            }

            closure(.Failure)
        }
    }
}