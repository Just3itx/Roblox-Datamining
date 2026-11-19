-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(Components.DataConsumer)
local MemoryView = require(Components.Memory.MemoryView)

local var1 = Roact.Component:extend("ServerMemory")

function var1.render(arg1)
    return Roact.createElement(MemoryView, {
        layoutOrder = arg1.props.layoutOrder,
        size = arg1.props.size,
        searchTerm = arg1.props.searchTerm,
        targetMemoryData = arg1.props.ServerMemoryData
    })
end

return DataConsumer(var1, "ServerMemoryData")
