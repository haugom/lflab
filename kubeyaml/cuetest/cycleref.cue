labels: selectors
labels: {app: "foo"}

selectors: labels
selectors: {name: "bar"}

#gender: *"male" | "female" | string

#person: {
	gender: #gender
}

geir: #person
vibeke: #person & { gender: "female"}