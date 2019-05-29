//
//  ViewController.swift
//  Coffee Calculator
//
//  Created by Brett on 7/25/18.
//  Copyright © 2018 Apt 5 Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var lblTitleOUTLET: UILabel!
    @IBOutlet weak var sgtRecipeChoiceOUTLET: UISegmentedControl!
    @IBOutlet weak var lblHowMuchOUTLET: UILabel!
    @IBOutlet weak var txtWaterInMLOUTLET: UITextField!
    @IBOutlet weak var txtRatioOUTLET: UITextField!
    @IBOutlet weak var btnCalculateOUTLET: UIButton!
    @IBOutlet weak var lblWhatIsNeededOUTLET: UILabel!

    
    var waterdesiredF : Double?
    var desiredratioP : Double?
    var waterdesiredT : Double?
    var waterdesiredP : Double?
    var waterneeded : Double?
    var coffeeneeded : Double?
    var iceneeded : Double?
    var recipetype : String = "Toddy"
    var ToddyRatio : Double = 1.4746
    var FiltronRatio : Double = 1.3633
    var ToddyWaterRatio : Double = 4.87
    var FiltronWaterRatio : Double = 4.405
    var pourOverRatio : Double = 1.49
    var iceRatio : Double = 2.03
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //init toolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func RecipeChoiceACTION(_ sender: UISegmentedControl) {
        switch sgtRecipeChoiceOUTLET.selectedSegmentIndex {
        case 0:
            recipetype = "Toddy"
            txtWaterInMLOUTLET.placeholder = "Water wanted in ml"
            txtRatioOUTLET.placeholder = "Only for Pour-Over & Iced"
            txtRatioOUTLET.isUserInteractionEnabled = false
        case 1:
            recipetype = "Filtron"
            txtWaterInMLOUTLET.placeholder = "Water wanted in ml"
            txtRatioOUTLET.placeholder = "Only for Pour-Over & Iced"
        case 2:
            recipetype = "Iced"
            txtWaterInMLOUTLET.placeholder = "Water wanted in ml"
            txtRatioOUTLET.placeholder = "At what ratio? (1:x)"
        case 3:
            recipetype = "Pour-Over"
            txtWaterInMLOUTLET.placeholder = "Water wanted in ml"
            txtRatioOUTLET.placeholder = "At what ratio? (1:x)"
        default:
            recipetype = "Toddy"
        }
    }
    @IBAction func pressCalculateACTION(_ sender: UIButton) {
        switch recipetype {
        case "Toddy":
            if (assignToddyVariables() == true){
                calculateToddy()
                dispayNeededMaterial()
                self.view.endEditing(true)
            }
        case "Filtron":
            if (assignFiltronVariables() == true){
                calculateFiltron()
                dispayNeededMaterial()
                self.view.endEditing(true)
            }
        case "Iced":
            if (assignPourOverVariables() == true){
                calculateIced()
                dispayNeededMaterialIced()
                self.view.endEditing(true)
            }
        case "Pour-Over":
            if (assignPourOverVariables() == true){
                calculatePourOver()
                dispayNeededMaterialPour_Over()
                self.view.endEditing(true)
            }
        default:
            break
        }
    }
    func assignFiltronVariables() -> Bool {
        if (!txtWaterInMLOUTLET.hasText){
        return false
        }else{
        waterdesiredF = Double(txtWaterInMLOUTLET.text!)
        }
        return true
    }
    
    func assignToddyVariables()-> Bool {
        if (!txtWaterInMLOUTLET.hasText){
            return false
        } else {
        waterdesiredT = Double(txtWaterInMLOUTLET.text!)
        }
        return true
    }
    
    func assignPourOverVariables()-> Bool{
        if (!txtWaterInMLOUTLET.hasText || !txtRatioOUTLET.hasText){
            return false
        } else{
        waterdesiredP = Double(txtWaterInMLOUTLET.text!)
        desiredratioP = Double(txtRatioOUTLET.text!)
        }
        return true
    }
    //Calculate cold brew based on Toddy recipe and ratio.
    func calculateToddy(){
        waterneeded = round((waterdesiredT!*ToddyRatio)*10)/10
        coffeeneeded = round((waterneeded!/ToddyWaterRatio)*10)/10
        
}
    //Calculate cold brew based on Filtron recipe and ratio.
    func calculateFiltron(){
        waterneeded = round((waterdesiredF!*FiltronRatio)*10)/10
        coffeeneeded = round((waterneeded!/FiltronWaterRatio)*10)/10
        
}
    //Calculate Iced Coffee Pour Over based on the Japanese method.
    func calculateIced(){
        waterneeded = round((waterdesiredP!/pourOverRatio)*10)/10
        coffeeneeded = round((waterdesiredP!/desiredratioP!)*10)/10
        iceneeded = round((waterdesiredP!-waterneeded!)*10)/10
        
}
    func calculatePourOver(){
        coffeeneeded = round((waterdesiredP!/desiredratioP!)*10)/10
    
}
    //display what you need for Toddy and Filtron
    func dispayNeededMaterial(){
        lblWhatIsNeededOUTLET.text = "What you need is " + String(waterneeded!) + " mL water \nwith " + String(coffeeneeded!) + " gm coffee"
    }
    
    //display for Pour-Over
    func dispayNeededMaterialIced(){
        lblWhatIsNeededOUTLET.text = "What you need is " + String(waterneeded!) + " mL water \nwith " + String(coffeeneeded!) + " gm coffee and \n" + String(iceneeded!) + " gm of ice."
    }
    func dispayNeededMaterialPour_Over(){
        lblWhatIsNeededOUTLET.text = "What you need is " + String(waterdesiredP!) + " mL water \nwith " + String(coffeeneeded!) + " gm coffee"
    }

}
