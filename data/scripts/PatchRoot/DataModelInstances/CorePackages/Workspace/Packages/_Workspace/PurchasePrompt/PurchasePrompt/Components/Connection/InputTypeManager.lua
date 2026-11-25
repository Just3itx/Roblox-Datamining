-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local UserInputService = game:GetService("UserInputService")

local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local MouseIconOverrideService = require(PurchasePromptParent.CoreScriptsCommon).MouseIconOverrideService

local SetGamepadEnabled = require(PurchasePrompt.Actions.SetGamepadEnabled)
local PromptState = require(PurchasePrompt.Enums.PromptState)
local connectToStore = require(PurchasePrompt.connectToStore)

local ExternalEventConnection = require(script.Parent.ExternalEventConnection)

local tbl1 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true
}

local var1 = Roact.Component:extend("InputTypeManager")

function var1.init(arg1)
    local setGamepadEnabled = arg1.props.setGamepadEnabled

    function arg1.dispatchOnChange(arg2)
        local bool1 = not not tbl1[arg2]

        if bool1 == arg1.props.gamepadEnabled then
            return
        end
        setGamepadEnabled(bool1)
    end

    arg1.cursorOverridden = false
end

function var1.render(arg1)
    return Roact.createElement(
        ExternalEventConnection,
        {
            event = UserInputService.LastInputTypeChanged,
            callback = arg1.dispatchOnChange
        }
    )
end

function var1.didUpdate(arg1, arg2, _)
    local bool1 = arg2.promptState == PromptState.None and arg1.props.promptState ~= PromptState.None
    local bool2 = not (arg2.promptState == PromptState.None) and arg1.props.promptState == PromptState.None
    local bool3 = arg1.props.promptState ~= PromptState.None

    local overrideMouseIconBehavior = arg1.props.gamepadEnabled and Enum.OverrideMouseIconBehavior.ForceHide or Enum.OverrideMouseIconBehavior.ForceShow

    if bool3 and arg2.gamepadEnabled ~= arg1.props.gamepadEnabled then
        if arg1.cursorOverridden then
            MouseIconOverrideService.pop("PurchasePromptOverrideKey")
        end
        MouseIconOverrideService.push("PurchasePromptOverrideKey", overrideMouseIconBehavior)
        arg1.cursorOverridden = true
        return
    end
    if bool1 then
        MouseIconOverrideService.push("PurchasePromptOverrideKey", overrideMouseIconBehavior)
        arg1.cursorOverridden = true
    elseif bool2 then
        MouseIconOverrideService.pop("PurchasePromptOverrideKey")
        arg1.cursorOverridden = false
    end
end

return (connectToStore(function(arg1) -- name: mapStateToProps
    return {
        promptState = arg1.promptState,
        gamepadEnabled = arg1.gamepadEnabled
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        setGamepadEnabled = function(arg1)
            callback(SetGamepadEnabled(arg1))
        end
    }
end)(var1))
