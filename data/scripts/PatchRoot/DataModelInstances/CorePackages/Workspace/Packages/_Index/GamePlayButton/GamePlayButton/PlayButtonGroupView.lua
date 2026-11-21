-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local React = require(GamePlayButtonParent.React)

local Foundation = require(GamePlayButtonParent.Foundation)
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize

local SharedFlags = require(GamePlayButtonParent.SharedFlags)
local FFlagLuaAppUseTokenHeightForPlayButton = SharedFlags.FFlagLuaAppUseTokenHeightForPlayButton
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagEnableGameJoinEarlyAccess = SharedFlags.FFlagEnableGameJoinEarlyAccess

local ButtonHeightSizeKeyByInputSize = require(script.Parent.ButtonHeightSizeKeyByInputSize)
local PlayButtonView = require(script.Parent.PlayButtonView)

local function func1() end

local function makePlayButtonProps(arg1, playButtonState: string, onPlayButtonActivated: (...any) -> (...any), playButtonCaptureRef, loadingCaptureRef, fillBehavior, layoutOrder: number, testId: string?, tag: string?, showEarlyAccessTooltip: boolean?)
    local tbl1 = {
        tag = tag,
        showEarlyAccessTooltip = 0,
        playButtonState = 0,
        gameProductInfo = 0,
        localized = 0,
        tokens = 0,
        hasJoinTextPlayableButtonIxp = 0,
        hasIconPlayButtonIxp = 0,
        hasPlayButtonLoadingSkeletonIxp = 0,
        onPlayButtonActivated = 0,
        onPlaySquadButtonActivated = 0,
        playButtonCaptureRef = 0,
        loadingCaptureRef = 0,
        shouldLaunchWhenLoading = 0,
        shouldLaunchOnReleaseAfterUnmount = 0,
        squadButtonMenuDirection = 0,
        playableText = 0,
        fiatText = 0,
        earlyAccessCaption = 0,
        earlyAccessPending = 0,
        hidePlayableIcon = 0,
        hideOptionalText = 0,
        buttonSize = 0,
        fillBehavior = 0,
        useUIBloxButton = 0,
        hideIfUnplayable = 0,
        hideIfLoading = 0,
        LayoutOrder = 0,
        testId = 0
    }

    if not FFlagEnableGameJoinEarlyAccess then
        showEarlyAccessTooltip = nil
    end

    tbl1.showEarlyAccessTooltip = showEarlyAccessTooltip
    tbl1.playButtonState = playButtonState
    tbl1.gameProductInfo = arg1.gameProductInfo
    tbl1.localized = arg1.localized
    tbl1.tokens = arg1.tokens
    tbl1.hasJoinTextPlayableButtonIxp = arg1.hasJoinTextPlayableButtonIxp
    tbl1.hasIconPlayButtonIxp = arg1.hasIconPlayButtonIxp
    tbl1.hasPlayButtonLoadingSkeletonIxp = arg1.hasPlayButtonLoadingSkeletonIxp
    tbl1.onPlayButtonActivated = onPlayButtonActivated
    tbl1.onPlaySquadButtonActivated = arg1.onPlaySquadButtonActivated
    tbl1.playButtonCaptureRef = playButtonCaptureRef
    tbl1.loadingCaptureRef = loadingCaptureRef
    tbl1.shouldLaunchWhenLoading = arg1.shouldLaunchWhenLoading
    tbl1.shouldLaunchOnReleaseAfterUnmount = arg1.shouldLaunchOnReleaseAfterUnmount
    tbl1.squadButtonMenuDirection = arg1.squadButtonMenuDirection
    tbl1.playableText = arg1.playableText
    tbl1.fiatText = arg1.fiatText
    tbl1.earlyAccessCaption = if FFlagEnableGameJoinEarlyAccess then arg1.earlyAccessCaption else nil
    tbl1.earlyAccessPending = if FFlagEnableGameJoinEarlyAccess then arg1.earlyAccessPending else nil
    tbl1.hidePlayableIcon = arg1.hidePlayableIcon
    tbl1.hideOptionalText = arg1.hideOptionalText
    tbl1.buttonSize = arg1.buttonSize
    tbl1.fillBehavior = fillBehavior
    tbl1.useUIBloxButton = arg1.useUIBloxButton
    tbl1.hideIfUnplayable = arg1.hideIfUnplayable
    tbl1.hideIfLoading = arg1.hideIfLoading
    tbl1.LayoutOrder = layoutOrder
    tbl1.testId = testId
    return tbl1
