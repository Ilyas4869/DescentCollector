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

{ #category : #interpreting }
DLCInterpreter >> interpretPair: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	| interpreterData interpreterClass interpreterSingleton |
	interpreterData := collector interpreterFor: aPair.
	interpreterClass := interpreterData at: 'Class'.
	interpreterSingleton := collector interpreters at: interpreterClass.
	^interpreterSingleton interpret: aPair withConfig: (interpreterData at: 'Config')
]

{ #category : #configuration }
DLCInterpreter >> setConfigMetadata: aString [
	^false
]
