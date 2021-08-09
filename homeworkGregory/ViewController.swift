//
//  ViewController.swift
//  homeworkGregory
//
//  Created by Tanya on 02.08.2021.
//
import SwiftUI
import UIKit
import Foundation
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var switchRotationOn : Bool!
    var switchStateDefaults: Bool! // локальная для дефолта
    var sliderValueNumber: Float! // локальная для дефолта
    var isRotationOn = "" // выводится в принт состояние свича
    var dictCat = ["Cat": UIImage(named: "catImage")] // смена картинки кнопкой Cat
    
    @IBOutlet weak var mainSwitch: UISwitch!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var mainSlider: UISlider!
    
    
// надпись на кнопке выбора картинки
    @IBAction func selectImage(_ sender: Any) {
        print("select image button pressed")
    }
    
    // включение возможности вращать, сохранение положения свича в UserDefaults
    @IBAction func switchRotation(_ sender: UISwitch) { // печатает состояние свича
        if sender.isOn {
            isRotationOn = "set rotation 'on"
            switchRotationOn = true
            switchStateDefaults = true // дефолтная для свича
            UserDefaults.standard.set(self.switchStateDefaults, forKey: "switchStateDefaults")
        }
        else {
            isRotationOn = "set rotation 'off"
            switchRotationOn = false
          switchStateDefaults = false // дефолтная для свича
       UserDefaults.standard.set(self.switchStateDefaults, forKey: "switchStateDefaults")
        }
        print(isRotationOn)
    }
    
    // регулирует прозрачность, сохраняет значение локальной переменной для дефолта слайдера
    @IBAction func sliderTransparency(_ sender: UISlider) {
        sliderValueNumber = sender.value
        UserDefaults.standard.set(self.sliderValueNumber, forKey: "sliderValueNumber")
        sliderValue.text = "\(Int(sliderValueNumber))"
        mainImage.alpha = CGFloat(sliderValueNumber)/100
         
    }    
    //вращает картинку
    @IBAction func rotationGestureImage(_ sender: UIRotationGestureRecognizer) {
        if switchRotationOn == true{
            print("switchRotationOn == true")
            if let view = mainImage {
                view.transform = view.transform.rotated(by: sender.rotation)
                sender.rotation = 0
                print("func rotationGestureImage ON")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stateUserDefaults()
        
        }

    func stateUserDefaults() {  // положение свича и слайдера из UserDefault
    switchStateDefaults = UserDefaults.standard.bool(forKey: "switchStateDefaults")
        if switchStateDefaults == true {
            mainSwitch.isOn = true
        }
        else {
            mainSwitch.isOn = false
        }
    mainSlider.value = UserDefaults.standard.float(forKey: "sliderValueNumber")
    sliderValue.text = "\(Int(mainSlider.value))"
    
}
    //смена картинки кнопкой из галереи
    
    @IBAction func changeImage(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
        
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
    

    @IBAction func changeImageCat(_ sender: UIButton) {
        mainImage.image = dictCat["Cat"] as? UIImage // смена картинки кнопкой Cat
    }
    
}
    
    
    
    
    
    
