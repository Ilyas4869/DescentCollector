Class {
	#name : #DLCIntegerInterpreter,
	#superclass : #DLCInterpreter,
	#category : #DescentCollector
}

{ #category : #interpreting }
DLCIntegerInterpreter >> interpret: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	^aPair value asInteger
]

{ #category : #configuration }
DLCIntegerInterpreter >> interpreterConfigFor: aPair [
	"aPair: an instance of DLList. (price: 155)"
	| config |
	(aPair value = 'integer')
		ifTrue: [ config := Dictionary new.
			^ config ].
	^ nil
]
