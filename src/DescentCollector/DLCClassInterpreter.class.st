Class {
	#name : #DLCClassInterpreter,
	#superclass : #DLCInterpreter,
	#category : #DescentCollector
}

{ #category : #interpreting }
DLCClassInterpreter >> interpret: aPair [
	"aPair: an instance of DLList like (key1: value1 (key2: value2) (key3: value3))"
	
	| config instance pair c |
	config := collector config interpreters at: aPair key.
	c := config at: 'Class'.
	(c class canUnderstand: #new)
		ifFalse: [ self error: ('Class {1} doesn''t exist' format: { c }) ].
	instance := c perform: #new.

	((config includesKey: 'Id') & aPair value notNil)
		ifTrue: [ pair := DLList new.
			pair key: (config at: 'Id').
			pair value: (aPair value).
			self tryCallSelector: pair forClass: instance ].
		
	aPair rest do: 
		[ :each | self tryCallSelector: each forClass: instance ].
	
	^instance
]

{ #category : #configuration }
DLCClassInterpreter >> interpreterConfigFor: aPair [
	"aPair: an instance of DLList. (book: class MyBookClass)"
	| config prefix class |
	prefix := 'class '.
	(aPair value truncateTo: prefix size) = prefix
		ifTrue: [ config := Dictionary new.
			class := self class environment
				at: (aPair value allButFirst: prefix size) asSymbol.
			config at: 'Class' put: class.
			self putPairs: aPair rest in: config.
			^ config ].
	^ nil
]

{ #category : #interpreting }
DLCClassInterpreter >> tryCallSelector: aPair forClass: anObject [
	| value |
	value := collector interpret: aPair.
	(anObject class canUnderstand: aPair key asSymbol asMutator)
		ifTrue: [ anObject perform: aPair key asSymbol asMutator with: value ]
		ifFalse: [ anObject propertyAt: aPair key asSymbol put: value ].
]
