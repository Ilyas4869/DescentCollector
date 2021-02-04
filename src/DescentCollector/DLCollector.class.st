Class {
	#name : #DLCollector,
	#superclass : #Object,
	#instVars : [
		'interpreters',
		'content',
		'config'
	],
	#category : #DescentCollector
}

{ #category : #accessing }
DLCollector >> config [
	^config
]

{ #category : #interpreting }
DLCollector >> defaultInterpreterFor: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"

	| dict interpreter |
	dict := Dictionary new.
	interpreter := aPair restIsEmpty
		ifTrue: [ interpreters at: DLCStringInterpreter ]
		ifFalse: [ interpreters at: DLCDictionaryInterpreter ].
	dict at: 'Interpreter' put: interpreter.
	^ dict
]

{ #category : #initialization }
DLCollector >> initialize [
	config := DLCConfiguration new.
	self initializeInterpreters.
	
]

{ #category : #initialization }
DLCollector >> initializeInterpreters [
	interpreters := Dictionary new.
	interpreters at: DLCBooleanInterpreter put: DLCBooleanInterpreter new.
	interpreters at: DLCClassInterpreter put: DLCClassInterpreter new.
	interpreters at: DLCDictionaryInterpreter put: DLCDictionaryInterpreter new.
	interpreters at: DLCListInterpreter put: DLCListInterpreter new.
	interpreters at: DLCStringInterpreter put: DLCStringInterpreter new.
	
	interpreters valuesDo: [ :value | value collector: self ].
]

{ #category : #interpreting }
DLCollector >> interpreterFor: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"

	| interpreter |
	interpreter := (config interpreters includesKey: aPair key)
		ifTrue: [ interpreters at: aPair key ]
		ifFalse: [ self defaultInterpreterFor: aPair ].
	^ interpreter
]

{ #category : #initialization }
DLCollector >> interpreters [
	^interpreters
]

{ #category : #initialization }
DLCollector >> interpreters: aList [
	interpreters := aList
]
