//
//  Created by Oktawian Chojnacki on 24.02.2016.
//  Copyright © 2016 Oktawian Chojnacki. All rights reserved.
//

import UIKit

final class WhosHereWidgetView : UIView, ViewModelRendering {

    // MARK - ViewModelRendering

    typealias ViewModel = WhosHereWidgetViewModel

    private(set) var state: RenderingState<ViewModel> = .Waiting {
        didSet { handleTransitionFromState(oldValue, toState: state) }
    }

    func render(viewModel: ViewModel) {
        state = .Rendering(viewModel)
    }

    func failure() {
        state = .Failed
    }

    // MARK - Initial state

    override func awakeFromNib() {
        super.awakeFromNib()
        handleTransitionFromState(nil, toState: .Waiting)
    }

    // MARK - Transitions

    private func handleTransitionFromState(state: RenderingState<ViewModel>?, toState: RenderingState<ViewModel>) {
        switch (state, toState) {
        case (_, .Rendering(let viewModel)):
            setUpWithViewModel(viewModel)
        case (_, .Failed):
            // No failed appearance
            break
        case (_, .Waiting):
            //
            break
        }
    }

    private func setUpWithViewModel(viewModel: ViewModel) {
        viewModel.faces.forEach { image in
            addSubview(UIImageView(image: image))
        }
    }

    // MARK - fromNib

    class func fromNib() -> WhosHereView {
        return NSBundle.mainBundle().loadNibNamed("WhosHereView", owner: nil, options: nil)[0] as! WhosHereView
    }


}