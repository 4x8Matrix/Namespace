return function()
	local Namespace = require(script.Parent)

	local namespaceInstance
	local namespaceInstanceIndex = 0

	beforeEach(function()
		namespaceInstanceIndex += 1

		namespaceInstance = Instance.new("Part")
		namespaceInstance.Name = "Example_" .. namespaceInstanceIndex

		local testFolder = Instance.new("Folder")
		testFolder.Parent = namespaceInstance
		testFolder.Name = "Folder"

		local testValue = Instance.new("StringValue")
		testValue.Parent = testFolder
		testValue.Name = "Value"
		testValue.Value = "Hello, World!"
	end)

	it("Should be able generated a 'Namespace' object around instance", function()
		expect(function()
			local namespace = Namespace.from(namespaceInstance)

			expect(namespace.Name).to.equal(namespaceInstance.Name)
			expect(namespace.Instance).to.equal(namespaceInstance)
		end).never.to.throw()
	end)

	it("Should be able to index a new Namespace object", function()
		expect(function()
			local namespace = Namespace.from(namespaceInstance)

			print(namespace:Index("Folder"))

			expect(namespace.Name).to.equal(namespaceInstance.Name)
			expect(namespace.Instance).to.equal(namespaceInstance)
		end).never.to.throw()
	end)
end