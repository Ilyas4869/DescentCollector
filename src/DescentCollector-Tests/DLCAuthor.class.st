Class {
	#name : #DLCAuthor,
	#superclass : #DLCObject,
	#instVars : [
		'name',
		'books'
	],
	#category : #'DescentCollector-Tests'
}

{ #category : #accessing }
DLCAuthor >> books [
	^books
]

{ #category : #accessing }
DLCAuthor >> books: aCollection [
	books := aCollection
]

{ #category : #accessing }
DLCAuthor >> name [
	^name
]

{ #category : #accessing }
DLCAuthor >> name: aString [
	name := aString
]
