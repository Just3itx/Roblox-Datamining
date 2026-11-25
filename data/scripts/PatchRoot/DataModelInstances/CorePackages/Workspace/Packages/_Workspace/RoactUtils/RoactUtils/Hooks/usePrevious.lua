-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoactUtilsParent = script:FindFirstAncestor("RoactUtils").Parent

local GetFFlagMigrateRoactUtilsToReactUtils = require(RoactUtilsParent.SharedFlags).GetFFlagMigrateRoactUtilsToReactUtils
local ReactUtils = require(RoactUtilsParent.ReactUtils)
if GetFFlagMigrateRoactUtilsToReactUtils() then
    return ReactUtils.usePrevious
end

local React = require(RoactUtilsParent.React)

local function usePrevious(current)
    local var1 = React.useRef(nil)
    React.useEffect(function()
        var1.current = current
    end)
    return var1.current
end

return usePrevious
