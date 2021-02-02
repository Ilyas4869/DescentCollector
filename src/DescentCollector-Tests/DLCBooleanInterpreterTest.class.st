"
A DLCBooleanInterpreterTest is a test class for testing the behavior of DLCBooleanInterpreter
"
Class {
	#name : #DLCBooleanInterpreterTest,
	#superclass : #TestCase,
	#category : #'DescentCollector-Tests'
}

{ #category : #test }
DLCBooleanInterpreterTest >> testInterpret [
	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(read: true)'.
	interpreter := DLCBooleanInterpreter new.
	result := interpreter interpret: pair.
	self assert: result equals: true
]

{ #category : #test }
DLCBooleanInterpreterTest >> testInterpret2 [
	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(read: false)'.
	interpreter := DLCBooleanInterpreter new.
	result := interpreter interpret: pair.
	self assert: result equals: false
]

{ #category : #test }
DLCBooleanInterpreterTest >> testInterpretWithAlias [
	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(read: oui)'.
	interpreter := DLCBooleanInterpreter new.
	result := interpreter interpret: pair.
	self assert: result equals: true
]

{ #category : #test }
DLCBooleanInterpreterTest >> testInterpretWithAlias2 [
	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(read: non)'.
	interpreter := DLCBooleanInterpreter new.
	result := interpreter interpret: pair.
	self assert: result equals: false
]

{ #category : #test }
DLCBooleanInterpreterTest >> testInterpreterConfigFor [

	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(read: boolean)'.
	interpreter := DLCBooleanInterpreter new.
	result := interpreter interpreterConfigFor: pair.
	self assert: result notNil.
	self assert: (result class canUnderstand: #'at:').
	self assert: (result class canUnderstand: #'add:').
	
	pair := parser parse: '(read: list)'.
	interpreter := DLCBooleanInterpreter new.
	result := interpreter interpreterConfigFor: pair.
	self assert: result isNil.
]
