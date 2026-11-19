-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local scriptParentParentParent = script.Parent.Parent.Parent

local ClosePlayerDropDown = require(scriptParentParentParent.Actions.ClosePlayerDropDown)
local SetIsUsingGamepad = require(scriptParentParentParent.Actions.SetIsUsingGamepad)

local EventConnection = require(script.Parent.EventConnection)

local var1 = Roact.PureComponent:extend("UserInputServiceConnector")

function var1.render(arg1)
    return Roact.createFragment({
        InputBeganConnection = Roact.createElement(EventConnection, {
            event = UserInputService.InputBegan,
            callback = function(arg2, arg3)
                if not arg1.props.playerDropdownVisible or arg3 then
                    return
                end

                local userInputType = arg2.UserInputType
                if userInputType == Enum.UserInputType.Touch or userInputType == Enum.UserInputType.MouseButton1 then
                    arg1.props.closePlayerDropDown()
                end
            end
        }),
        LastInputTypeChangedConnection = Roact.createElement(EventConnection, {
            event = UserInputService.LastInputTypeChanged,
            callback = function(arg2)
                local bool1 = arg2.Name:find("Gamepad") ~= nil
                if bool1 == arg1.props.isUsingGamepad then
                    return
                end
                arg1.props.setIsUsingGamepad(bool1)
            end
        })
    })
end

return RoactRodux.connect(function(arg1) -- name: mapStateToProps
    return {
        playerDropdownVisible = arg1.playerDropDown.isVisible,
        isUsingGamepad = arg1.displayOptions.isUsingGamepad
    }
end, function(arg1) -- name: mapDispatchToProps
    return {
        closePlayerDropDown = function()
            return arg1(ClosePlayerDropDown())
        end,
        setIsUsingGamepad = function(arg2)
            return arg1(SetIsUsingGamepad(arg2))
        end
    }
end)(var1)
