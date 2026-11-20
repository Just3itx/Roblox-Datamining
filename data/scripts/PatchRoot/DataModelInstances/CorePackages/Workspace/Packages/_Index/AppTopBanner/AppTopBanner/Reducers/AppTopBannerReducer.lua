-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppTopBanner = script:FindFirstAncestor("AppTopBanner")
local AppTopBannerParent = AppTopBanner.Parent

local Cryo = require(AppTopBannerParent.Cryo)
local Rodux = require(AppTopBannerParent.Rodux)

local AppTopBannerType = require(AppTopBanner.Enums.AppTopBannerType)
local Constants = require(AppTopBanner.Constants)
local SetAppTopBanner = require(AppTopBanner.Actions.SetAppTopBanner)
local DisableAppTopBanner = require(AppTopBanner.Actions.DisableAppTopBanner)

local tbl1 = {
    isDisabled = true,
    expanded = false,
    appTopBannerType = AppTopBannerType.None,
    appTopBannerContentProps = nil,
    appTopBannerContentHeight = 0,
    onAppTopBannerClick = function() end
}

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[SetAppTopBanner.name] = function(tbl3, tbl4)
    local isDisabled = tbl3.isDisabled
    if tbl4.expanded then
        return (Cryo.Dictionary.join(tbl3, {
            expanded = tbl4.expanded,
            appTopBannerType = tbl4.appTopBannerType,
            appTopBannerContentProps = tbl4.appTopBannerContentProps,
            onAppTopBannerClick = tbl4.onAppTopBannerClick,
            appTopBannerContentHeight = tbl4.appTopBannerContentHeight or Constants.CONTENT_HEIGHT,
            isDisabled = isDisabled
        }))
    end

    if tbl3.expanded ~= tbl4.expanded then
        tbl3 = Cryo.Dictionary.join(tbl1, { isDisabled = isDisabled })
    end

    return tbl3
end

tbl2[DisableAppTopBanner.name] = function(tbl3, tbl4)
    if tbl3.isDisabled == tbl4.isDisabled then
        return tbl3
    end

    return (Cryo.Dictionary.join(tbl3, { isDisabled = not tbl3.isDisabled }))
end

return createReducer(tbl1, tbl2)
