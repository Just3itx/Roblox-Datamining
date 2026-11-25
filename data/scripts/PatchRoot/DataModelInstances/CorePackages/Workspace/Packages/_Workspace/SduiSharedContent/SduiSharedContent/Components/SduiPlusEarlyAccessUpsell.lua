-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local React = require(SduiSharedContentParent.React)
local PlusEarlyAccessUpsellBanner = require(SduiSharedContentParent.GamePlayButton).PlusEarlyAccessUpsellBanner

return React.memo(function(tbl1) -- name: SduiPlusEarlyAccessUpsell
    if tbl1.universeId == nil then
        return nil
    end

    return React.createElement(PlusEarlyAccessUpsellBanner, { universeId = tbl1.universeId, LayoutOrder = tbl1.layoutOrder })
end)
