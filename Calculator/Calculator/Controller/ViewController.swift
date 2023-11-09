//
//  ViewController.swift
//  Calculator
//
//  Created by Ashot Hovhannisyan on 05.08.23.
//

import UIKit

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === calcullatorSignsCollectionView {
            return self.dataModel.dataForFirstPad.count
        } else {
            return self.dataModel.dataForAdditionlaPad.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === calcullatorSignsCollectionView {
            let item = self.calcullatorSignsCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! CalculatorItemView
        
            item.setLabelSign(sign: self.dataModel.dataForFirstPad[indexPath.item])
            item.isUserInteractionEnabled = true
            
            switch item.getTheLabeltext() {
            case "AC","±","%":
                item.backgroundColor = .lightGray
                item.setLabelsTextColor(color: .black)
            case "x","+","-","=","÷":
                item.backgroundColor = .orange
            default:
                item.backgroundColor = .darkGray
            }
            
            switch item.getTheLabeltext() {
            case "0":
                item.layer.cornerRadius = 30
            default:
                item.layer.cornerRadius = item.bounds.width/2
            }
            return item
        } else {
            let item = additionalCalculatorCollectionView.dequeueReusableCell(withReuseIdentifier: "item1", for: indexPath) as! CalculatorItemView
            item.setLabelSign(sign: self.dataModel.dataForAdditionlaPad[indexPath.item])
            item.layer.cornerRadius = 10
            item.backgroundColor = .darkGray
            return item
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var number = self.resultLabel.text!
        if number.contains(",") {
            number.replace(",", with: ".")
        }
        if number.contains(" ") {
            number.removeAll(where: {$0 == " "})
        }
        if collectionView === calcullatorSignsCollectionView {
            let item = self.calcullatorSignsCollectionView.cellForItem(at: indexPath) as! CalculatorItemView
            switch item.getTheLabeltext() {
            case "0","1","2","3","4","5","6","7","8","9":
                self.staticAnimatorStarter = false
                UIView.animate(withDuration: 0.2){
                    item.backgroundColor = .gray
                    item.backgroundColor = .darkGray
                }
                self.swipeGestureLeft.isEnabled = true
                self.swipeGestureRight.isEnabled = true
                if reseterForComma == true {
                    self.resultLabel.text = "0"
                }
                if resultLabel.text!.first == "0" && !(resultLabel.text!.contains(",")){
                    self.resultLabel.text! = item.getTheLabeltext()
                } else {
                    self.resultLabel.text! += item.getTheLabeltext()
                }
                self.spacer()
                self.reseterForComma = false
            case "AC":
                self.staticAnimatorStarter = false
                UIView.animate(withDuration: 0.2){
                    item.backgroundColor = .white
                    item.backgroundColor = .lightGray
                }
                self.swipeGestureLeft.isEnabled = true
                self.swipeGestureRight.isEnabled = true
                resultLabel.text = "0"
                self.mathOperation = MathOperation()
                self.finalExpression = Expression()
            case "±":
                self.staticAnimatorStarter = false
                UIView.animate(withDuration: 0.2){
                    item.backgroundColor = .white
                    item.backgroundColor = .lightGray
                }
                self.swipeGestureLeft.isEnabled = true
                self.swipeGestureRight.isEnabled = true
                if resultLabel.text!.first != "-" && resultLabel.text != "0" {
                    resultLabel.text = ("-" + resultLabel.text!)
                } else {
                    if resultLabel.text != "0" {
                        resultLabel.text!.removeFirst()
                    }
                }
            case ",":
                self.staticAnimatorStarter = false
                UIView.animate(withDuration: 0.2){
                    item.backgroundColor = .gray
                    item.backgroundColor = .darkGray
                }
                self.swipeGestureLeft.isEnabled = true
                self.swipeGestureRight.isEnabled = true
                if !resultLabel.text!.contains(",") {
                    resultLabel.text! += ","
                }
            case "+":
                item.staticAnimationPerformance = true
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.finalExpression.mathExpression.last == ")"{
                    self.finalExpression.apendExpression(with: item.getTheLabeltext())
                    self.finalExpression.getOperator(operatorSymbol: item.getTheLabeltext())
                } else {
                    if Double(number)! < 0 {
                        number.removeFirst()
                        self.finalExpression.apendExpression(with: "<" + "_" + number + ">")
                        self.finalExpression.getOperand(operandSymbol: "<" + "_" + number + ">")
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                        self.finalExpression.getOperator(operatorSymbol:  item.getTheLabeltext())
                    } else {
                        self.finalExpression.apendExpression(with: number)
                        self.finalExpression.getOperand(operandSymbol: number)
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                        self.finalExpression.getOperator(operatorSymbol: item.getTheLabeltext())
                    }
                }
                self.reseterForReapetEqualPressing = true
                self.reseterForComma = true
            case "-":
                item.staticAnimationPerformance = true
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.finalExpression.mathExpression.last == ")"{
                    self.finalExpression.apendExpression(with: item.getTheLabeltext())
                    self.finalExpression.getOperator(operatorSymbol: item.getTheLabeltext())
                } else {
                    if Double(number)! < 0 {
                        number.removeFirst()
                        self.finalExpression.apendExpression(with: "<" + "_" + number + ">")
                        self.finalExpression.getOperand(operandSymbol: "<" + "_" + number + ">")
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                        self.finalExpression.getOperator(operatorSymbol:  item.getTheLabeltext())
                    } else {
                        self.finalExpression.apendExpression(with: number)
                        self.finalExpression.getOperand(operandSymbol: number)
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                        self.finalExpression.getOperator(operatorSymbol: item.getTheLabeltext())
                    }
                }
                self.reseterForReapetEqualPressing = true
                self.reseterForComma = true
            case "÷":
                item.staticAnimationPerformance = true
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.finalExpression.mathExpression.last == ")"{
                    self.finalExpression.apendExpression(with: item.getTheLabeltext())
                    self.finalExpression.getOperator(operatorSymbol: item.getTheLabeltext())
                } else {
                    if Double(number)! < 0 {
                        number.removeFirst()
                        self.finalExpression.apendExpression(with: "<" + "_" + number + ">")
                        self.finalExpression.getOperand(operandSymbol: "<" + "_" + number + ">")
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                        self.finalExpression.getOperator(operatorSymbol:  item.getTheLabeltext())
                    } else {
                        self.finalExpression.apendExpression(with: number)
                        self.finalExpression.getOperand(operandSymbol: number)
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                        self.finalExpression.getOperator(operatorSymbol: item.getTheLabeltext())
                    }
                }
                self.reseterForReapetEqualPressing = true
                self.reseterForComma = true
            case "x":
                item.staticAnimationPerformance = true
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.finalExpression.mathExpression.last == ")"{
                    self.finalExpression.apendExpression(with: item.getTheLabeltext())
                    self.finalExpression.getOperator(operatorSymbol: item.getTheLabeltext())
                } else {
                    if Double(number)! < 0 {
                        number.removeFirst()
                        self.finalExpression.apendExpression(with: "<" + "_" + number + ">")
                        self.finalExpression.getOperand(operandSymbol: "<" + "_" + number + ">")
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                        self.finalExpression.getOperator(operatorSymbol:  item.getTheLabeltext())
                    } else {
                        self.finalExpression.apendExpression(with: number)
                        self.finalExpression.getOperand(operandSymbol: number)
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                        self.finalExpression.getOperator(operatorSymbol: item.getTheLabeltext())
                    }
                }
                self.reseterForReapetEqualPressing = true
                self.reseterForComma = true
            case "%":
                self.staticAnimatorStarter = false
                UIView.animate(withDuration: 0.2){
                    item.backgroundColor = .white
                    item.backgroundColor = .lightGray
                }
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.mathOperation.operand1 != nil {
                    self.mathOperation.operand2 = Double(number)!
                    number = String(self.mathOperation.performance)
                }
                self.finalExpression = Expression()
                self.mathOperation.binaryOperation = .percentage
                self.mathOperation.operand1 = Double(number)!
                self.reseterForReapetEqualPressing = true
                self.reseterForComma = true
            default:
                self.staticAnimatorStarter = false
                UIView.animate(withDuration: 0.2){
                    item.backgroundColor = .white
                    item.backgroundColor = .orange
                }
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                self.mathOperation.operand2 = Double(number)!
                
                if reseterForReapetEqualPressing == true {
                    self.finalExpression.getOperand(operandSymbol: number)
                    computingFinalresulText(number: &number,checkAppendingResultNumber: true)
                } else {
                    self.finalExpression.resetMathExpression()
                    if Double(number)! < 0 {
                        number.removeFirst()
                        self.finalExpression.apendExpression(with: "<" + "_" + number + ">")
                    } else {
                        self.finalExpression.apendExpression(with: number)
                    }
                    self.finalExpression.repeatEqualPressing()
                    computingFinalresulText(number: &number,checkAppendingResultNumber: false)
                    self.reseterForReapetEqualPressing = false
                }
                self.finalExpression.resetMathExpression()
                self.mathOperation = MathOperation()
                self.reseterForReapetEqualPressing = false
                self.reseterForComma = true
            }
        }
        if collectionView === additionalCalculatorCollectionView {
            let item = self.additionalCalculatorCollectionView.cellForItem(at: indexPath) as! CalculatorItemView
            UIView.animate(withDuration: 0.2) {
                item.backgroundColor = .white
                item.backgroundColor = .darkGray
            }
            
            let radDegItem = self.additionalCalculatorCollectionView.cellForItem(at: IndexPath(row: 24, section: 0)) as! CalculatorItemView

            switch item.getTheLabeltext() {
            
            case "¹⁄ₓ":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .inverse
                self.unaryOperation()
                
            case "tan":
                self.staticAnimatorStarter = false
                if radDegItem.getTheLabeltext() == "Rad" {
                    self.mathOperationForAdditional.operand = Double(number)!
                    self.mathOperationForAdditional.unaryOperation = .tanges
                    self.unaryOperation()
                } else {
                    self.mathOperationForAdditional.operand = fromRadTodeg(number: Double(number)!)
                    self.mathOperationForAdditional.unaryOperation = .tanges
                    self.unaryOperation()
                }
                
            case "cos":
                self.staticAnimatorStarter = false
                if radDegItem.getTheLabeltext() == "Rad" {
                    self.mathOperationForAdditional.operand = Double(number)!
                    self.mathOperationForAdditional.unaryOperation = .cosinus
                    self.unaryOperation()
                } else {
                    self.mathOperationForAdditional.operand = fromRadTodeg(number: Double(number)!)
                    self.mathOperationForAdditional.unaryOperation = .cosinus
                    self.unaryOperation()
                }
                
            case "sin":
                self.staticAnimatorStarter = false
                if radDegItem.getTheLabeltext() == "Rad" {
                    self.mathOperationForAdditional.operand = Double(number)!
                    self.mathOperationForAdditional.unaryOperation = .sinus
                    self.unaryOperation()
                } else {
                    self.mathOperationForAdditional.operand = fromRadTodeg(number: Double(number)!)
                    self.mathOperationForAdditional.unaryOperation = .sinus
                    self.unaryOperation()
                }
            
            case "tanh":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .tangesHiperbolique
                self.unaryOperation()
                
            case "sinh":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .sinusHyperbilique
                self.unaryOperation()
            case "cosh":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .cosinusHyperbolique
                self.unaryOperation()
                
            case "x²":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .square
                self.unaryOperation()
                
            case "x³":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .cube
                self.unaryOperation()
                
            case "√x":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .squareRoot
                self.unaryOperation()
                
            case "³√x":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .cubeRoot
                self.unaryOperation()
                
            case "10ˣ":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .degreeOf10
                self.unaryOperation()
                
            case "log₁₀":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .log
                self.unaryOperation()
                
            case "ln":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .naturalLogarithm
                self.unaryOperation()
                
            case "x!":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .factorial
                self.unaryOperation()
                
            case "e":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .e
                self.unaryOperation()
                
            case "𝞹":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .pi
                self.unaryOperation()
                
            case "EE":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .EE
                self.unaryOperation()
                
            case "eˣ":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .exponentialDegree
                self.unaryOperation()
                
            case "Rand":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .Rand
                self.unaryOperation()
                
            case "mr":
                self.staticAnimatorStarter = false
                var textresult = String(self.calculatorMemoryRegister)
                if abs(Double(Int(self.calculatorMemoryRegister)) - self.calculatorMemoryRegister) == 0 {
                    textresult = String(Int(self.calculatorMemoryRegister))
                } else {
                    textresult.replace(".", with: ",")
                }
                self.reseterForComma = true
                resultLabel.text = textresult
                
            case "m-":
                self.staticAnimatorStarter = false
                self.calculatorMemoryRegister -= Double(number)!
                
            case "m+":
                self.staticAnimatorStarter = false
                self.calculatorMemoryRegister += Double(number)!
                
            case "mc":
                self.staticAnimatorStarter = false
                self.calculatorMemoryRegister = 0
                
            case "Deg":
                self.staticAnimatorStarter = false
                item.setLabelSign(sign: "Rad")
                
            case "Rad":
                self.staticAnimatorStarter = false
                item.setLabelSign(sign: "Deg")
                
            case "xʸ":
                self.staticAnimatorStarter = false
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.mathOperation.operand1 != nil {
                    self.mathOperation.operand2 = Double(number)!
                    number = String(self.mathOperation.performance)
                }
                self.mathOperation.binaryOperation = .xPowy
                self.mathOperation.operand1 = Double(number)!
                self.reseterForComma = true
                self.reseterForReapetEqualPressing = true
            case "ʸ√x":
                self.staticAnimatorStarter = false
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.mathOperation.operand1 != nil {
                    self.mathOperation.operand2 = Double(number)!
                    number = String(self.mathOperation.performance)
                }
                self.mathOperation.binaryOperation = .yRootX
                self.mathOperation.operand1 = Double(number)!
                self.reseterForComma = true
                self.reseterForReapetEqualPressing = true

            case "2ⁿᵈ":
                self.staticAnimatorStarter = false
                item.setLabelSign(sign: "1ⁿᵈ")
                self.secondPad()
                
            case "1ⁿᵈ":
                self.staticAnimatorStarter = false
                item.setLabelSign(sign: "2ⁿᵈ")
                additionalCalculatorCollectionView.reloadData()
                
            case "yˣ":
                self.staticAnimatorStarter = false
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.mathOperation.operand1 != nil {
                    self.mathOperation.operand2 = Double(number)!
                    number = String(self.mathOperation.performance)
                }
                self.mathOperation.binaryOperation = .yPowx
                self.mathOperation.operand1 = Double(number)!
                self.reseterForComma = true
                self.reseterForReapetEqualPressing = true

            case "2ˣ":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .twoPowX
                self.unaryOperation()
                
            case "log₂":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .logTwo
                self.unaryOperation()
                
            case "logy":
                self.staticAnimatorStarter = false
                self.swipeGestureLeft.isEnabled = false
                self.swipeGestureRight.isEnabled = false
                if self.mathOperation.operand1 != nil {
                    self.mathOperation.operand2 = Double(number)!
                    number = String(self.mathOperation.performance)
                }
                self.mathOperation.binaryOperation = .yLogx
                self.mathOperation.operand1 = Double(number)!
                self.reseterForComma = true
                self.reseterForReapetEqualPressing = true
            case "sin⁻¹":
                self.staticAnimatorStarter = false
                if radDegItem.getTheLabeltext() == "Rad" {
                    self.mathOperationForAdditional.operand = Double(number)!
                    self.mathOperationForAdditional.unaryOperation = .sinInverse
                    self.unaryOperation()
                } else {
                    self.mathOperationForAdditional.operand = fromRadTodeg(number: Double(number)!)
                    self.mathOperationForAdditional.unaryOperation = .sinInverse
                    self.unaryOperation()
                }
                
            case "cos⁻¹":
                self.staticAnimatorStarter = false
                if radDegItem.getTheLabeltext() == "Rad" {
                    self.mathOperationForAdditional.operand = Double(number)!
                    self.mathOperationForAdditional.unaryOperation = .cosInverse
                    self.unaryOperation()
                } else {
                    self.mathOperationForAdditional.operand = fromRadTodeg(number: Double(number)!)
                    self.mathOperationForAdditional.unaryOperation = .cosInverse
                    self.unaryOperation()
                }
                
            case "tan⁻¹":
                self.staticAnimatorStarter = false
                if radDegItem.getTheLabeltext() == "Rad" {
                    self.mathOperationForAdditional.operand = Double(number)!
                    self.mathOperationForAdditional.unaryOperation = .tanInverse
                    self.unaryOperation()
                } else {
                    self.mathOperationForAdditional.operand = fromRadTodeg(number: Double(number)!)
                    self.mathOperationForAdditional.unaryOperation = .sinInverse
                    self.unaryOperation()
                }
                
            case "sinh⁻¹":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .sinhInverse
                self.unaryOperation()
                
            case "cosh⁻¹":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .coshInverse
                self.unaryOperation()
                
            case "tanh⁻¹":
                self.staticAnimatorStarter = false
                self.mathOperationForAdditional.operand = Double(number)!
                self.mathOperationForAdditional.unaryOperation = .tanhInverse
                self.unaryOperation()
                
            case "(":
                self.staticAnimatorStarter = false
                if self.finalExpression.mathExpression.last != nil {
                    if !self.finalExpression.mathExpression.last!.isNumber {
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                    }
                } else {
                    self.finalExpression.apendExpression(with: item.getTheLabeltext())
                }
                
            case ")":
                self.staticAnimatorStarter = false
                if self.finalExpression.mathExpression.last != nil {
                    if !self.finalExpression.mathExpression.last!.isNumber {
                        if Double(number)! < 0 {
                            number.removeFirst()
                            self.finalExpression.apendExpression(with: "<" + "_" + number + ">")
                        } else {
                            self.finalExpression.apendExpression(with: number)
                        }
                        self.finalExpression.apendExpression(with: item.getTheLabeltext())
                    }
                }
                
            default:
                break
            
            }
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView === calcullatorSignsCollectionView {
            return 15
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === calcullatorSignsCollectionView{
            let layoutInsets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
            var initialWidth = calcullatorSignsCollectionView.bounds.width - layoutInsets.right*2
            let itemSpacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.item)
            initialWidth -= 3 * itemSpacing
            
            let lineSpace = self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: indexPath.item)
            let initialHeight = calcullatorSignsCollectionView.bounds.height - (4*lineSpace +
                                                                                2*layoutInsets.bottom)
            
            switch indexPath.item {
            case 16:
                return CGSize(width: ((initialWidth/4)*2 + itemSpacing) - 0.1, height: initialHeight/5 - 0.1)
            default:
                return CGSize(width: initialWidth/4 - 0.1, height: initialHeight/5 - 0.1)
            }
        } else {
            let layoutInsets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
            var initialWidth = additionalCalculatorCollectionView.bounds.width - layoutInsets.right*2
            let itemSpacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.item)
            initialWidth -= 5 * itemSpacing
            
            let lineSpace = self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: indexPath.item)
            let initialHeight = additionalCalculatorCollectionView.bounds.height - (4*lineSpace + 2*layoutInsets.bottom)
            
                return CGSize(width: initialWidth/6 - 0.1, height: initialHeight/5 - 0.1)
            }
    }
    
}

