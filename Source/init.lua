-- // Imports
local Console = require(script.Parent.Console)
local Types = require(script.Types)

-- // Module
local Namespace = {}

Namespace.Type = "Namespace"

Namespace.Reporter = Console.new()

Namespace.Objects = {}
Namespace.Instances = {}
Namespace.Interface = {}
Namespace.Prototype = {}

-- // Prototype functions
function Namespace.Prototype:Index(...)
	local baseNamespace = false
	local base = self.Instance

	local pathIndexes = { ... }

	for pathIndex, index in pathIndexes do
		base = base[index]
		baseNamespace = Namespace.Interface.getFrom(base)

		if baseNamespace then
			return baseNamespace:Index(table.unpack(pathIndexes, pathIndex, select("#", ...)))
		end
	end

	if base:IsA("ModuleScript") then
		base = require(base)
	elseif base:IsA("ValueBase") then
		base = base.Value
	end

	return base
end

function Namespace.Prototype:ToString()
	return `{Namespace.Type}<"{self.Name}">`
end

-- // Module functions
function Namespace.Interface.new(namespaceSource)
	Namespace.Reporter:Assert(typeof(namespaceSource) == "table", `Unable to cast {typeof(namespaceSource)} to table`)
	Namespace.Reporter:Assert(typeof(namespaceSource.Instance) == "Instance", `Unable to cast {typeof(namespaceSource.Instance)} to Instance`)
	Namespace.Reporter:Assert(typeof(namespaceSource.Name) == "string", `Unable to cast {typeof(namespaceSource.Instance)} to string`)

	Namespace.Reporter:Assert(Namespace.Objects[namespaceSource.Instance] == nil, `Instance '{namespaceSource.Instance}' has already been tied to a Namespace`)
	Namespace.Reporter:Assert(Namespace.Instances[namespaceSource.Name] == nil, `Namespace '{namespaceSource.Name}' already exists`)

	Namespace.Objects[namespaceSource.Instance] = namespaceSource.Name
	Namespace.Instances[namespaceSource.Name] = setmetatable(namespaceSource, {
		__type = Namespace.Type,
		__index = Namespace.Prototype,
		__tostring = function(self)
			return self:ToString()
		end
	})

	return Namespace.Instances[namespaceSource.Name]
end

function Namespace.Interface.from(instanceReference)
	return Namespace.Interface.new({
		Instance = instanceReference,
		Name = instanceReference.Name
	})
end

function Namespace.Interface.get(namespaceName)
	return Namespace.Instances[namespaceName]
end

function Namespace.Interface.getFrom(object)
	if not Namespace.Objects[object] then
		return
	end

	return Namespace.Instances[Namespace.Objects[object]]
end

return Namespace.Interface :: Types.Interface
