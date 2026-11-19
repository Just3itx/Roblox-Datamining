-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(Components.DataConsumer)
local NetworkView = require(script.Parent.NetworkView)

local var1 = Roact.Component:extend("ServerNetwork")

function var1.init(arg1, _)
    arg1.state = {
        targetNetworkData = arg1.props.ServerNetworkData
    }
end

function var1.render(arg1)
    local layoutOrder = arg1.props.layoutOrder
    local searchTerm = arg1.props.searchTerm
    local size = arg1.props.size

    return Roact.createElement(
        NetworkView,
        {
            size = size,
            searchTerm = searchTerm,
            layoutOrder = layoutOrder,
            targetNetworkData = arg1.state.targetNetworkData
        }
    )
end
return DataConsumer(var1, "ServerNetworkData")
