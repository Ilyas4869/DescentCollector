Class {
	#name : #DLCStringInterpreterTest,
	#superclass : #TestCase,
	#category : #'DescentCollector-Tests'
}

{ #category : #tests }
DLCStringInterpreterTest >> testInterpret [
	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(title: My super book)'.
	interpreter := DLCStringInterpreter new.
	result := interpreter interpret: pair.
	self assert: result equals: 'My super book'
]

{ #category : #tests }
DLCStringInterpreterTest >> testInterpretWithRest [
	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(title: My super book (read: no))'.
	interpreter := DLCStringInterpreter new.
	result := interpreter interpret: pair.
	self assert: result equals: 'My super book'
]

{ #category : #tests }
DLCStringInterpreterTest >> testInterpreterConfigFor [

	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(read: string)'.
	interpreter := DLCStringInterpreter new.
	result := interpreter interpreterConfigFor: pair.
	self assert: result notNil.
	self assert: (result class canUnderstand: #'at:').
	self assert: (result class canUnderstand: #'add:').
	
	pair := parser parse: '(read: boolean)'.
	result := interpreter interpreterConfigFor: pair.
	self assert: result isNil.
]
