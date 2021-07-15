msg: "hello \(#Name)!"

#Name: "world"

#A: {
	field: int
}

a: #A & { field: 3 }
err: #A & {feield: 3}
