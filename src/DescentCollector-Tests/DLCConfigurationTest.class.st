"
A DLCConfigurationTest is a test class for testing the behavior of DLCConfiguration
"
Class {
	#name : #DLCConfigurationTest,
	#superclass : #TestCase,
	#category : #'DescentCollector-Tests'
}

{ #category : #test }
DLCConfigurationTest >> testReadConfig [

	| collector parser config pair |
	collector := DLCollector new.
	parser := DLittleLParser new.
	config := collector config.
	pair := parser parse: '(DLittleConfig: 
	(types:
		(author: class DLCAuthor)
		(books: list)
		(book: class DLCBook)
		(title: string)
		(read: boolean)
		(price: integer)
	 ))'.
	config readConfig: pair.
	self assert: config collector equals: collector.
	self assert: config interpreters size equals: 6.
	self assert: (config interpreters at: 'author' at: 'Interpreter') class 
		equals: DLCClassInterpreter.
	self assert: (config interpreters at: 'author' at: 'Class')
		equals: DLCAuthor.
		
	self assert: (config interpreters at: 'books' at: 'Interpreter') class 
		equals: DLCListInterpreter.
		
	self assert: (config interpreters at: 'book' at: 'Interpreter') class 
		equals: DLCClassInterpreter.
	self assert: (config interpreters at: 'book' at: 'Class') 
		equals: DLCBook.
		
	self assert: (config interpreters at: 'title' at: 'Interpreter') class 
		equals: DLCStringInterpreter.
		
	self assert: (config interpreters at: 'price' at: 'Interpreter') class 
		equals: DLCIntegerInterpreter.
		
	self assert: (config interpreters at: 'read' at: 'Interpreter') class 
		equals: DLCBooleanInterpreter.
	
]

{ #category : #test }
DLCConfigurationTest >> testReadConfigWithAliases [

	| collector parser config pair |
	collector := DLCollector new.
	parser := DLittleLParser new.
	config := collector config.
	pair := parser parse: '(DLittleConfig: 
	(types:
		(author: class DLCAuthor)
		(books: list)
		(book: class DLCBook)
		(title: string)
		(read: boolean)
		(price: integer)
	 )
	(alias:
		(true: SI)
		(true: Ouui)
		(false: Noon)
		(someOtherAlias: AliasValue)
	 ))'.
	config readConfig: pair.
	self assert: config collector equals: collector.
	self assert: config aliases size equals: 3.
	self assert: ((config aliases at: 'someOtherAlias') includes: 'AliasValue').
	
	self assert: ((collector interpreters at: DLCBooleanInterpreter) trueAliases includes: 'SI').
	self assert: ((collector interpreters at: DLCBooleanInterpreter) trueAliases includes: 'Ouui').
	self assert: ((collector interpreters at: DLCBooleanInterpreter) falseAliases includes: 'Noon').
	

]
