-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)

local function useAutocompleteKeyboardNavigation(bool1: boolean, callback: ((...any) -> (...any))?, arg1)
    local actionName = "AutocompleteSourcesSink_" .. tostring((React.useRef({})))
    local inputBegan = if arg1 ~= nil then arg1.InputBegan else UserInputService.InputBegan

    React.useEffect(function()
        if callback == nil then
            return
        end

        local connection = inputBegan:Connect(function(arg2)
            callback(arg2.KeyCode)
        end)
        return function()
            connection:Disconnect()
        end
    end, { callback, inputBegan })

    React.useEffect(function()
        if not bool1 then
            return
        end

        ContextActionService:BindCoreAction(actionName, function(): Enum.ContextActionResult
            return Enum.ContextActionResult.Sink
        end, false, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Escape)
        return function()
            ContextActionService:UnbindCoreAction(actionName)
        end
    end, { bool1, actionName })
end

return useAutocompleteKeyboardNavigation