end

return React.memo(function(arg1) -- name: PlayButtonGroupView
    local tokens = arg1.tokens
    local var1 = arg1.buttonSize or InputSize.Medium
    local offset

    if FFlagLuaAppUseTokenHeightForPlayButton then
        local var2 = ButtonHeightSizeKeyByInputSize[var1] or "Size_1000"
        offset = if tokens and tokens.Size[var2] then tokens.Size[var2] else 40
    else
        offset = 0
    end

    local offset2 = if tokens then tokens.Gap.Small else 8
    local width = arg1.width
    if arg1.expandWidthForSecondaryPlayButton and arg1.secondaryPlayButtonState ~= nil and width ~= nil then
        width = UDim.new(width.Scale * 2, width.Offset * 2 + offset2)
    end

    local var2 = if width then FillBehavior.Fill else arg1.fillBehavior
    local fillBehavior = if arg1.secondaryPlayButtonState == nil and width == nil then var2 elseif var2 == "Fill" then FillBehavior.Fill else FillBehavior.Fit
    local var3 = if arg1.testId then `{arg1.testId}--secondary` else nil
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        LayoutOrder = arg1.LayoutOrder,
        Position = arg1.Position
    }
    local var4

    if FFlagLuaAppUseTokenHeightForPlayButton then
        local new = UDim2.new
        if not width then
            if var2 == "Fill" then
                width = UDim.new(1, 0)
            else
                width = UDim.new(0, 0)
            end
        end

        var4 = new(width, UDim.new(0, offset))
    elseif width then
        var4 = UDim2.new(width, UDim.new(0, 0))
    elseif var2 == "Fill" then
        var4 = UDim2.new(1, 0, 1, 0)
    else
        var4 = nil
    end

    tbl1.Size = var4

    tbl1.AutomaticSize = if FFlagLuaAppUseTokenHeightForPlayButton then if var2 == "Fill" then nil else Enum.AutomaticSize.X elseif var2 == "Fill" then Enum.AutomaticSize.Y else Enum.AutomaticSize.XY

    tbl1.BackgroundTransparency = 1
    tbl1.BorderSizePixel = 0
    local tag = React.Tag
    tbl1[tag] = if FFlagLuaAppMediaGalleryGamepadSupport then nil else arg1.tag
    local tbl2 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = if var2 == "Fill" then Enum.UIFlexAlignment.Fill else Enum.UIFlexAlignment.None,
            Padding = UDim.new(0, offset2),
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        PlayButton = React.createElement(
            PlayButtonView,
            (makePlayButtonProps(
                arg1,
                arg1.playButtonState,
                arg1.onPlayButtonActivated,
                arg1.playButtonCaptureRef,
                arg1.loadingCaptureRef,
                fillBehavior,
                1,
                arg1.testId,
                if FFlagLuaAppMediaGalleryGamepadSupport then arg1.tag else nil,
                if FFlagEnableGameJoinEarlyAccess then arg1.showEarlyAccessTooltip else nil
            ))
        ),
        PopForcePicker = if SharedFlags.FFlagDebugEnablePopForcePicker then React.createElement(require(script.Parent.PopForcePicker), { LayoutOrder = 3 }) else nil,
        SecondaryPlayButton = if arg1.secondaryPlayButtonState then React.createElement(
            PlayButtonView,
            (makePlayButtonProps(
                arg1,
                arg1.secondaryPlayButtonState,
                arg1.onSecondaryPlayButtonActivated or func1,
                nil,
                nil,
                fillBehavior,
                2,
                var3
            ))
        ) else nil
    }
    return createElement(str1, tbl1, tbl2)
end)
