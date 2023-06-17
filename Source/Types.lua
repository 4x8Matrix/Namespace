export type Namespace = {
	Name: string,

	ToString: (self: Namespace) -> string
}

export type Interface = {
	new: (serviceSource: {
		Name: string
	}) -> Namespace,

	is: (object: Namespace?) -> boolean,
	get: (namespaceName: string) -> Namespace?
}

return { }