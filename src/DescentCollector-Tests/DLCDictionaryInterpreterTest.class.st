Class {
	#name : #DLCDictionaryInterpreterTest,
	#superclass : #TestCase,
	#category : #'DescentCollector-Tests'
}

{ #category : #tests }
DLCDictionaryInterpreterTest >> testInterpret [
	| collector parser pair interpreter result |
	collector := DLCollector new.
	parser := DLittleLParser new.
	pair := parser parse: '(author: (firstName: My First Name) (lastName: My Last Name) (born: 1980))'.
	interpreter := collector interpreters at: DLCDictionaryInterpreter.
	result := interpreter interpret: pair.
	self assert: result class equals: Dictionary.
	self assert: result size equals: 3.
	self assert: (result at: 'firstName') equals: 'My First Name'.
	self assert: (result at: 'lastName') equals: 'My Last Name'.
	self assert: (result at: 'born') equals: '1980'.
]

{ #category : #tests }
DLCDictionaryInterpreterTest >> testInterpreterConfigFor [

	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(author: dictionary)'.
	interpreter := DLCDictionaryInterpreter new.
	result := interpreter interpreterConfigFor: pair.
	self assert: result notNil.
	self assert: (result class canUnderstand: #'at:').
	self assert: (result class canUnderstand: #'add:').
	
	pair := parser parse: '(read: boolean)'.
	result := interpreter interpreterConfigFor: pair.
	self assert: result isNil.
]
