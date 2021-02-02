Class {
	#name : #DLCIntegerInterpreterTest,
	#superclass : #TestCase,
	#category : #'DescentCollector-Tests'
}

{ #category : #tests }
DLCIntegerInterpreterTest >> testInterpret [
	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(price: 155)'.
	interpreter := DLCIntegerInterpreter new.
	result := interpreter interpret: pair.
	self assert: result equals: 155
]

{ #category : #tests }
DLCIntegerInterpreterTest >> testInterpretWithLettersAndRest [
	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(price: abc123abc (someInfo: someValue))'.
	interpreter := DLCIntegerInterpreter new.
	result := interpreter interpret: pair.
	self assert: result equals: 123
]

{ #category : #tests }
DLCIntegerInterpreterTest >> testInterpreterConfigFor [

	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(price: integer)'.
	interpreter := DLCIntegerInterpreter new.
	result := interpreter interpreterConfigFor: pair.
	self assert: result notNil.
	self assert: (result class canUnderstand: #'at:').
	self assert: (result class canUnderstand: #'add:').
	
	pair := parser parse: '(read: boolean)'.
	result := interpreter interpreterConfigFor: pair.
	self assert: result isNil.
]
