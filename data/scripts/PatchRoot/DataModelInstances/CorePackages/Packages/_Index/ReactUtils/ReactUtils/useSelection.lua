-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtils = script:FindFirstAncestor("ReactUtils")

local ReactUtilsParent = ReactUtils.Parent
local React = require(ReactUtilsParent.React)

local useEventConnection = require(ReactUtils.useEventConnection)

local function useSelection(arg1)
    local var1 = arg1 or game:GetService("Selection")

    local var2, var3 = React.useState(function()
        return var1:Get()
    end)

    useEventConnection(var1.SelectionChanged, function()
        var3(var1:Get())
    end, {})

    return var2
end

return useSelection
