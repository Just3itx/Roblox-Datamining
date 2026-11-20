-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ReactUtilsParent = script:FindFirstAncestor("ReactUtils").Parent
local React = require(ReactUtilsParent.React)

local function useToggleState(arg1)
    local enabled, set = React.useState(arg1 or false)

    return {
        enabled = enabled,
        enable = React.useCallback(function()
            set(true)
        end, {}),
        disable = React.useCallback(function()
            set(false)
        end, {}),
        toggle = React.useCallback(function()
            set(function(arg2): boolean
                return not arg2
            end)
        end, {}),
        set = set
    }
end

return useToggleState
