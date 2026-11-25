-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Responsive = script:FindFirstAncestor("Responsive")
local ResponsiveParent = Responsive.Parent
local React = require(ResponsiveParent.React)
local InputMode = require(Responsive.InputMode)

local function useLastInput()
    local var1, var2 = React.useState(InputMode.last)
    React.useEffect(function()
        var2(InputMode.last)
        local var3 = InputMode.connect(function()
            var2(InputMode.last)
        end)
        return function()
            var3:disconnect()
        end
    end, {})
    return var1 or ""
end

return useLastInput
