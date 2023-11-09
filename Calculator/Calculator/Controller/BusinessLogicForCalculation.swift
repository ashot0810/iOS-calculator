//
//  BusinessLogicForCalculation.swift
//  Calculator
//
//  Created by Ashot Hovhannisyan on 13.09.23.
//

import Foundation

struct MathOperation {
    
    var operand1:Double?
    
    var operand2:Double?
        
    var binaryOperation:OperandsOperatorsBracesAndSigns? = nil
    
    var performance: Double {
        guard let operand1 = self.operand1 , let operation = self.binaryOperation, let operand2 = self.operand2 else {
            return self.operand1!
        }
        
        switch operation {
            
        case .addition:
            return operand1 + operand2
            
        case .substraction:
            return operand1 - operand2
            
        case .division:
            return operand1 / operand2
            
        case .multiplication:
            return operand1 * operand2
            
        case .percentage:
            return (operand1 * operand2)/100
            
        case .xPowy:
            return pow(operand1,operand2)
            
        case .yRootX:
            return pow(operand1,1/operand2)
            
        case .yPowx:
            return pow(operand2, operand1)
            
        case .yLogx:
            return (log(operand1)/log(operand2))
        
        default:
            return 0
        }
        
    }

}

struct MathOperationForAdditionalCalculator {
    
    var operand:Double?
    
    var unaryOperation:OperandsOperatorsBracesAndSigns? = nil
    
    var pervormanceResult:Double {
        guard let operand = self.operand , let operation = self.unaryOperation else {
            return self.operand!
        }
        
        switch operation {
        case .sinus:
            return sin(operand)
            
        case .cosinus:
            return cos(operand)
            
        case .tanges:
            return tan(operand)
            
        case .sinusHyperbilique:
            return sinh(operand)
            
        case .cosinusHyperbolique:
            return cosh(operand)
            
        case .tangesHiperbolique:
            return tanh(operand)
            
        case .square:
            return pow(operand,2)
            
        case .cube:
            return pow(operand, 3)
            
        case .squareRoot:
            return pow(operand,1/2)
            
        case .cubeRoot:
            return pow(operand,1/3)
            
        case .inverse:
            print(1/operand)
            return 1/operand
            
        case .degreeOf10:
            return pow(10,operand)
            
        case .exponentialDegree:
            return exp(operand)
            
        case .naturalLogarithm:
            return log(operand)
            
        case .log:
            return log10(operand)
            
        case .factorial:
            if operand - Double(Int(operand)) > 0 && operand == 0 {
                return 1
            } else {
                if operand <= 20 {
                    var result = 1
                    for i in 2...Int(operand) {
                        result*=i
                    }
                    return Double(result)
                } else {
                    return Double.infinity
                }
            }
            
        case .e:
            return exp(1)
            
        case .pi:
            return Double.pi
            
        case .EE:
            return operand*pow(10,operand)
            
        case .Rand:
            return Double.random(in: 0...1)
            
        case .sinInverse:
            return pow(sin(operand),-1)
            
        case .cosInverse:
            return pow(cos(operand),-1)
            
        case .tanInverse:
            return pow(tan(operand),-1)
            
        case .sinhInverse:
            return pow(sinh(operand),-1)
            
        case .coshInverse:
            return pow(cosh(operand),-1)
            
        case .tanhInverse:
            return pow(cosh(operand),-1)
            
        case .twoPowX:
            return pow(2,operand)
            
        case .logTwo:
            return log2(operand)
        
        default:
            return 0
        }
    }
    
}

struct Expression {
    private(set) var mathExpression: String = ""
    private(set) var lastOperator: String = ""
    private(set) var lastOperand: String = ""
    
    mutating func apendExpression(with symbol:String) {
        self.mathExpression += symbol
    }
    
    mutating func getOperator(operatorSymbol:String) {
        self.lastOperator = operatorSymbol
    }
    
    mutating func getOperand(operandSymbol:String) {
        self.lastOperand = operandSymbol
    }
    
    mutating func repeatEqualPressing() {
        mathExpression+=(lastOperator+lastOperand)
    }
    
    mutating func resetMathExpression() {
        self.mathExpression =  ""
    }
}

struct ExpressionComputer {
    private var expression:Expression = Expression()
    private var expressionAsString:String = ""
    private var stackOfNumbers:Stack<Double> = Stack<Double>()
    private var stackOperators:Stack<OperandsOperatorsBracesAndSigns> = Stack<OperandsOperatorsBracesAndSigns>()
    
    init(expression: Expression) {
        self.expression = expression
        self.expressionAsString = self.expression.mathExpression
    }

