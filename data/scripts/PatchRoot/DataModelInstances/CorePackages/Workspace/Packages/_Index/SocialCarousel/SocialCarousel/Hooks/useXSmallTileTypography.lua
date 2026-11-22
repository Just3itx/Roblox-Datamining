-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent
local React = require(SocialCarouselParent.React)
local Foundation = require(SocialCarouselParent.Foundation)
local RobloxAppHooks = require(SocialCarouselParent.RobloxAppHooks)
local RobloxAppEnums = require(SocialCarouselParent.RobloxAppEnums)

local useTokens = Foundation.Hooks.useTokens

local function useXSmallTileTypography()
    local var1 = useTokens()
    local bool1 = RobloxAppHooks.useDeviceType() == RobloxAppEnums.DeviceType.Phone

    return React.useMemo(function()
        if not bool1 then
            return nil
        end

        local fontSize200 = var1.FontSize.FontSize_200

        local title = table.clone(var1.Typography.TitleSmall)
        title.FontSize = fontSize200

        local label = table.clone(var1.Typography.LabelSmall)
        label.FontSize = fontSize200

        return { title = title, label = label }
    end, { var1, bool1 })
end

return useXSmallTileTypography
