Class {
	#name : #DLCInterpreter,
	#superclass : #Object,
	#instVars : [
		'collector'
	],
	#category : #DescentCollector
}

{ #category : #accessing }
DLCInterpreter >> collector [
	^collector
]

{ #category : #accessing }
DLCInterpreter >> collector: anObject [
	collector := anObject
]

{ #category : #initialization }
DLCInterpreter >> initialize [

	super initialize 
]

{ #category : #interpreting }
DLCInterpreter >> interpret: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	^nil
]

{ #category : #adding }
DLCInterpreter >> putPairs: aCollection in: aDictionary [
	aCollection do: [ :each |
		aDictionary at: each key put: each value ]
]
