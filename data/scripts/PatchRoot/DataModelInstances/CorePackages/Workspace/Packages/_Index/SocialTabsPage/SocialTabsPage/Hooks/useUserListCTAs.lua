-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPageParent = script:FindFirstAncestor("SocialTabsPage").Parent

local React = require(SocialTabsPageParent.React)
local ProfileCTAService = require(SocialTabsPageParent.ProfileCtaService).ProfileCTAService

local function useUserListCTAs(tbl1)
    local var1, var2 = React.useState({})

    React.useEffect(function()
        local var3 = ProfileCTAService.connectRealTimeUpdates()
        return function()
            var3.Disconnect()
        end
    end, {})

    React.useEffect(function()
        if #tbl1 == 0 then
            return
        end
        local profileCtAs = ProfileCTAService.getProfileCTAs(tbl1)
        var2(profileCtAs)
    end, { tbl1 })

    return var1
end

return useUserListCTAs
