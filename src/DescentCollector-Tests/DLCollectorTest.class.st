"
A DLCollectorTest is a test class for testing the behavior of DLCollector
"
Class {
	#name : #DLCollectorTest,
	#superclass : #TestCase,
	#category : #'DescentCollector-Tests'
}

{ #category : #test }
DLCollectorTest >> testDefaultInterpreterFor [

	| c parser result |
	c := DLCollector new.
	parser := DLittleLParser new.
	
	result := parser parse: '(aSimpleText: This is some random value without rest)'.
	self assert: ((c defaultInterpreterFor: result) at: 'Interpreter') class 
		equals: DLCStringInterpreter. 

	result := parser parse: '(aSimpleDictionary: (key1: val1) (key2: val2))'.
	self assert: ((c defaultInterpreterFor: result) at: 'Interpreter') class 
		equals: DLCDictionaryInterpreter. 
]

{ #category : #test }
DLCollectorTest >> testInitialize [

	| c |
	c := DLCollector new.
	self assert: c config class equals: DLCConfiguration.
	self assert: c config collector equals: c.
	self assert: (c interpreters at: DLCStringInterpreter) class equals: DLCStringInterpreter.
	self assert: (c interpreters at: DLCDictionaryInterpreter) class equals: DLCDictionaryInterpreter.
	self assert: (c interpreters at: DLCDictionaryInterpreter) collector equals: c.
]

{ #category : #test }
DLCollectorTest >> testInterpreterFor [

	| c parser result |
	c := DLCollector new.
	parser := DLittleLParser new.
	
	result := parser parse: '(aSimpleText: This is some random value without any specified configuration)'.
	self assert: ((c interpreterFor: result) at: 'Interpreter') class 
		equals: DLCStringInterpreter. 
]
