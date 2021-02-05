Class {
	#name : #DLCObject,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'DescentCollector-Tests'
}

{ #category : #accessing }
DLCObject >> ensureProperties [
	properties ifNil: [ properties := Dictionary new ].
	^ properties 
]

{ #category : #accessing }
DLCObject >> propertyAt: propName [ 

	^ self ensureProperties 
		at: propName


]

{ #category : #accessing }
DLCObject >> propertyAt: propName put: propValue [
	^ self ensureProperties
		at: propName
		ifAbsentPut: propValue
]
