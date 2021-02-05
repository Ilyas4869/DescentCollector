Class {
	#name : #DLCBook,
	#superclass : #DLCObject,
	#instVars : [
		'title',
		'read',
		'price'
	],
	#category : #'DescentCollector-Tests'
}

{ #category : #accessing }
DLCBook >> price [
	^price
]

{ #category : #accessing }
DLCBook >> price: anInteger [
	price := anInteger
]

{ #category : #accessing }
DLCBook >> read [
	^read
]

{ #category : #accessing }
DLCBook >> read: aBoolean [
	read := aBoolean
]

{ #category : #accessing }
DLCBook >> title [
	^title
]

{ #category : #accessing }
DLCBook >> title: aString [
	title := aString
]
