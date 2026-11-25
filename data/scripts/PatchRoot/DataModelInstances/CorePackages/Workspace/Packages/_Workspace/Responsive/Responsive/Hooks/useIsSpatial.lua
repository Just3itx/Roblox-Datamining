-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ResponsiveParent = script:FindFirstAncestor("Responsive").Parent
local React = require(ResponsiveParent.React)
local AppCommonLib = require(ResponsiveParent.AppCommonLib)

local function useIsSpatial()
    local var1, var2 = React.useState(AppCommonLib.isSpatial)
    React.useEffect(function()
        var2(AppCommonLib.isSpatial())
        local var3 = AppCommonLib.connectToIsSpatialChanged(function(bool1: boolean)
            var2(bool1)
        end)
        return function()
            var3:Disconnect()
        end
    end, {})
    return var1
end

return useIsSpatial
