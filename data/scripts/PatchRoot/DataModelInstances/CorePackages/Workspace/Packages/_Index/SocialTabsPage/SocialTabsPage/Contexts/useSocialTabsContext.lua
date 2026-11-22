-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPageParent = script:FindFirstAncestor("SocialTabsPage").Parent

local React = require(SocialTabsPageParent.React)
local SocialTabsContext = require(script.Parent.SocialTabsContext)

local function useSocialTabsContext()
    local var1 = React.useContext(SocialTabsContext)
    assert(var1 ~= nil, "useSocialTabsContext must be used within a SocialTabsContext.Provider")
    return var1
end

return useSocialTabsContext
