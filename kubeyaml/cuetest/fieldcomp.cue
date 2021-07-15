import "strings"

#a: [ "Barcelona", "Shanghai", "Munich", "Oslo" ]

for k, v in #a {
    "\( strings.ToLower(v) )": {
        pos:     k + 1
        name:    v
        nameLen: len(v)
    }
}
