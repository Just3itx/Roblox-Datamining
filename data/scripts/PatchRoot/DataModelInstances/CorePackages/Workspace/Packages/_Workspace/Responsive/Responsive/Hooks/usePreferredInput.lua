-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Responsive = script:FindFirstAncestor("Responsive")
local ResponsiveParent = Responsive.Parent
local React = require(ResponsiveParent.React)
local InputMode = require(Responsive.InputMode)

local function usePreferredInput()
    local var1, var2 = React.useState(InputMode.preferred)
    React.useEffect(function()
        var2(InputMode.preferred)
        local var3 = InputMode.connect(function()
            var2(InputMode.preferred)
        end)
        return function()
            var3:disconnect()
        end
    end, {})
    return var1 or ""
end

return usePreferredInput
