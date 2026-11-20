-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local UserInputService = game:GetService("UserInputService")

local React = require(FoundationParent.React)

local useEventConnection = require(FoundationParent.ReactUtils).useEventConnection

local _InputMode = require(Foundation.Utility.Input.InputMode)
local getInputMode = require(Foundation.Utility.Input.getInputMode)

local function getLastInputMode()
    return getInputMode(UserInputService:GetLastInputType())
end

local function useLastInputMode()
    local var1, var2 = React.useState(getLastInputMode)

    useEventConnection(UserInputService.LastInputTypeChanged, function()
        var2(getLastInputMode())
    end)

    return var1
end

return useLastInputMode
