-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local Roact = require(GamePlayButtonParent.Roact)
local React = require(GamePlayButtonParent.React)
local t = require(GamePlayButtonParent.t)
local PlayButtonStates = require(script.Parent.PlayButtonStates)
local UIBlox = require(GamePlayButtonParent.UIBlox)
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local ComboButton = UIBlox.App.Button.ComboButton
local withLocalization = require(GamePlayButtonParent.Localization).withLocalization

local GetFFlagIsSquadEnabled = require(GamePlayButtonParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagLuaAppPlayButtonLoadingPrimary = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonLoadingPrimary
local GetFFlagUIBloxUseFoundationButton = require(GamePlayButtonParent.SharedFlags).UIBlox.GetFFlagUIBloxUseFoundationButton

local FFlagLuaAppPlayButtonOptOutFoundationButton = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonOptOutFoundationButton

local FFlagLuaAppPlayLoadingClickTelemetryMobile = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayLoadingClickTelemetryMobile
local FFlagLuaAppTextOnlyPlayButton = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppTextOnlyPlayButton
local FFlagLuaAppIconTextPlayButton = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppIconTextPlayButton
local FFlagLuaAppUpdatePlayButtonText = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppUpdatePlayButtonText
local FFlagLuaAppPlayButtonPrivatePT = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePT
local FFlagEnableGameJoinEarlyAccess = require(GamePlayButtonParent.SharedFlags).FFlagEnableGameJoinEarlyAccess

local Images = UIBlox.App.ImageSet.Images

local iconsCommonPlay = Images["icons/common/play"]
local iconsStatusUnavailable = Images["icons/status/unavailable"]
local iconsCommonRobux = Images["icons/common/robux"]
local iconsActionsTruncationCollapse = Images["icons/actions/truncationCollapse"]

local var1 = Roact.PureComponent:extend("PlayButton")

var1.validateProps = t.strictInterface({
    price = t.number,
    localizedFiatPrice = t.string,
    playButtonState = t.string,
    onPlayButtonActivated = t.callback,
    onPlaySquadButtonActivated = if GetFFlagIsSquadEnabled() then t.callback else nil,
    Size = t.optional(t.UDim2),
    LayoutOrder = t.optional(t.number),
    testId = t.optional(t.string)
})

function var1.renderWithLocalization(arg1, arg2)
    local propsSize = arg1.props.Size
    local layoutOrder = arg1.props.LayoutOrder
    local price = arg1.props.price
    local playButtonState = arg1.props.playButtonState
    local onPlayButtonActivated = arg1.props.onPlayButtonActivated
    local onPlaySquadButtonActivated = arg1.props.onPlaySquadButtonActivated

    local bool1 = false
    local bool2 = false
    local var2 = not GetFFlagIsSquadEnabled() and nil
    local var3 = not GetFFlagIsSquadEnabled() and nil
    local var4 = nil
    local var5 = nil
    local var6 = nil
    if playButtonState == PlayButtonStates.Loading then
        if FFlagLuaAppPlayButtonLoadingPrimary then
            var4 = ButtonType.PrimaryContextual
        else
            var4 = ButtonType.Secondary
        end

        bool1 = true
    elseif playButtonState == PlayButtonStates.Playable then
        var4 = ButtonType.PrimaryContextual
        if FFlagLuaAppTextOnlyPlayButton or FFlagLuaAppIconTextPlayButton then
            if FFlagLuaAppUpdatePlayButtonText then
                var6 = arg2.play
            else
                var6 = arg2.join
            end
        end
        if not FFlagLuaAppTextOnlyPlayButton then
            var5 = iconsCommonPlay
        end
    elseif GetFFlagIsSquadEnabled() and playButtonState == PlayButtonStates.PlayableWithParty then
        var5 = iconsCommonPlay
        var6 = arg2.joinWithParty
        var2 = true
    elseif GetFFlagIsSquadEnabled() and playButtonState == PlayButtonStates.WaitingForParty then
        var5 = iconsCommonPlay
        var6 = arg2.waitingForParty
        var2 = true
        bool2 = true
        var3 = true
    elseif playButtonState == PlayButtonStates.PaidAccess then
        var4 = ButtonType.PrimaryContextual
        var5 = iconsCommonRobux
        var6 = tostring(price)
    elseif playButtonState == PlayButtonStates.FiatPaidAccess then
        var4 = ButtonType.PrimaryContextual
        var6 = arg1.props.localizedFiatPrice
    elseif playButtonState == PlayButtonStates.DemoMode then
        var4 = ButtonType.PrimarySystem
        var6 = arg2.playDemo
    elseif FFlagLuaAppPlayButtonPrivatePT and playButtonState == PlayButtonStates.Playtest then
        var4 = ButtonType.PrimarySystem
        var6 = arg2.playtest
    elseif playButtonState == PlayButtonStates.ActionNeeded then
        var4 = ButtonType.PrimaryContextual
        var6 = arg2.unlock
    elseif playButtonState == PlayButtonStates.UnplayableOther then
        var4 = ButtonType.Secondary
        var5 = iconsStatusUnavailable
        var6 = arg2.unavailable
        bool2 = true
    elseif FFlagEnableGameJoinEarlyAccess and playButtonState == PlayButtonStates.EarlyAccessLocked then
        var4 = ButtonType.Secondary
        var6 = arg2.unavailable
        bool2 = true
    else
        error("invalid play button state!")
    end

    if GetFFlagIsSquadEnabled() and var2 then
        return Roact.createElement(ComboButton, {
            layoutOrder = layoutOrder,
            size = propsSize,
            button = {
                icon = var5,
                text = var6,
                isDisabled = bool2,
                onActivated = bool2 and function() end or onPlayButtonActivated
            },
            overflow = {
                icon = iconsActionsTruncationCollapse,
                isDisabled = var3,
                onActivated = var3 and function() end or onPlaySquadButtonActivated
            },
            testId = arg1.props.testId
        })
    end
    local playButton = Roact.createElement(Button, {
        size = if FFlagLuaAppPlayLoadingClickTelemetryMobile then UDim2.fromScale(1, 1) else propsSize,
        layoutOrder = layoutOrder,
        isLoading = bool1,
        icon = var5,
        text = var6,
        buttonType = var4,
        userInteractionEnabled = not bool2,
        isDisabled = bool2,
        onActivated = bool2 and function() end or onPlayButtonActivated,
        [React.Tag] = if arg1.props.testId then `data-testid={arg1.props.testId}` else nil,
        DO_NOT_USE_useUIBloxButton = if GetFFlagUIBloxUseFoundationButton() then true elseif FFlagLuaAppPlayButtonOptOutFoundationButton then true else nil
    })

    if not FFlagLuaAppPlayLoadingClickTelemetryMobile then
        return playButton
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = propsSize,
        LayoutOrder = layoutOrder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl2 = {
        PlayButton = playButton,
        LoadingTelemetryClickCatcher = if bool1 then Roact.createElement("TextButton", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            ZIndex = 2,
            [Roact.Event.Activated] = onPlayButtonActivated
        }) else nil
    }
    return createElement(str1, tbl1, tbl2)
end

function var1.render(arg1)
    return withLocalization({
        join = "Feature.ExperienceDetails.PlayButtonText.ActionNeeded",
        play = if (FFlagLuaAppTextOnlyPlayButton or FFlagLuaAppIconTextPlayButton) and FFlagLuaAppUpdatePlayButtonText then "Feature.ExperienceDetails.PlayButtonText.Play" else nil,
        unlock = "Feature.ExperienceDetails.PlayButtonText.Unlock",
        joinWithParty = "Feature.Squads.Action.JoinWithParty",
        unavailable = "Feature.ExperienceDetails.PlayButtonText.Unavailable",
        waitingForParty = "Feature.Squads.Action.WaitingForParty",
        playDemo = "Feature.ExperienceDetails.PlayButtonText.PlayDemo",
        playtest = if FFlagLuaAppPlayButtonPrivatePT then "Feature.ExperienceDetails.PlayButtonText.Playtest" else nil
    })(
        function(arg2)
            return arg1:renderWithLocalization(arg2)
        end
    )
end
return var1
