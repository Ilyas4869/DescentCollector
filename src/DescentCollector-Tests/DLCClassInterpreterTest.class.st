Class {
	#name : #DLCClassInterpreterTest,
	#superclass : #TestCase,
	#category : #'DescentCollector-Tests'
}

{ #category : #tests }
DLCClassInterpreterTest >> testInterpret [
	| collector parser pair config interpreter result |
	collector := DLCollector new.
	parser := DLittleLParser new.
	config := parser parse: '(DLittleConfig: (types: (author: class DLCAuthor)))'.
	collector config readConfig: config.	
	pair := parser parse: '(author: (name: My Name) (books: No books here))'.
	interpreter := collector interpreters at: DLCClassInterpreter.
	result := interpreter interpret: pair.
	self assert: result class equals: DLCAuthor.
	self assert: result name equals: 'My Name'.
	self assert: result books equals: 'No books here'.
]

{ #category : #tests }
DLCClassInterpreterTest >> testInterpreterConfigFor [

	| parser pair interpreter result |
	parser := DLittleLParser new.
	pair := parser parse: '(book: class DLCBook)'.
	interpreter := DLCClassInterpreter new.
	result := interpreter interpreterConfigFor: pair.
	self assert: result notNil.
	self assert: (result at: 'Class') equals: DLCBook.
	
	pair := parser parse: '(read: boolean)'.
	result := interpreter interpreterConfigFor: pair.
	self assert: result isNil.
]

{ #category : #test }
DLCClassInterpreterTest >> testTryCallSelectorForClass [

	| collector parser pair interpreter book |
	book := DLCBook new.
	collector := DLCollector new.
	parser := DLittleLParser new.
	pair := parser parse: '(book: (title : Les vents du changement) (read : no) (price : 2.39))'.
	interpreter := collector interpreters at: DLCClassInterpreter.
	
	interpreter tryCallSelector: pair rest first forClass: book.
	self assert: book title equals: 'Les vents du changement'.
	
	interpreter tryCallSelector: pair rest second forClass: book.
	self assert: book read equals: 'no'.
	
	interpreter tryCallSelector: pair rest third forClass: book.
	self assert: book price equals: '2.39'.
	
]

{ #category : #test }
DLCClassInterpreterTest >> testTryCallSelectorForClassKeepExtraInformation [

	| collector parser pair interpreter book |
	book := DLCBook new.
	collector := DLCollector new.
	parser := DLittleLParser new.
	pair := parser parse: '(book: (title : Les vents du changement) (read : no) (price : 2.39) (ffo : this is an imporant information))'.
	interpreter := collector interpreters at: DLCClassInterpreter.
	
	interpreter tryCallSelector: pair rest fourth forClass: book.
	self assert: (book propertyAt: 'ffo') equals: 'this is an imporant information'.
	
]
