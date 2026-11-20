-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)

local HardwareSafeAreaInsets = require(MomentsCommon.Utils.HardwareSafeAreaInsets)

return function()
    local var1, var2 = React.useState(HardwareSafeAreaInsets.deviceInsets())
    React.useLayoutEffect(function()
        local connection = HardwareSafeAreaInsets:connect(var2)
        if HardwareSafeAreaInsets.diffInsets(var1, HardwareSafeAreaInsets.deviceInsets()) then
            var2(HardwareSafeAreaInsets.deviceInsets)
        end
        return function()
            connection.disconnect()
        end
    end, {})
    return var1
end
