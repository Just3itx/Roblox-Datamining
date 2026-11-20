-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParentParent = script.Parent.Parent.Parent

local EventConnection = require(scriptParentParentParent.Parent.Common.EventConnection)

local SetInputType = require(scriptParentParentParent.Actions.SetInputType)
local InputType = require(scriptParentParentParent.Constants).InputType

local var1 = Roact.PureComponent:extend("LastInputTypeConnector")

local tbl1 = {
    [Enum.UserInputType.MouseButton2] = InputType.MouseAndKeyBoard,
    [Enum.UserInputType.MouseButton3] = InputType.MouseAndKeyBoard,
    [Enum.UserInputType.MouseWheel] = InputType.MouseAndKeyBoard,
    [Enum.UserInputType.MouseMovement] = InputType.MouseAndKeyBoard,
    [Enum.UserInputType.Keyboard] = InputType.MouseAndKeyBoard,
    [Enum.UserInputType.Gamepad1] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad2] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad3] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad4] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad5] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad6] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad7] = InputType.Gamepad,
    [Enum.UserInputType.Gamepad8] = InputType.Gamepad,
    [Enum.UserInputType.Touch] = InputType.Touch
}

function var1.didMount(arg1)
    local var2 = tbl1[UserInputService:GetLastInputType()]
    if var2 then
        arg1.props.setInputType(var2)
    end
end

function var1.render(arg1)
    return Roact.createElement(EventConnection, {
        event = UserInputService.LastInputTypeChanged,
        callback = function(arg2)
            local var2 = tbl1[arg2]
            if var2 then
                arg1.props.setInputType(var2)
            end
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
