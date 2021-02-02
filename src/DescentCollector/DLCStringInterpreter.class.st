Class {
	#name : #DLCStringInterpreter,
	#superclass : #DLCInterpreter,
	#category : #DescentCollector
}

{ #category : #interpreting }
DLCStringInterpreter >> interpret: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	^aPair value
]

{ #category : #configuration }
DLCStringInterpreter >> interpreterConfigFor: aPair [
	"aPair: an instance of DLList. (title: The book title)"
	| config |
	(aPair value = 'string')
		ifTrue: [ config := Dictionary new.
			^ config ].
	^ nil
]
