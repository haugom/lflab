import "k8s.io/api/core/v1"
import "dep k8s.io/api/apps/v1"

services: [string]: v1.#Service

s: v1.#Service
s: {
  	metadata: name: "test"
}

d: dep.#Deployment

