-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local DataConsumer = require(script.Parent.Parent.DataConsumer)

local CommandLineHeight = require(script.Parent.Parent.Parent.Constants).LogFormatting.CommandLineHeight

local DevConsoleCommandLine = require(script.Parent.DevConsoleCommandLine)
local LogOutput = require(script.Parent.LogOutput)

local var1 = Roact.Component:extend("ServerLog")

function var1.init(arg1)
    function arg1.initServerLogData()
        return arg1.props.ServerLogData:getLogData()
    end
end

function var1.render(arg1)
    return Roact.createElement(
        "Frame",
        {
            Size = arg1.props.size,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder
        },
        {
            Scroll = Roact.createElement(LogOutput, {
                size = UDim2.new(1, 0, 1, -(CommandLineHeight + 4)),
                targetSignal = arg1.props.ServerLogData:Signal(),
                initLogOutput = arg1.initServerLogData
            }),
            CommandLine = Roact.createElement(DevConsoleCommandLine, { pos = UDim2.new(0, 0, 1, -CommandLineHeight), height = CommandLineHeight })
        }
    )
end

return DataConsumer(var1, "ServerLogData")
