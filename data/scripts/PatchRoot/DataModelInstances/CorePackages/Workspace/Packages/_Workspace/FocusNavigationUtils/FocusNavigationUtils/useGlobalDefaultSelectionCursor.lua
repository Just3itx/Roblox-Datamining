-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local FocusNavigationUtilsParent = script:FindFirstAncestor("FocusNavigationUtils").Parent
local React = require(FocusNavigationUtilsParent.React)
local useCursor = require(FocusNavigationUtilsParent.UIBlox).App.SelectionCursor.useCursor
local useDesignTokens = require(FocusNavigationUtilsParent.Style).useDesignTokens

local function useGlobalDefaultSelectionCursor()
    local var1 = useDesignTokens(function(arg1)
        return {
            width = arg1.Size.Size_50,
            radius = UDim.new(0, arg1.Radius.Medium),
            offset = arg1.Size.Size_50
        }
    end)

    local var2 = useCursor(var1.radius, var1.offset, var1.width)
    local current = if var2 then var2.current else nil

    React.useEffect(function()
        if CoreGui.SelectionImageObject ~= nil or current == nil then
            return nil
        end

        CoreGui.SelectionImageObject = current

        return function()
            CoreGui.SelectionImageObject = nil
        end
    end, { current })
end

return useGlobalDefaultSelectionCursor
