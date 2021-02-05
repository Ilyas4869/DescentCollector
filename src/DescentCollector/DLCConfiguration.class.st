Class {
	#name : #DLCConfiguration,
	#superclass : #Object,
	#instVars : [
		'collector',
		'interpreters'
	],
	#category : #DescentCollector
}

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
	interpreters := Dictionary new
]

{ #category : #accessing }
DLCConfiguration >> interpreters [
	^interpreters
]

{ #category : #adding }
DLCConfiguration >> readConfig: aPair [
	"aPair: an instance of DLList, representing the configuration block"
	aPair restDo: [ :each | 
		(each key = 'types') ifTrue: 
			[self readInterpreters: each rest]		
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
