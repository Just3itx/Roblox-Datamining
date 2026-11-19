-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local DataConsumer = require(script.Parent.Parent.DataConsumer)
local LogOutput = require(script.Parent.LogOutput)

local var1 = Roact.Component:extend("ClientLog")

function var1.init(arg1)
    function arg1.initClientLogData()
        return arg1.props.ClientLogData:getLogData()
    end
end

function var1.render(arg1)
    return Roact.createElement(LogOutput, {
        layoutOrder = arg1.props.layoutOrder,
        size = arg1.props.size,
        initLogOutput = arg1.initClientLogData,
        targetSignal = arg1.props.ClientLogData:Signal()
    })
end

return DataConsumer(var1, "ClientLogData")
