Class {
	#name : #DLCBooleanInterpreter,
	#superclass : #DLCInterpreter,
	#instVars : [
		'trueAlias',
		'falseAlias'
	],
	#category : #DescentCollector
}

{ #category : #aliasing }
DLCBooleanInterpreter >> defaultFalseAliases [
	^ { 'false' . 'False' . 'no' . 'non' }
]

{ #category : #aliasing }
DLCBooleanInterpreter >> defaultTrueAliases [
	^ { 'true' . 'True' . 'yes' . 'oui' }
]

{ #category : #accessing }
DLCBooleanInterpreter >> falseAlias [
	^falseAlias
]

{ #category : #initialization }
DLCBooleanInterpreter >> initialize [
	trueAlias := self defaultTrueAliases.
	falseAlias := self defaultFalseAliases
]

{ #category : #interpreting }
DLCBooleanInterpreter >> interpret: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	(trueAlias includes: aPair value ) ifTrue: 
	[ ^true ].
	(falseAlias includes: aPair value ) ifTrue: 
	[ ^false ].
	^self error: ('Unknown value {1} for the Boolean {2}' format: { aPair value . aPair key })
	
]

{ #category : #configuration }
DLCBooleanInterpreter >> interpreterConfigFor: aPair [
	"aPair: an instance of DLList. (read: boolean)"
	| config |
	(aPair value = 'boolean') ifTrue:
		[ config := Dictionary new.
		^config ].
	^nil
]

{ #category : #accessing }
DLCBooleanInterpreter >> trueAlias [
	^trueAlias
]
