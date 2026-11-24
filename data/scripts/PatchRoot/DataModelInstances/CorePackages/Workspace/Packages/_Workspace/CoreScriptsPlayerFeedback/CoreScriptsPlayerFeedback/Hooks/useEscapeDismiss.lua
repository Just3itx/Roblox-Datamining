-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedbackParent = script:FindFirstAncestor("CoreScriptsPlayerFeedback").Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)

local ContextActionService = game:GetService("ContextActionService")

local function useEscapeDismiss(actionName: string, callback: (...any) -> (...any))
    React.useEffect(function()
        pcall(function()
            ContextActionService:BindCoreActionAtPriority(actionName, function(_, userInputState)
                if userInputState ~= Enum.UserInputState.Begin then
                    return Enum.ContextActionResult.Pass
                end

                callback()
                return Enum.ContextActionResult.Sink
            end, false, 100000, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB)
        end)

        return function()
            pcall(function()
                ContextActionService:UnbindCoreAction(actionName)
            end)
        end
    end, { callback, actionName })
end

return useEscapeDismiss
