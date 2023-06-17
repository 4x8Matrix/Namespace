# Namespace
The 'Namespace' module is designed around navigating the Roblox Environment, this Module isn't going to provide much use outside of the Infinity Framework ecosystem.

## Examples
Brief documentation to go through the functionality:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Namespace = require(ReplicatedStorage.Packages.Namespace)

local ExampleNamespace = Namespace.new({
	Name = "ExampleNamespace"
})

function ExampleNamespace:Index(...)
	-- '...' is a varadic array of strings, these strings represent the path the namespace should go to.

	return getObjectAtPath(...)
end
```