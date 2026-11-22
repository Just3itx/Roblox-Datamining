-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileShareLinksParent = script:FindFirstAncestor("ProfileShareLinks").Parent
local React = require(ProfileShareLinksParent.React)

local initializeProfileShareLinksAnalytics = require(script.Parent.initializeProfileShareLinksAnalytics)

return function()
    return React.useMemo(function()
        return initializeProfileShareLinksAnalytics()
    end, {})
end
