Class {
	#name : #DLCConfiguration,
	#superclass : #Object,
	#instVars : [
		'collector',
		'interpreters',
		'aliases'
	],
	#category : #DescentCollector
}

{ #category : #accessing }
DLCConfiguration >> aliases [ 
	^aliases
]

{ #category : #accessing }
DLCConfiguration >> collector [
	^collector
]

{ #category : #accessing }
DLCConfiguration >> collector: anObject [
	collector := anObject
]

{ #category : #initialization }
DLCConfiguration >> initialize [
	interpreters := Dictionary new.
	aliases := Dictionary new
]

{ #category : #accessing }
DLCConfiguration >> interpreters [
	^interpreters
]

{ #category : #adding }
DLCConfiguration >> readAliases: aCollection [
	"aCollection: a collection of DLList aliases"

	aCollection
		do: [ :each | 
			(aliases includesKey: each key)
				ifFalse: [ aliases at: each key put: OrderedCollection new ].
			(aliases at: each key) add: each value.
			
			each key = 'true'
				ifTrue: [(collector interpreters at: DLCBooleanInterpreter) trueAliases add: each value].
			each key = 'false'
				ifTrue: [(collector interpreters at: DLCBooleanInterpreter) falseAliases add: each value].
			 ]
]

{ #category : #adding }
DLCConfiguration >> readConfig: aPair [
	"aPair: an instance of DLList, representing the configuration block"
	aPair restDo: [ :each | 
		(each key = 'types') ifTrue: 
			[self readInterpreters: each rest].
		(each key = 'alias') ifTrue: 
			[self readAliases: each rest]		
		]
]

{ #category : #adding }
DLCConfiguration >> readInterpreters: aCollection [
	"aCollection: a collection of DLList pairs, representing the types configuration"

	| config |
	aCollection
		do: [ :each | 
			collector interpreters
				valuesDo: [ :interpreter | 
					config := interpreter interpreterConfigFor: each.
					config notNil
						ifTrue: [ config at: 'Interpreter' put: interpreter.
							interpreters at: each key put: config ] ] ]
]
