//
//  DataModel.swift
//  Calculator
//
//  Created by Ashot Hovhannisyan on 05.08.23.
//

import Foundation

struct DataModelForCalculator {
    let dataForFirstPad:[String] = ["AC","±","%","÷","7","8","9","x","4","5","6","-","1","2","3","+","0",",","="]
    let dataForAdditionlaPad:[String] = ["(",")","mc","m+","m-","mr","2ⁿᵈ","x²",
                                                       "x³","xʸ","eˣ","10ˣ","¹⁄ₓ","√x","³√x","ʸ√x","ln","log₁₀","x!","sin","cos","tan","e","EE","Rad","sinh","cosh","tanh","𝞹","Rand"]
}

enum OperandsOperatorsBracesAndSigns:String {
    case removeTect = "AC"
    case signInverse = "±"
    case equal = "="
    case zero = "0"
    case one = "1"
    case two = "2"
    case tree = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case sinus = "sin"
    case cosinus = "cos"
    case tanges = "tan"
    case sinusHyperbilique = "sinh"
    case cosinusHyperbolique = "cosh"
    case tangesHiperbolique = "tanh"
    case inverse = "¹⁄ₓ"
    case squareRoot = "√x"
    case square = "x²"
    case cube = "x³"
    case e = "e"
    case exponentialDegree = "eˣ"
    case degreeOf10 = "10ˣ"
    case cubeRoot = "³√x"
    case pi = "𝞹"
    case naturalLogarithm = "ln"
    case log = "log₁₀"
    case factorial = "x!"
    case EE = "EE"
    case Rand = "Rand"
    case sinInverse = "sin⁻¹"
    case cosInverse = "cos⁻¹"
    case tanInverse = "tan⁻¹"
    case sinhInverse = "sinh⁻¹"
    case coshInverse = "cosh⁻¹"
    case tanhInverse = "tanh⁻¹"
    case twoPowX = "2ˣ"
    case logTwo = "log₂"
    case addition = "+"
    case substraction = "-"
    case multiplication = "x"
    case division = "÷"
    case percentage = "%"
    case xPowy = "xʸ"
    case yRootX = "ʸ√x"
    case yPowx = "yˣ"
    case yLogx = "logy"
    case openBrace = "("
    case closeBrace = ")"
    case memoryRegisterClean = "mc"
    case memoryRegidter = "mr"
    case memoryRegisterPlus = "m+"
    case memoryRegisterMinus = "m-"
    case secondAdditionalPad = "2ⁿᵈ"
    case radSign = "Rad"
    case degSign = "Deg"
    case comma = ","
}