    mutating func computer() -> Double {
        if self.expressionAsString.contains("(") {
            if !expressionAsString.contains(")") {
                return Double.nan
            }
        } else {
            if expressionAsString.contains(")") {
                return Double.nan
            }
        }
        var number:String = ""
        for i in expressionAsString {
            if i.isNumber || i == "." || i == "<" || i == ">" || i == "_" {
                number+=String(i)
            } else {
                if number != "" {
                    if number.contains(">") || number.contains("<") {
                        number.removeAll(where: {$0 == "<" || $0 == ">"})
                        number.replace("_", with: "-")
                        stackOfNumbers.push(Double(number)!)
                    } else {
                        stackOfNumbers.push(Double(number)!)
                    }
                }
                number = ""
                switch i {
                case "+":
                    if stackOperators.isEmpty() {
                        stackOperators.push(OperandsOperatorsBracesAndSigns.addition)
                    } else {
                        
                        if stackOperators.top()! == .openBrace {
                            stackOperators.push(OperandsOperatorsBracesAndSigns.addition)
                        } else if stackOperators.top()! == .substraction {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .substraction
                            stackOperators.pop()
                            stackOperators.push(.addition)
                            stackOfNumbers.push(mathOP.performance)
                        }  else if stackOperators.top()! == .addition {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .addition
                            stackOperators.pop()
                            stackOperators.push(.addition)
                            stackOfNumbers.push(mathOP.performance)
                        } else if stackOperators.top()! == .multiplication {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .multiplication
                            stackOperators.pop()
                            stackOperators.push(.addition)
                            stackOfNumbers.push(mathOP.performance)
                            
                        } else {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .division
                            stackOperators.pop()
                            stackOperators.push(.addition)
                            stackOfNumbers.push(mathOP.performance)
                        }
                    }
                case "-":
                    if stackOperators.isEmpty() {
                        stackOperators.push(OperandsOperatorsBracesAndSigns.substraction)
                    } else {
                        
                        if stackOperators.top()! == .openBrace {
                            stackOperators.push(OperandsOperatorsBracesAndSigns.substraction)
                        } else if stackOperators.top()! == .substraction {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .substraction
                            stackOperators.pop()
                            stackOperators.push(.substraction)
                            stackOfNumbers.push(mathOP.performance)
                        }  else if stackOperators.top()! == .addition {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .addition
                            stackOperators.pop()
                            stackOperators.push(.substraction)
                            stackOfNumbers.push(mathOP.performance)
                        } else if stackOperators.top()! == .multiplication {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .multiplication
                            stackOperators.pop()
                            stackOperators.push(.substraction)
                            stackOfNumbers.push(mathOP.performance)
                            
                        } else {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .division
                            stackOperators.pop()
                            stackOperators.push(.substraction)
                            stackOfNumbers.push(mathOP.performance)
                        }
                    }
                case "x":
                    if stackOperators.isEmpty() {
                        stackOperators.push(OperandsOperatorsBracesAndSigns.multiplication)
                    } else {
                        
                        if stackOperators.top()! == .openBrace {
                            stackOperators.push(OperandsOperatorsBracesAndSigns.multiplication)
                        } else if stackOperators.top()! == .substraction {
                            stackOperators.push(.multiplication)
                        }  else if stackOperators.top()! == .addition {
                            stackOperators.push(.multiplication)
                        } else if stackOperators.top()! == .multiplication {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .multiplication
                            stackOperators.pop()
                            stackOperators.push(.multiplication)
                            stackOfNumbers.push(mathOP.performance)
                        } else {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .division
                            stackOperators.pop()
                            stackOperators.push(.multiplication)
                            stackOfNumbers.push(mathOP.performance)
                        }
                    }
                case "÷":
                    if stackOperators.isEmpty() {
                        stackOperators.push(OperandsOperatorsBracesAndSigns.division)
                    } else {
                        
                        if stackOperators.top()! == .openBrace {
                            stackOperators.push(OperandsOperatorsBracesAndSigns.division)
                        } else if stackOperators.top()! == .substraction {
                            stackOperators.push(.division)
                        }  else if stackOperators.top()! == .addition {
                            stackOperators.push(.division)
                        } else if stackOperators.top()! == .multiplication {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .multiplication
                            stackOperators.pop()
                            stackOperators.push(.division)
                            stackOfNumbers.push(mathOP.performance)
                        } else {
                            var mathOP = MathOperation()
                            mathOP.operand2 = stackOfNumbers.pop()!
                            mathOP.operand1 = stackOfNumbers.pop()
                            mathOP.binaryOperation = .division
                            stackOperators.pop()
                            stackOperators.push(.division)
                            stackOfNumbers.push(mathOP.performance)
                        }
                    }
                case "(":
                    stackOperators.push(OperandsOperatorsBracesAndSigns.openBrace)
                case ")":
                    while stackOperators.top()! != .openBrace {
                        var matOP = MathOperation()
                        matOP.operand2 = stackOfNumbers.pop()!
                        matOP.operand1 = stackOfNumbers.pop()!
                        if stackOperators.top()! == .addition {
                            matOP.binaryOperation = .addition
                            stackOperators.pop()
                        } else if stackOperators.top()! == .substraction {
                            matOP.binaryOperation = .substraction
                            stackOperators.pop()
                        } else if stackOperators.top()! == .multiplication{
                            matOP.binaryOperation = .multiplication
                            stackOperators.pop()
                        } else {
                            matOP.binaryOperation = .division
                            stackOperators.pop()
                        }
                        stackOfNumbers.push(matOP.performance)
                    }
                    stackOperators.pop()
                default:
                    while !stackOperators.isEmpty(){
                        var matOP = MathOperation()
                        matOP.operand2 = stackOfNumbers.pop()!
                        matOP.operand1 = stackOfNumbers.pop()!
                        if stackOperators.top()! == .addition {
                            matOP.binaryOperation = .addition
                            stackOperators.pop()
                        } else if stackOperators.top()! == .substraction {
                            matOP.binaryOperation = .substraction
                            stackOperators.pop()
                        } else if stackOperators.top()! == .multiplication{
                            matOP.binaryOperation = .multiplication
                            stackOperators.pop()
                        } else {
                            matOP.binaryOperation = .division
                            stackOperators.pop()
                        }
                        stackOfNumbers.push(matOP.performance)
                    }
                }
            }
        }
        return stackOfNumbers.top()!
    }
    
}
