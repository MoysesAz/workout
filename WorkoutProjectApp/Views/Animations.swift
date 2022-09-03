//
//  Animations.swift
//  WorkoutProjectApp
//
//  Created by Moyses Miranda do Vale Azevedo on 03/09/22.
//

import UIKit

class Animations: UIViewController {

    enum interactionErrors: Error {
        case invalidCoordenation
        case invalidValueOfAnchorView
    }

    var anchorView = 1

    lazy private var panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))

    lazy private var view1: UIView = {
        let view1 = UIView(frame: CGRect(x: view.frame.width / 2 , y: view.frame.height / 2 , width: 50, height: 50))
        view1.backgroundColor = .red
        view1.addGestureRecognizer(panGesture)
        view1.isUserInteractionEnabled = true
        return view1
    }()

    lazy private var view2: UIView = {
        let view1 = UIView(frame: CGRect(x: view.frame.width/2 - 25, y: 130 , width: 50, height: 50))
        view1.backgroundColor = .blue
        view1.isUserInteractionEnabled = false
        return view1
    }()

    lazy private var view3: UIView = {
        let view1 = UIView(frame: CGRect(x: view.frame.width/2 - 25 , y: view.frame.height - 130 , width: 50, height: 50))
        view1.backgroundColor = .green
        view1.isUserInteractionEnabled = false
        return view1
    }()


    lazy private var dynamicAnimator: UIDynamicAnimator = {
        let dynamicAnimator = UIDynamicAnimator(referenceView: view)
        return dynamicAnimator
    }()

    lazy private var snapBehavior1: UISnapBehavior = {
        let snapBehavior = UISnapBehavior(item: view1, snapTo: view.center)
        return snapBehavior
    }()

    lazy private var snapBehavior2: UISnapBehavior = {
        let snapBehavior = UISnapBehavior(item: view1, snapTo: view2.center)
        return snapBehavior
    }()

    lazy private var snapBehavior3: UISnapBehavior = {
        let snapBehavior = UISnapBehavior(item: view1, snapTo: view3.center)
        return snapBehavior
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(view2)
        view.addSubview(view3)
        view.addSubview(view1)
        dynamicAnimator.addBehavior(snapBehavior1)

    }

    @objc func pannedView(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            removeBehavior()
        case .changed:
            let translation = recognizer.translation(in: view)
            view1.center = CGPoint(x: view1.center.x + translation.x,
                                   y: view1.center.y + translation.y)

            let value = view1.center.y
            setAnchorView(ValueY: value)
            recognizer.setTranslation(.zero, in: view)
        case .ended, .cancelled, .failed:
            addBehavior()
        case .possible:
            break
        }
    }


    func removeBehavior(){
        switch anchorView{
        case 1:
            dynamicAnimator.removeBehavior(snapBehavior1)
        case 2 :
            dynamicAnimator.removeBehavior(snapBehavior2)
        case 3 :
            dynamicAnimator.removeBehavior(snapBehavior3)
        default:
            print(behavior.invalidValueOfAnchorView)
        }
    }

    func addBehavior(){
        switch anchorView{
        case 1:
            dynamicAnimator.addBehavior(snapBehavior1)
        case 2 :
            dynamicAnimator.addBehavior(snapBehavior2)
        case 3 :
            dynamicAnimator.addBehavior(snapBehavior3)
        default:
            print(interactionErrors.invalidValueOfAnchorView)
        }
    }

    func setAnchorView(ValueY: CGFloat){
        switch ValueY {
        case 250...580:
            anchorView = 1
        case ...250:
            anchorView = 2
        case 580...:
            anchorView = 3
        default:
            print(interactionErrors.invalidCoordenation)
        }
    }




}
