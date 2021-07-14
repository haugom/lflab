parameter: {
	domain: string
	http: [string]: int
	tls: *true | bool
}

// trait template can have multiple outputs in one trait
outputs: service: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: name: context.name
	spec: {
		selector: {
			"app.oam.dev/component": context.name
		}
		ports: [
			for k, v in parameter.http {
				port:       v
				targetPort: v
			},
		]
	}
}

outputs: ingress: {
	apiVersion: "networking.k8s.io/v1"
	kind:       "Ingress"
	metadata: {
		annotations: {
			"cert-manager.io/issuer": "letsencrypt-prod"
		}
		name: context.name
	}
	spec: {
		tls: [
			{hosts: [parameter.domain]
				secretName: "tls-" + context.name
			},

		]
		rules: [{
			host: parameter.domain
			http: {
				paths: [
					for k, v in parameter.http {
						path:     k
						pathType: "Prefix"
						backend: {
							service: {
								name: context.name
								port: {
									number: v
								}
							}
						}
					},
				]
			}
		}]
	}
}
