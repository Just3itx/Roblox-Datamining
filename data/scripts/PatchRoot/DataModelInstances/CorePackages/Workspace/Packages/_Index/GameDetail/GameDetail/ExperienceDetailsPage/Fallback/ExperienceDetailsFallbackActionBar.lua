-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local Foundation = require(GameDetailParent.Foundation)
local View = Foundation.View
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local ButtonSize = Foundation.Enums.ButtonSize
local useTokens = Foundation.Hooks.useTokens
local GamePlayButton = require(GameDetailParent.GamePlayButton)
local useGameInfo = require(script.Parent.Parent.useGameInfo)
local PlayButton = GamePlayButton.PlayButton

local SharedFlags = require(GameDetailParent.SharedFlags)
local FFlagSduiEdpPersistentActionBarPlayButton = SharedFlags.FFlagSduiEdpPersistentActionBarPlayButton
local FFlagLuaAppLaunchWhenLoadingEdp = SharedFlags.FFlagLuaAppLaunchWhenLoadingEdp
local FFlagEnableGameJoinEarlyAccess = SharedFlags.FFlagEnableGameJoinEarlyAccess

return {
    Skeleton = React.memo(function(tbl1) -- name: ExperienceDetailsActionBarSkeleton
        local size1200 = useTokens().Size.Size_1200

        local createElement = React.createElement
        local var1 = View
        local tbl2 = {
            tag = if FFlagSduiEdpPersistentActionBarPlayButton then "row align-y-center gap-small auto-xy" else "row align-y-center gap-small size-full-0 auto-y padding-x-medium padding-top-medium bg-surface-0 stroke-default",
            testId = "--edp-fallback-action-bar-skeleton"
        }
        local tbl3 = {
            IconButtonSkeleton1 = React.createElement(Skeleton, { Size = UDim2.fromOffset(size1200, size1200), radius = Radius.Medium, LayoutOrder = 1 }),
            IconButtonSkeleton2 = React.createElement(Skeleton, { Size = UDim2.fromOffset(size1200, size1200), radius = Radius.Medium, LayoutOrder = 2 }),
            PlayBtnContainer = 0
        }
        local element

        if FFlagSduiEdpPersistentActionBarPlayButton then
            element = nil
        else
            element = React.createElement(View, { tag = "grow auto-y", LayoutOrder = 3 }, {
                PlayBtn = React.createElement(PlayButton, {
                    universeId = tbl1.universeId,
                    referralSource = tbl1.referralSource,
                    launchSource = tbl1.launchSource,
                    experienceJoinData = tbl1.experienceJoinData,
                    placeId = tbl1.placeIdOverride,
                    useUIBloxButton = true,
                    buttonSize = ButtonSize.Large,
                    fillBehavior = Foundation.Enums.FillBehavior.Fill,
                    launchWhenLoading = if FFlagLuaAppLaunchWhenLoadingEdp then true else nil,
                    launchOnReleaseAfterUnmount = true,
                    enableEarlyAccessPlusTooltip = if FFlagEnableGameJoinEarlyAccess then true else nil,
                    enableEarlyAccessState = if FFlagEnableGameJoinEarlyAccess then true else nil,
                    testId = "--edp-fallback-play-button"
                })
            })
        end

        tbl3.PlayBtnContainer = element
        return createElement(var1, tbl2, tbl3)
    end),
    Error = React.memo(function(tbl1) -- name: ExperienceDetailsActionBarError
        local var1 = useGameInfo(tbl1.universeId)

        if var1 ~= nil and var1.isUnavailable == true or FFlagSduiEdpPersistentActionBarPlayButton then
            return nil
        end

        return React.createElement(View, {
            tag = "row align-y-center gap-small size-full-0 auto-y padding-x-medium padding-top-medium bg-surface-0 stroke-default",
            testId = "--edp-fallback-action-bar-error"
        }, {
            PlayBtnContainer = React.createElement(View, { tag = "grow auto-y", LayoutOrder = 1 }, {
                PlayBtn = React.createElement(PlayButton, {
                    universeId = tbl1.universeId,
                    referralSource = tbl1.referralSource,
                    launchSource = tbl1.launchSource,
                    experienceJoinData = tbl1.experienceJoinData,
                    placeId = tbl1.placeIdOverride,
                    useUIBloxButton = true,
                    buttonSize = ButtonSize.Large,
                    fillBehavior = Foundation.Enums.FillBehavior.Fill,
                    launchWhenLoading = if FFlagLuaAppLaunchWhenLoadingEdp then true else nil,
                    launchOnReleaseAfterUnmount = true,
                    enableEarlyAccessPlusTooltip = if FFlagEnableGameJoinEarlyAccess then true else nil,
                    enableEarlyAccessState = if FFlagEnableGameJoinEarlyAccess then true else nil,
                    testId = "--edp-fallback-play-button"
                })
            })
        })
    end)
}
