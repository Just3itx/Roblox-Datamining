-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileShareLinks = script:FindFirstAncestor("ProfileShareLinks")
local ProfileShareLinksParent = ProfileShareLinks.Parent
local useSelector = require(ProfileShareLinksParent.RoactUtils).Hooks.RoactRodux.useSelector

local Constants = require(ProfileShareLinks.Common.Constants)
local getDeepValue = require(ProfileShareLinks.Common.getDeepValue)

return function()
    return useSelector(function(arg1)
        return getDeepValue(arg1, `{Constants.RODUX_KEY}.ProfileShareLinks.shortUrl`)
    end)
end
