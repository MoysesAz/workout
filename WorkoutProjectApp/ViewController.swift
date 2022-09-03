//
//  ViewController.swift
//  WorkoutProjectApp
//
//  Created by Moyses Miranda do Vale Azevedo on 01/09/22.
//

import UIKit

class ViewController: UIViewController {
    var valor = 0

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

    lazy private var snapBehavior: UISnapBehavior = {
        let snapBehavior = UISnapBehavior(item: view1, snapTo: view.center)
        return snapBehavior
    }()

    lazy private var snapBehavior1: UISnapBehavior = {
        let snapBehavior = UISnapBehavior(item: view1, snapTo: view3.center)
        return snapBehavior
    }()

    lazy var snapBehavior2: UISnapBehavior = {
        let snapBehavior = UISnapBehavior(item: view1, snapTo: view2.center)
        return snapBehavior
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(view.frame)
        print(view.center)
        view.addSubview(view2)
        view.addSubview(view3)
        view.addSubview(view1)
        dynamicAnimator.addBehavior(snapBehavior)

    }

    @objc func pannedView(recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            switch valor{
            case 0:
                dynamicAnimator.removeBehavior(snapBehavior)
            case 2 :
                dynamicAnimator.removeBehavior(snapBehavior1)
            case 3 :
                dynamicAnimator.removeBehavior(snapBehavior2)
            default:
                print("erro")
            }

        case .changed:
            let translation = recognizer.translation(in: view)
            view1.center = CGPoint(x: view1.center.x + translation.x,
                                   y: view1.center.y + translation.y)

            if view1.center.y > 250 && view1.center.y < 580  {
                valor = 0
            }

            else if view1.center.y >= 250 {
                valor = 2
            }

            else if  view1.center.y <= 580 {
                valor = 3
            }
            recognizer.setTranslation(.zero, in: view)
        case .ended, .cancelled, .failed:
            switch valor{
            case 0:
                dynamicAnimator.addBehavior(snapBehavior)

            case 2 :
                dynamicAnimator.addBehavior(snapBehavior1)


            case 3 :
                dynamicAnimator.addBehavior(snapBehavior2)

            default:
                print("erro")
            }
        case .possible:
            break
        }
    }
}

