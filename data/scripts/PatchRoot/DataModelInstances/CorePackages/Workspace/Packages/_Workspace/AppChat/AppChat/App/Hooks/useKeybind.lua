-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)
local useExternalEvent = require(AppChatParent.RoactUtils).Hooks.useExternalEvent

local function useKeybind(tbl1, callback: (...any) -> (...any), tbl2)
    useExternalEvent(UserInputService.InputBegan, function(arg1)
        if arg1.KeyCode == tbl1.keyCode and (tbl1.modifierKey == nil or arg1:IsModifierKeyDown(tbl1.modifierKey)) then
            callback()
        end
    end, Cryo.List.join({ tbl1 }, { callback }, tbl2))
end

return useKeybind
