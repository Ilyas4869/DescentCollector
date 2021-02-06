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

{ #category : #accessing }
DLCollector >> defaultConfigBlockName [
	^'DLittleConfig'
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

{ #category : #interpreting }
DLCollector >> deserialize: aString [
	"handles the deserialization of a DLittle-format text"
	
	| parser blocks results |
	results := OrderedCollection new.
	parser := DLittleLParser new.
	blocks := parser parseMultiple: aString.
	blocks do: [ :each |
		each key = self defaultConfigBlockName
			ifTrue: [ config readConfig: each ]
			ifFalse: [ results add: (self interpret: each) ] ].
		
	results size = 1
		ifTrue: [ ^results first ].
	^results
	
	
	
]

{ #category : #initialization }
DLCollector >> initialize [
	self initializeConfig.
	self initializeInterpreters.
]

{ #category : #initialization }
DLCollector >> initializeConfig [
	config := DLCConfiguration new.
	config collector: self
]

{ #category : #initialization }
DLCollector >> initializeInterpreters [
	interpreters := Dictionary new.
	interpreters at: DLCBooleanInterpreter put: DLCBooleanInterpreter new.
	interpreters at: DLCClassInterpreter put: DLCClassInterpreter new.
	interpreters at: DLCDictionaryInterpreter put: DLCDictionaryInterpreter new.
	interpreters at: DLCListInterpreter put: DLCListInterpreter new.
	interpreters at: DLCStringInterpreter put: DLCStringInterpreter new.
	interpreters at: DLCIntegerInterpreter put: DLCIntegerInterpreter new.
	
	interpreters valuesDo: [ :value | value collector: self ].
]

{ #category : #interpreting }
DLCollector >> interpret: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	| interpreterData interpreter |
	interpreterData := self interpreterFor: aPair.
	interpreter := interpreterData at: 'Interpreter'.
	^interpreter interpret: aPair.
]

{ #category : #interpreting }
DLCollector >> interpreterFor: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"

	| interpreter |
	interpreter := (config interpreters includesKey: aPair key)
		ifTrue: [ config interpreters at: aPair key ]
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
