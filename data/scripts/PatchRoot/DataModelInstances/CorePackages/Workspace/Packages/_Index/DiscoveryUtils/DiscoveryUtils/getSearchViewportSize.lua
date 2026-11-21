-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent

local function getSearchViewportSize()
    local var1 = require(DiscoveryUtilsParent.Display).GetDisplayStore(false)
    local viewportSize = var1.getViewportSize(false)
    if viewportSize.X <= 1 or viewportSize.Y <= 1 then
        return nil
    end

    local platformScale = var1.getPlatformScale(false)
    if platformScale and platformScale > 0 then
        viewportSize /= platformScale
    end
    return viewportSize
end

return getSearchViewportSize
