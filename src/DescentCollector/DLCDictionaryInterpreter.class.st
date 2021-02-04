Class {
	#name : #DLCDictionaryInterpreter,
	#superclass : #DLCInterpreter,
	#category : #DescentCollector
}

{ #category : #adding }
DLCDictionaryInterpreter >> addKeyValue: aPair to: aDictionary [
	| value |
	value := self interpretPair: aPair.
	aDictionary at: (aPair key) put: value
]

{ #category : #interpreting }
DLCDictionaryInterpreter >> interpret: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	| dict |
	dict := Dictionary new.
	aPair value notNil ifTrue:
		[self addKeyValue: aPair to: dict].
	aPair rest do: [ :each | self addKeyValue: each to: dict ].
	^dict
]

{ #category : #configuration }
DLCDictionaryInterpreter >> interpreterConfigFor: aPair [
	"aPair: an instance of DLList. eg: (properties: dictionary)"
	| config |
	(aPair value = 'dictionary') ifTrue:
		[ config := Dictionary new.
		^config ].
	^nil
]
