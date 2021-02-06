"
A DLCollectorTest is a test class for testing the behavior of DLCollector
"
Class {
	#name : #DLCollectorTest,
	#superclass : #TestCase,
	#category : #'DescentCollector-Tests'
}

{ #category : #test }
DLCollectorTest >> testDefaultInterpreterFor [

	| c parser result |
	c := DLCollector new.
	parser := DLittleLParser new.
	
	result := parser parse: '(aSimpleText: This is some random value without rest)'.
	self assert: ((c defaultInterpreterFor: result) at: 'Interpreter') class 
		equals: DLCStringInterpreter. 

	result := parser parse: '(aSimpleDictionary: (key1: val1) (key2: val2))'.
	self assert: ((c defaultInterpreterFor: result) at: 'Interpreter') class 
		equals: DLCDictionaryInterpreter. 
]

{ #category : #test }
DLCollectorTest >> testDeserialize [
	| collector result |
	collector := DLCollector new.
	result := collector deserialize: '
	(DLittleConfig: 
		(types:
			(author: class DLCAuthor)
			(books: list)
			(book: class DLCBook)
			(title: string)
			(read: boolean)
			(price: integer)
	 ))
	(author: (name: A first author)
		(books: 
			(book: (title: Helliconia l''ete) (read: no) (price: 1))
			(book: (title: Le printemps d''helliconia) (read: no) (price: 4))
			(book: (title: L''instant de l''eclipse) (read: yes) (price: 1))
	))'.
	
	self assert: result class equals: DLCAuthor .
	self assert: result books class equals: OrderedCollection.
	self assert: result books size equals: 3.
	
	self assert: result books first class equals: DLCBook .
	self assert: result books first title equals: 'Helliconia l''ete' .
	self assert: result books first read equals: false .	
	self assert: result books first price equals: 1 .	
		
	self assert: result books second class equals: DLCBook .
	self assert: result books second title equals: 'Le printemps d''helliconia' .
	self assert: result books second read equals: false .	
	self assert: result books second price equals: 4 .	
		
	self assert: result books third class equals: DLCBook .
	self assert: result books third title equals: 'L''instant de l''eclipse' .
	self assert: result books third read equals: true .	
	self assert: result books third price equals: 1 .
]

{ #category : #test }
DLCollectorTest >> testDeserializeDoubleWithoutConfig [
	| collector result |
	collector := DLCollector new.
	result := collector deserialize: '
	(author: (name: A first author) (born: 1980)) 
	(author: (name: A second author) (born: 1990))'.
	
	self assert: result class equals: OrderedCollection .
	self assert: result size equals: 2.
	
	self assert: result first class equals: Dictionary .
	self assert: (result first at: 'name') equals: 'A first author'.
	self assert: (result first at: 'born') equals: '1980'.
	
	self assert: result second class equals: Dictionary .
	self assert: (result second at: 'name') equals: 'A second author'.
	self assert: (result second at: 'born') equals: '1990'.
	
]

{ #category : #test }
DLCollectorTest >> testDeserializeEmpty [
	| collector result |
	collector := DLCollector new.
	result := collector deserialize: ''.
	
	self assert: result class equals: OrderedCollection .
	self assert: result isEmpty.
]

{ #category : #test }
DLCollectorTest >> testDeserializeSimpleWithoutConfig [
	| collector result |
	collector := DLCollector new.
	result := collector deserialize: '(author: (firstName: My First Name) (lastName: My Last Name) (born: 1980))'.
	
	self assert: result class equals: Dictionary.
	self assert: result size equals: 3.
	self assert: (result at: 'firstName') equals: 'My First Name'.
	self assert: (result at: 'lastName') equals: 'My Last Name'.
	self assert: (result at: 'born') equals: '1980'.
]

{ #category : #test }
DLCollectorTest >> testDeserializeWithAlias [
	| collector result |
	collector := DLCollector new.
	result := collector deserialize: '
	(DLittleConfig: 
		(types:
			(author: class DLCAuthor)
			(books: list)
			(book: class DLCBook)
			(title: string)
			(read: boolean)
			(price: integer))
		(alias:
			(true: SI)
			(true: Ouui)
			(false: Noon)
			(someOtherAlias: AliasValue)
	 ))
	(author: (name: A first author)
		(books: 
			(book: (title: Helliconia l''ete) (read: non) (price: 1))
			(book: (title: Le printemps d''helliconia) (read: Noon) (price: 4))
			(book: (title: L''instant de l''eclipse) (read: Ouui) (price: 1))
	))'.
	
	self assert: result class equals: DLCAuthor .
	self assert: result books class equals: OrderedCollection.
	self assert: result books size equals: 3.
	
	self assert: result books first class equals: DLCBook .
	self assert: result books first title equals: 'Helliconia l''ete' .
	self assert: result books first read equals: false .	
	self assert: result books first price equals: 1 .	
		
	self assert: result books second class equals: DLCBook .
	self assert: result books second title equals: 'Le printemps d''helliconia' .
	self assert: result books second read equals: false .	
	self assert: result books second price equals: 4 .	
		
	self assert: result books third class equals: DLCBook .
	self assert: result books third title equals: 'L''instant de l''eclipse' .
	self assert: result books third read equals: true .	
	self assert: result books third price equals: 1 .
]

{ #category : #test }
DLCollectorTest >> testDeserializeWithShortcutId [
	| collector result |
	collector := DLCollector new.
	result := collector deserialize: '
	(DLittleConfig: 
		(types:
			(author: class DLCAuthor)
			(books: list)
			(book: class DLCBook (Id: title))
			(title: string)
			(read: boolean)
			(price: integer)))
	(author: (name: A first author)
		(books: 
			(book: Helliconia l''ete (read: non) (price: 1))
			(book: Le printemps d''helliconia (read: non) (price: 4))
			(book: (title: L''instant de l''eclipse) (read: oui) (price: 1))
	))'.
	
	self assert: result class equals: DLCAuthor .
	self assert: result books class equals: OrderedCollection.
	self assert: result books size equals: 3.
	
	self assert: result books first class equals: DLCBook .
	self assert: result books first title equals: 'Helliconia l''ete' .
	self assert: result books first read equals: false .	
	self assert: result books first price equals: 1 .	
		
	self assert: result books second class equals: DLCBook .
	self assert: result books second title equals: 'Le printemps d''helliconia' .
	self assert: result books second read equals: false .	
	self assert: result books second price equals: 4 .	
		
	self assert: result books third class equals: DLCBook .
	self assert: result books third title equals: 'L''instant de l''eclipse' .
	self assert: result books third read equals: true .	
	self assert: result books third price equals: 1 .
]

{ #category : #test }
DLCollectorTest >> testInitialize [

	| c |
	c := DLCollector new.
	self assert: c config class equals: DLCConfiguration.
	self assert: c config collector equals: c.
	self assert: (c interpreters at: DLCStringInterpreter) class equals: DLCStringInterpreter.
	self assert: (c interpreters at: DLCDictionaryInterpreter) class equals: DLCDictionaryInterpreter.
	self assert: (c interpreters at: DLCDictionaryInterpreter) collector equals: c.
]

{ #category : #test }
DLCollectorTest >> testInterpreterFor [

	| c parser result |
	c := DLCollector new.
	parser := DLittleLParser new.
	
	result := parser parse: '(aSimpleText: This is some random value without any specified configuration)'.
	self assert: ((c interpreterFor: result) at: 'Interpreter') class 
		equals: DLCStringInterpreter. 
]
