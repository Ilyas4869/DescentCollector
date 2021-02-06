Class {
	#name : #DLCListInterpreter,
	#superclass : #DLCInterpreter,
	#category : #DescentCollector
}

{ #category : #adding }
DLCListInterpreter >> add: aPair to: aList [
	| value |
	value := collector interpret: aPair.
	aList add: value
]

{ #category : #interpreting }
DLCListInterpreter >> interpret: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	| l |
	l := OrderedCollection new.
	aPair rest do: [ :each | self add: each to: l ].
	^l
]

{ #category : #configuration }
DLCListInterpreter >> interpreterConfigFor: aPair [
	"aPair: an instance of DLList. (books: list)"
	| config |
	(aPair value = 'list')
		ifTrue: [ config := Dictionary new.
			^ config ].
	^ nil
]
