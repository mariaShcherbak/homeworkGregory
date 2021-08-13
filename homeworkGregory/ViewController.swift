//
//  ViewController.swift
//  homeworkGregory
//
//  Created by Tanya on 02.08.2021.
//
import SwiftUI
import UIKit
import Foundation

class ViewController: UIViewController, UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {
    
    var switchStateDefaults: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: StorageKeys.switchState)
            print("set rotation \(newValue ? "'on'" : "'off'")")
        }
        get {
            UserDefaults.standard.bool(forKey: StorageKeys.switchState)
        }
    }
    
    var sliderValueNumber: Float {
        set {
            UserDefaults.standard.set(newValue, forKey: StorageKeys.sliderValue)
            newSliderValue(float: newValue)
        }
        get {
            UserDefaults.standard.float(forKey: StorageKeys.sliderValue)
        }
    }
    
    var dictCat = ["Cat": UIImage(named: "catImage")] // смена картинки кнопкой Cat
    
    @IBOutlet weak var mainSwitch: UISwitch!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var mainSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        stateUserDefaults()
    }

    func stateUserDefaults() {
        mainSwitch.isOn = switchStateDefaults
        mainSlider.value = sliderValueNumber
        newSliderValue(float: sliderValueNumber)
    }
    
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo: [UIImagePickerController.InfoKey : Any]) {
        print("choose")
        print(UIImagePickerController.InfoKey.editedImage)
        mainImage.image = didFinishPickingMediaWithInfo[.editedImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        print("cancel")
        dismiss(animated: true, completion: nil)
    }
    
    func newSliderValue(float: Float) {
        sliderValue.text = "\(Int(float))"
        mainImage.alpha = CGFloat(float)/100
    }

    // MARK: - IBActions

    @IBAction func changeImageCat(_ sender: UIButton) {
        mainImage.image = dictCat["Cat"] as? UIImage // смена картинки кнопкой Cat
    }
    
    // надпись на кнопке выбора картинки
    @IBAction func selectImage(_ sender: Any) {
        print("select image button pressed")
    }
    
    // включение возможности вращать, сохранение положения свича в UserDefaults
    @IBAction func switchRotation(_ sender: UISwitch) { // печатает состояние свича
        switchStateDefaults = sender.isOn
    }
    
    // регулирует прозрачность, сохраняет значение локальной переменной для дефолта слайдера
    @IBAction func sliderTransparency(_ sender: UISlider) {
        sliderValueNumber = sender.value
    }
    
    //смена картинки кнопкой из галереи
    @IBAction func changeImage(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    //вращает картинку
    @IBAction func rotationGestureImage(_ sender: UIRotationGestureRecognizer) {
        if switchStateDefaults {
            mainImage.transform = mainImage.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
}
    
    
    
    
    
    