final class ViewController: UIViewController {
    
    private var calculatorMemoryRegister:Double = 0
    
    private var mathOperation = MathOperation()
    
    private var finalExpression: Expression = Expression()
    
    private var mathOperationForAdditional = MathOperationForAdditionalCalculator()
    
    private var additionalCalculatorCollectionView: UICollectionView!
    
    private var additionalCalculatorFlowLayout = UICollectionViewFlowLayout()
    
    private var reseterForReapetEqualPressing: Bool = false
    
    private var staticAnimatorStarter: Bool {
        get {
            return false
        }
        set {
            staticAnimationHandler(checker: newValue)
        }
    }
    
    private var reseterForComma: Bool = false
    
    private let swipeGestureRight = UISwipeGestureRecognizer()

    private var calculatorCollectionViewConstraints:[NSLayoutConstraint]?
    
    private var additionalCalculatorCollectionViewConstraints:[NSLayoutConstraint]?
    
    private let swipeGestureLeft = UISwipeGestureRecognizer()
    
    private let resultLabel:UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.font = .systemFont(ofSize: 80)
        label.textAlignment = .right
        label.textColor = .white
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byCharWrapping
        label.text = "0"
        return label
    }()
    
    private let dataModel = DataModelForCalculator()
    
    private let collectionViewLayout = UICollectionViewFlowLayout()

    private var calcullatorSignsCollectionView:UICollectionView!
    
    private var orientation:UIInterfaceOrientationMask = .portrait
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        calcullatorSignsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        calcullatorSignsCollectionView.backgroundColor = .black
        calcullatorSignsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        calcullatorSignsCollectionView.isScrollEnabled = false
        
        calcullatorSignsCollectionView.delegate = self
        calcullatorSignsCollectionView.dataSource = self
        
        calcullatorSignsCollectionView.register(CalculatorItemView.self, forCellWithReuseIdentifier: "item")
        
        view.addSubview(resultLabel)
        
        view.addSubview(calcullatorSignsCollectionView)
        
        additionalCalculatorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: additionalCalculatorFlowLayout)
        additionalCalculatorCollectionView.backgroundColor = .black
        additionalCalculatorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        additionalCalculatorCollectionView.isScrollEnabled = false
        additionalCalculatorCollectionView.register(CalculatorItemView.self, forCellWithReuseIdentifier: "item1")
        additionalCalculatorCollectionView.dataSource = self
        additionalCalculatorCollectionView.delegate = self
        
        view.addSubview(additionalCalculatorCollectionView)
        
        let edgeInsets = self.collectionView(calcullatorSignsCollectionView, layout: collectionViewLayout, insetForSectionAt: calcullatorSignsCollectionView.numberOfSections - 1)
        
        self.calculatorCollectionViewConstraints = [
            resultLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            resultLabel.rightAnchor.constraint(equalTo: calcullatorSignsCollectionView.rightAnchor,constant: -edgeInsets.right),
            resultLabel.bottomAnchor.constraint(equalTo: calcullatorSignsCollectionView.topAnchor,constant: 5),
            calcullatorSignsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calcullatorSignsCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            calcullatorSignsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            calcullatorSignsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor,constant: -110),
            ]
        
        self.additionalCalculatorCollectionViewConstraints = [
            additionalCalculatorCollectionView.topAnchor.constraint(equalTo: calcullatorSignsCollectionView.topAnchor),
            additionalCalculatorCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            additionalCalculatorCollectionView.rightAnchor.constraint(equalTo: calcullatorSignsCollectionView.leftAnchor,constant: -5),
            additionalCalculatorCollectionView.bottomAnchor.constraint(equalTo: calcullatorSignsCollectionView.bottomAnchor),
            calcullatorSignsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calcullatorSignsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            calcullatorSignsCollectionView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor,constant: 5),
            calcullatorSignsCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            resultLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            resultLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ]

        layoutConfiguiring()

        swipeGestureLeft.numberOfTouchesRequired = 1
        swipeGestureLeft.direction = .left
        swipeGestureRight.direction = .right
        swipeGestureLeft.addTarget(self, action: #selector(swipeGestureHandler))
        swipeGestureRight.addTarget(self, action: #selector(swipeGestureHandler))
        resultLabel.addGestureRecognizer(swipeGestureLeft)
        resultLabel.addGestureRecognizer(swipeGestureRight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        layoutConfiguiring() // in viewDidLoad i operate on visible cells and forget that in viewDidLoad nothing is visible, so I deside call this function also there
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.layoutConfiguiring()
    }
    
    @objc func swipeGestureHandler(sender gesture: UISwipeGestureRecognizer) {
        if resultLabel.text!.count >= 2 {
            resultLabel.text!.removeLast()
        } else {
            resultLabel.text! = "0"
        }
    }
    
    private func spacer() {
        if self.resultLabel.text!.count % 4 == 0 && self.resultLabel.text!.count != 0 && !self.resultLabel.text!.contains(",") {
            resultLabel.text!.insert(" ", at:self.resultLabel.text!.index(self.resultLabel.text!.endIndex, offsetBy: -3) )
        }
    }
    
    private func staticSpacer(_ string:inout String) -> String {
        if string.count>3 && !string.contains(",") {
            var result = string
            for i in 0..<string.count {
                if i%4 == 1 {
                    result.insert(" ", at: result.index(string.startIndex, offsetBy: i))
                }
            }
            string = result
        }
        return string
    }
    
    private func layoutConfiguiring() {
        if UIDevice.current.orientation.isLandscape {
            self.additionalCalculatorCollectionView.isHidden = false
            NSLayoutConstraint.deactivate(self.calculatorCollectionViewConstraints!)
            NSLayoutConstraint.activate(additionalCalculatorCollectionViewConstraints!)
            let indexPaths = self.calcullatorSignsCollectionView.indexPathsForVisibleItems
            for i in indexPaths {
                let item = self.calcullatorSignsCollectionView.cellForItem(at: i) as! CalculatorItemView
                item.layer.cornerRadius = 10
            }
            self.collectionViewLayout.invalidateLayout()
            self.additionalCalculatorFlowLayout.invalidateLayout()
           } else if UIDevice.current.orientation.isPortrait {
               additionalCalculatorCollectionView.isHidden = true
               NSLayoutConstraint.deactivate(additionalCalculatorCollectionViewConstraints!)
               NSLayoutConstraint.activate(self.calculatorCollectionViewConstraints!)
               self.collectionViewLayout.invalidateLayout()
               self.additionalCalculatorFlowLayout.invalidateLayout()
               for indexPath in calcullatorSignsCollectionView.indexPathsForVisibleItems {
                   let item = calcullatorSignsCollectionView.cellForItem(at: indexPath) as! CalculatorItemView
                   switch indexPath.item {
                   case 16:
                       item.layer.cornerRadius = 30
                   default:
                       item.layer.cornerRadius = item.bounds.width/2
                   }
               }
           } else if UIDevice.current.orientation.isFlat {
               additionalCalculatorCollectionView.isHidden = true
               NSLayoutConstraint.deactivate(additionalCalculatorCollectionViewConstraints!)
               NSLayoutConstraint.activate(self.calculatorCollectionViewConstraints!)
               self.collectionViewLayout.invalidateLayout()
               self.additionalCalculatorFlowLayout.invalidateLayout()
               for indexPath in calcullatorSignsCollectionView.indexPathsForVisibleItems {
                   let item = calcullatorSignsCollectionView.cellForItem(at: indexPath) as! CalculatorItemView
                   switch indexPath.item {
                   case 16:
                       item.layer.cornerRadius = 30
                   default:
                       if view.bounds.height >= 1000 {
                           item.layer.cornerRadius = item.bounds.width/2 - 60
                       } else {
                           item.layer.cornerRadius = item.bounds.width/2 - 5
                       }
                   }
               }
           } else {
               if view.bounds.height >= view.bounds.width {
                   additionalCalculatorCollectionView.isHidden = true
                   NSLayoutConstraint.deactivate(additionalCalculatorCollectionViewConstraints!)
                   NSLayoutConstraint.activate(self.calculatorCollectionViewConstraints!)
                   self.collectionViewLayout.invalidateLayout()
                   self.additionalCalculatorFlowLayout.invalidateLayout()
                   for indexPath in calcullatorSignsCollectionView.indexPathsForVisibleItems {
                       let item = calcullatorSignsCollectionView.cellForItem(at: indexPath) as! CalculatorItemView
                       switch indexPath.item {
                       case 16:
                           item.layer.cornerRadius = 30
                       default:
                           if view.bounds.height >= 1000 {
                               item.layer.cornerRadius = item.bounds.width/2 - 60
                           } else {
                               item.layer.cornerRadius = item.bounds.width/2 - 5
                           }
                       }
                   }
               } else {
                   self.additionalCalculatorCollectionView.isHidden = false
                   NSLayoutConstraint.deactivate(self.calculatorCollectionViewConstraints!)
                   NSLayoutConstraint.activate(additionalCalculatorCollectionViewConstraints!)
                   let indexPaths = self.calcullatorSignsCollectionView.indexPathsForVisibleItems
                   for i in indexPaths {
                       let item = self.calcullatorSignsCollectionView.cellForItem(at: i) as! CalculatorItemView
                       item.layer.cornerRadius = 10
                   }
                   self.collectionViewLayout.invalidateLayout()
                   self.additionalCalculatorFlowLayout.invalidateLayout()
               }
           }
    }
   
    private func unaryOperation() {
        let result = self.mathOperationForAdditional.pervormanceResult
        if !result.isInfinite && !result.isNaN && result <= Double(Int.max) {
            if result - Double(Int(result)) > 0 {
                var returnedString = String(result).replacing(".", with: ",")
                self.resultLabel.text = staticSpacer(&returnedString)
            } else {
                var returnedString = String(Int(result))
                self.resultLabel.text = staticSpacer(&returnedString)
            }
        } else {
            self.resultLabel.text = String(result)
        }
    }
  
    private func fromRadTodeg(number:Double) -> Double {
        Double.pi/(180/number)
    }
    
    private func computingFinalresulText(number:inout String,checkAppendingResultNumber:Bool) {
        if self.finalExpression.mathExpression != "" {
            if checkAppendingResultNumber == true {
                if Double(number)! < 0 {
                    number.removeFirst()
                    self.finalExpression.apendExpression(with: "<" + "_" + number + ">")
                } else {
                    self.finalExpression.apendExpression(with: number)
                }
            }
            self.finalExpression.apendExpression(with: " ")
            print(finalExpression.mathExpression)
            var exp = ExpressionComputer(expression: self.finalExpression)
            let textResult = exp.computer()
            if !textResult.isInfinite && !textResult.isNaN && textResult <= Double(Int.max) {
                if abs(abs(textResult) - Double(Int(abs(textResult)))) > 0 {
                    var returnedString = String(textResult).replacing(".", with: ",")
                    self.resultLabel.text = staticSpacer(&returnedString)
                } else {
                    var returnedString = String(Int(textResult))
                    self.resultLabel.text = staticSpacer(&returnedString)
                }
            } else {
                self.resultLabel.text = String(textResult)
            }
        } else {
            self.mathOperation.operand2 = Double(number)!
            let result = self.mathOperation.performance
            if !result.isInfinite && !result.isNaN && result <= Double(Int.max) {
                if abs(abs(result) - Double(Int(abs(result)))) > 0 {
                    var returnedString = String(result).replacing(".", with: ",")
                    self.resultLabel.text = staticSpacer(&returnedString)
                } else {
                    var returnedString = String(Int(result))
                    self.resultLabel.text = staticSpacer(&returnedString)
                }
            } else {
                self.resultLabel.text = String(result)
            }
        }
    }
    
    private func secondPad() {
        
        let indexPaths = self.additionalCalculatorCollectionView.indexPathsForVisibleItems
        for i in indexPaths {
            
            let item = additionalCalculatorCollectionView.cellForItem(at: i) as! CalculatorItemView
            
            switch item.getTheLabeltext() {
            
            case "eˣ":
                item.setLabelSign(sign: "yˣ")
                
            case "10ˣ":
                item.setLabelSign(sign: "2ˣ")

            case "ln":
                item.setLabelSign(sign: "log₂")

            case "log₁₀":
                item.setLabelSign(sign: "logy")

            case "sin":
                item.setLabelSign(sign: "sin⁻¹")

            case "cos":
                item.setLabelSign(sign: "cos⁻¹")

            case "tan":
                item.setLabelSign(sign: "tan⁻¹")

            case "sinh":
                item.setLabelSign(sign: "sinh⁻¹")

            case "cosh":
                item.setLabelSign(sign: "cosh⁻¹")

            case "tanh":
                item.setLabelSign(sign: "tanh⁻¹")

            default:
                break
                
            }
        }
    }
    
    private func staticAnimationHandler(checker:Bool) {// items are ref type
        for i in self.calcullatorSignsCollectionView.visibleCells {
            let item = i as! CalculatorItemView
                switch item.getTheLabeltext() {
                case "+","-","x","÷":
                    if item.staticAnimationPerformance != checker {
                        item.staticAnimationPerformance = checker
                    }
                default:
                    break
            }
        }
    }
}

