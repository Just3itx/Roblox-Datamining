-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppTopBannerParent = script:FindFirstAncestor("AppTopBanner").Parent
return require(AppTopBannerParent.Rodux).makeActionCreator(script.Name, function(expanded, appTopBannerType, appTopBannerContentProps, onAppTopBannerClick, appTopBannerContentHeight)
    return {
        expanded = expanded,
        appTopBannerType = appTopBannerType,
        appTopBannerContentProps = appTopBannerContentProps,
        onAppTopBannerClick = onAppTopBannerClick,
        appTopBannerContentHeight = appTopBannerContentHeight
    }
end)
