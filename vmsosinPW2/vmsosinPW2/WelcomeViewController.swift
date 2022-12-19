//
//  ViewController.swift
//  vmsosinPW2
//
//  Created by Sosin Vladislav on 22.09.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private var value: Int = 0
    private var flag: Int = 0
    private var isPressedOnStackViewButtons = false
    private var isThemeLight = true
    
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    
    private let incrementButton = UIButton(type: .system)
    private var changeColorButton = UIButton(type: .system)
    private var eraseValueButton = UIButton(type: .system)
    private var changeThemeButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UIView.animate(withDuration: 1) {
            self.updateUI()
        }
    }
    
    @objc
    private func makeValueNull() {
        value = 0
        updateUI()
    }
    
    @objc
    private func stackButtonsPressed() {
        isPressedOnStackViewButtons = true
        updateCommentLabel(value: value)
    }
    
    @objc
    private func setTheme() {
        if isThemeLight {
            view.backgroundColor = .yellow
        } else {
            view.backgroundColor = .systemGray6
        }
        
        isThemeLight = !isThemeLight
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize:
        16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(to: 48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action:
        #selector(incrementButtonPressed), for: .touchUpInside)
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenter(to: self.view.centerXAnchor)
    }
        
    private func setupView() {
        if !isThemeLight {
            view.backgroundColor = .yellow
        } else {
            view.backgroundColor = .systemGray6
        }
        
        setupIncrementButton()
        setupValueLabel()
    }
        
    private func updateUI() {
        setupView()
        let _ = setupCommentView()
        updateCommentLabel(value: value)
        let _ = makeMenuButton(title: "")
        
        if (flag == 0) {
            setupMenuButtons()
            flag = 1
        }
    }
        
    private func setupCommentView() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        view.addSubview(commentView)
        
        commentView.pinTop(to:
        self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 30.0,
        weight: .regular)
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left:
        16, .bottom: 16, .right: 16])
        
        return commentView
    }
        
    func updateCommentLabel(value: Int) {
        switch value {
            case 0...10:
                commentLabel.text = "1"
            case 10...20:
                commentLabel.text = "2!"
            case 20...30:
                commentLabel.text = "3!!"
            case 30...40:
                commentLabel.text = "4!!!"
            case 40...50:
                commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉"
            case 50...60:
                commentLabel.text = "big boy"
            case 60...70:
                commentLabel.text = "70! 70! 70! moreeeee!"
            case 70...80:
                commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐"
            case 80...90:
                commentLabel.text = "80+\n go higher!"
            case 90...100:
                commentLabel.text = "100!!! to the moon!"
            default:
                break
        }
        
        if isPressedOnStackViewButtons {
            commentLabel.textColor =
            UIColor(red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1.0)
            isPressedOnStackViewButtons = false
        }
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 30.0,
        weight: .medium)
        button.layer.applyShadow(color: .systemGray, opacity: 0.2, radius: 9)
        button.backgroundColor = .white
        
        return button
    }
    
    private func setupMenuButtons() {
        changeColorButton = makeMenuButton(title: "🪣")
        eraseValueButton = makeMenuButton(title: "🅾️")
        changeThemeButton = makeMenuButton(title: "☀️")
         
        let buttonsSV = UIStackView(arrangedSubviews:
        [changeColorButton, eraseValueButton, changeThemeButton])

        changeColorButton.addTarget(self, action:
        #selector(stackButtonsPressed), for: .touchUpInside)
        eraseValueButton.addTarget(self, action:
        #selector(makeValueNull), for: .touchUpInside)
        changeThemeButton.addTarget(self, action:
        #selector(setTheme), for: .touchUpInside)
        
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to:
        self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
}
