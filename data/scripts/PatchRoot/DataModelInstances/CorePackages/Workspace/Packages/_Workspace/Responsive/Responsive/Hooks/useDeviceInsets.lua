-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ResponsiveParent = script:FindFirstAncestor("Responsive").Parent
local React = require(ResponsiveParent.React)
local HardwareSafeAreaInsets = require(script.Parent.Parent.HardwareSafeAreaInsets)

return function()
    local var1, var2 = React.useState(HardwareSafeAreaInsets.deviceInsets())
    React.useLayoutEffect(function()
        local connection = HardwareSafeAreaInsets:connect(var2)
        if HardwareSafeAreaInsets.diffInsets(var1, HardwareSafeAreaInsets.deviceInsets()) then
            var2(HardwareSafeAreaInsets.deviceInsets)
        end
        return function()
            connection:disconnect()
        end
    end, {})
    return var1
end
