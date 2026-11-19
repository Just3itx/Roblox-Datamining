-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local VRService = game:GetService("VRService")
local UserInputService = game:GetService("UserInputService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux

local scriptParentParentParent = script.Parent.Parent.Parent

local SetInputType = require(scriptParentParentParent.Actions.SetInputType)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)
local InputTypeMap = require(scriptParentParentParent.Resources.Constants).InputTypeMap

local var1 = Roact.PureComponent:extend("LastInputTypeConnector")

function var1.updateInputType(arg1, arg2)
    if VRService.VREnabled then
        arg2 = InputTypeMap[Enum.UserInputType.MouseMovement]
    end
    if arg2 then
        arg1.props.setInputType(arg2)
    end
end

function var1.init(arg1)
    arg1:updateInputType(InputTypeMap[UserInputService:GetLastInputType()])
end

function var1.render(arg1)
    return Roact.createElement(ExternalEventConnection, {
        event = UserInputService.LastInputTypeChanged,
        callback = function(arg2)
            local var2 = InputTypeMap[arg2]
            arg1:updateInputType(var2)
        end
    })
end

return RoactRodux.UNSTABLE_connect2(nil, function(arg1)
    return {
        setInputType = function(arg2)
            return arg1(SetInputType(arg2))
        end
    }
end)(var1)
