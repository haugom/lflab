#IP: 4 * [ uint8 ]

#PrivateIP: #IP
#PrivateIP: [10, ...uint8] |
    [192, 168, ...] |
    [172, >=16 & <=32, ...]

myIP: #PrivateIP
myIP: [10, 2, 3, 4]

yourIP: #PrivateIP
yourIP: [192, 168, 2, 3]