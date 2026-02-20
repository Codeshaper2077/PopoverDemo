//
//  ViewController.swift
//  PopoverDemo
//
//  Created by Ivan on 17.02.2026.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

//    let button1: UIButton = {
//        let button = UIButton(type: .system)
//        
//        return button
//    }()
    
//    let button2: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Кнопка 2", for: .normal)
//        button.backgroundColor = .systemGreen
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        button1.setTitle("Кнопка1", for: .normal)
        button1.backgroundColor = .systemBlue
        button1.setTitleColor(.white, for: .normal)
        button1.layer.cornerRadius = 8
        button1.translatesAutoresizingMaskIntoConstraints = false
        
        button2.setTitle("Кнопка2", for: .normal)
        button2.backgroundColor = .systemBlue
        button2.setTitleColor(.white, for: .normal)
        button2.layer.cornerRadius = 8
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button1)
        view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button1.widthAnchor.constraint(equalToConstant: 120),
            button1.heightAnchor.constraint(equalToConstant: 50),
            button2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            button2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button2.widthAnchor.constraint(equalToConstant: 120),
            button2.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func setupActions() {
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
    }
    
    @objc func button1Tapped() {
        performSegue(withIdentifier: "showPopoverFromButton1", sender: button1)
    }
    
    @objc func button2Tapped() {
        performSegue(withIdentifier: "showPopoverFromButton2", sender: button2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let popoverVC = segue.destination as? PopoverViewController,
        let popoverController = popoverVC.popoverPresentationController,
        let sourceButton = sender as? UIButton else { return }
        
        popoverController.delegate = self
        popoverController.sourceView = sourceButton
        popoverController.sourceRect = sourceButton.bounds
        popoverController.permittedArrowDirections = .any
        popoverController.backgroundColor = .systemBackground
        
        popoverVC.preferredContentSize = CGSize(width: 300, height: 250)
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    //delegate
    func popoverPresentationController(_ popoverPresentationController: UIPopoverPresentationController, willRepositionPopoverTo rect: UnsafeMutablePointer<CGRect>, in view: AutoreleasingUnsafeMutablePointer<UIView>) {
        if UIDevice.current.orientation.isLandscape {
            print("Ландшафтный режим - привязываем к кнопке 2")
            view.pointee = button2
            rect.pointee = button2.bounds
        } else {
            print("Портретный режим - привязываем к кнопке 1")
            view.pointee = button1
            rect.pointee = button1.bounds
        }
    }
    
}

