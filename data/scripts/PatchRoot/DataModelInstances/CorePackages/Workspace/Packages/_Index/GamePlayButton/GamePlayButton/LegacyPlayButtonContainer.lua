-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local Cryo = require(GamePlayButtonParent.Cryo)
local t = require(GamePlayButtonParent.t)
local GamesProductInfoReducer = require(GamePlayButtonParent.GameProductInfoRodux).GamesProductInfoReducer
local Roact = require(GamePlayButtonParent.Roact)
local RoactRodux = require(GamePlayButtonParent.RoactRodux)
local RoactNetworking = require(GamePlayButtonParent.RoactServiceTags).RoactNetworking
local PlayButtonStates = require(script.Parent.PlayButtonStates)
local useOnPlayButtonCallback = require(script.Parent.useOnPlayButtonCallback)
local useOnPlaySquadButtonCallback = require(script.Parent.useOnPlaySquadButtonCallback)
local usePlayButtonState = require(script.Parent.usePlayButtonState)
local PlayButtonView = require(script.Parent.PlayButtonView)
local useLocalization = require(GamePlayButtonParent.Localization).Hooks.useLocalization
local Foundation = require(GamePlayButtonParent.Foundation)
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local MenuDirection = require(GamePlayButtonParent.UIBlox).App.Menu.MenuDirection

local LegacyPlayButton = require(script.Parent.LegacyPlayButton)

local GetFFlagIsSquadEnabled = require(GamePlayButtonParent.SharedFlags).GetFFlagIsSquadEnabled

local FFlagLuaAppPlayButtonLoadingDurationTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonLoadingDurationTelemetry

local FFlagLuaAppMobileEdpPlayButtonPartialUnificationIXP = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppMobileEdpPlayButtonPartialUnificationIXP

local FIntLuaAppPlayButtonSecondaryButtonGap = require(GamePlayButtonParent.SharedFlags).FIntLuaAppPlayButtonSecondaryButtonGap
local FFlagLuaAppPlayButtonPrivatePT = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppPlayButtonPrivatePT

local function func1(arg1)
    local localized = useLocalization({
        join = "Feature.ExperienceDetails.PlayButtonText.ActionNeeded",
        play = "Feature.ExperienceDetails.PlayButtonText.Play",
        playDemo = "Feature.ExperienceDetails.PlayButtonText.PlayDemo",
        playtest = if FFlagLuaAppPlayButtonPrivatePT then "Feature.ExperienceDetails.PlayButtonText.Playtest" else nil,
        unlock = "Feature.ExperienceDetails.PlayButtonText.Unlock",
        joinWithParty = "Feature.Squads.Action.JoinWithParty",
        unavailable = "Feature.ExperienceDetails.PlayButtonText.Unavailable",
        waitingForParty = "Feature.Squads.Action.WaitingForParty"
    })

    local tokens = useTokens()

    return Roact.createElement(
        "Frame",
        {
            Size = arg1.Size,
            LayoutOrder = arg1.LayoutOrder,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        {
            PlayButtonView = Roact.createElement(PlayButtonView, {
                playButtonState = arg1.playButtonState,
                gameProductInfo = arg1.gameProductInfo,
                localized = localized,
                tokens = tokens,
                onPlayButtonActivated = arg1.onPlayButtonActivated,
                onPlaySquadButtonActivated = arg1.onPlaySquadButtonActivated or function() end,
                shouldLaunchWhenLoading = false,
                shouldLaunchOnReleaseAfterUnmount = false,
                squadButtonMenuDirection = MenuDirection.Up,
                buttonSize = InputSize.Large,
                width = UDim.new(1, 0),
                useUIBloxButton = true,
                testId = arg1.testId
            })
        }
    )
end
local var1 = Roact.PureComponent:extend("PlayButtonContainer")

local strictInterface = t.strictInterface
local tbl1 = {
    universeId = t.string,
    Size = t.optional(t.UDim2),
    LayoutOrder = t.optional(t.number),
    referralSource = t.optional(t.string),
    experienceJoinData = t.optional(t.table),
    placeId = t.optional(t.string),
    testId = t.optional(t.string),
    shouldUseUnifiedPlayButtonView = if FFlagLuaAppMobileEdpPlayButtonPartialUnificationIXP then t.optional(t.boolean) else nil,
    onPlayButtonCallback = t.callback,
    onPlaySquadButtonCallback = if GetFFlagIsSquadEnabled() then t.callback else nil,
    playButtonState = t.string,
    secondaryPlayButtonState = t.optional(t.string),
    gameProductInfo = t.optional(t.table)
}
var1.validateProps = strictInterface(tbl1)

function var1.init(arg1)
    arg1.isMounted = false

    function arg1.onPlayButtonActivated()
        if not arg1.isMounted then
            return
        end

        arg1.props.onPlayButtonCallback(arg1.props.playButtonState)
    end

    function arg1.onSecondaryPlayButtonActivated()
        if not arg1.isMounted then
            return
        end

        arg1.props.onPlayButtonCallback(arg1.props.secondaryPlayButtonState)
    end

    arg1.onPlaySquadButtonActivated = GetFFlagIsSquadEnabled() and function(arg2)
        if not arg1.isMounted then
            return
        end

        arg1.props.onPlaySquadButtonCallback(arg2)
    end or nil
end

function var1.didMount(arg1)
    arg1.isMounted = true
end

function var1.willUnmount(arg1)
    arg1.isMounted = false
end

function var1.render(arg1)
    local propsSize = arg1.props.Size
    local layoutOrder = arg1.props.LayoutOrder
    local playButtonState = arg1.props.playButtonState
    local gameProductInfo = arg1.props.gameProductInfo
    local price = gameProductInfo and gameProductInfo.price or 0

    if FFlagLuaAppMobileEdpPlayButtonPartialUnificationIXP and arg1.props.shouldUseUnifiedPlayButtonView then
        if arg1.props.secondaryPlayButtonState == nil then
            return Roact.createElement(func1, {
                Size = propsSize,
                LayoutOrder = layoutOrder,
                playButtonState = playButtonState,
                gameProductInfo = gameProductInfo,
                onPlayButtonActivated = arg1.onPlayButtonActivated,
                onPlaySquadButtonActivated = arg1.onPlaySquadButtonActivated,
                testId = arg1.props.testId
            })
        end

        local uDim2 = UDim2.new(0.5, -FIntLuaAppPlayButtonSecondaryButtonGap / 2, 1, 0)

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl2 = {
            Size = propsSize,
            LayoutOrder = layoutOrder,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        local tbl3 = {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, FIntLuaAppPlayButtonSecondaryButtonGap)
            }),
            PlayButton = Roact.createElement(func1, {
                Size = uDim2,
                LayoutOrder = 1,
                playButtonState = playButtonState,
                gameProductInfo = gameProductInfo,
                onPlayButtonActivated = arg1.onPlayButtonActivated,
                onPlaySquadButtonActivated = arg1.onPlaySquadButtonActivated,
                testId = arg1.props.testId
            }),
            SecondaryPlayButton = Roact.createElement(func1, {
                Size = uDim2,
                LayoutOrder = 2,
                playButtonState = arg1.props.secondaryPlayButtonState,
                gameProductInfo = gameProductInfo,
                onPlayButtonActivated = arg1.onSecondaryPlayButtonActivated,
                onPlaySquadButtonActivated = arg1.onPlaySquadButtonActivated,
                testId = if arg1.props.testId then arg1.props.testId .. "--secondary" else nil
            })
        }
        return createElement(str1, tbl2, tbl3)
    end

    if arg1.props.secondaryPlayButtonState == nil then
        return Roact.createElement(LegacyPlayButton, {
            Size = propsSize,
            LayoutOrder = layoutOrder,
            playButtonState = playButtonState,
            price = price,
            localizedFiatPrice = gameProductInfo and gameProductInfo.localizedFiatPrice or "",
            onPlayButtonActivated = arg1.onPlayButtonActivated,
            onPlaySquadButtonActivated = if GetFFlagIsSquadEnabled() then arg1.onPlaySquadButtonActivated else nil,
            testId = arg1.props.testId
        })
    end

    local uDim2 = UDim2.new(0.5, -FIntLuaAppPlayButtonSecondaryButtonGap / 2, 1, 0)

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = propsSize,
        LayoutOrder = layoutOrder,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl3 = {
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, FIntLuaAppPlayButtonSecondaryButtonGap)
        }),
        PlayButton = Roact.createElement(LegacyPlayButton, {
            Size = uDim2,
            LayoutOrder = 1,
            playButtonState = playButtonState,
            price = price,
            localizedFiatPrice = gameProductInfo and gameProductInfo.localizedFiatPrice or "",
            onPlayButtonActivated = arg1.onPlayButtonActivated,
            onPlaySquadButtonActivated = if GetFFlagIsSquadEnabled() then arg1.onPlaySquadButtonActivated else nil,
            testId = arg1.props.testId
        }),
        SecondaryPlayButton = Roact.createElement(LegacyPlayButton, {
            Size = uDim2,
            LayoutOrder = 2,
            playButtonState = arg1.props.secondaryPlayButtonState,
            price = price,
            localizedFiatPrice = gameProductInfo and gameProductInfo.localizedFiatPrice or "",
            onPlayButtonActivated = arg1.onSecondaryPlayButtonActivated,
            onPlaySquadButtonActivated = if GetFFlagIsSquadEnabled() then arg1.onPlaySquadButtonActivated else nil,
            testId = if arg1.props.testId then arg1.props.testId .. "--secondary" else nil
        })
    }
    return createElement(str1, tbl2, tbl3)
end

return (RoactRodux.connect(function(arg1, arg2)
    local universeId = arg2.universeId
    return {
        gameProductInfo = arg1[GamesProductInfoReducer.key][universeId]
    }
end)(function(arg1)
    local var2 = useRoactService(RoactNetworking)
    local var3 = usePlayButtonState(
        var2,
        arg1.universeId,
        nil,
        nil,
        if FFlagLuaAppPlayButtonLoadingDurationTelemetry then true else nil,
        if FFlagLuaAppPlayButtonLoadingDurationTelemetry then "PlayButton" else nil
    )

    local onPlayButtonCallback = useOnPlayButtonCallback(
        arg1.universeId,
        arg1.referralSource,
        "PlayButton",
        nil,
        "LuaGameCard",
        arg1.experienceJoinData,
        arg1.placeId
    )
    local onPlaySquadButtonCallback = if GetFFlagIsSquadEnabled() then useOnPlaySquadButtonCallback(MenuDirection.Up, var3.playButtonState, arg1.referralSource, arg1.universeId) else nil
    local playButtonState = var3.playButtonState
    local secondaryPlayButtonState = var3.secondaryPlayButtonState
    if secondaryPlayButtonState ~= nil then
        local bool1 = playButtonState == PlayButtonStates.UnplayableOther
        local bool2 = secondaryPlayButtonState == PlayButtonStates.UnplayableOther

        if bool1 and not bool2 then
            playButtonState = secondaryPlayButtonState
            secondaryPlayButtonState = nil
        elseif bool2 then
            secondaryPlayButtonState = nil
        end
    end

    local var6 = Cryo.Dictionary.join(arg1, {
        onPlayButtonCallback = onPlayButtonCallback,
        onPlaySquadButtonCallback = onPlaySquadButtonCallback,
        playButtonState = playButtonState,
        secondaryPlayButtonState = secondaryPlayButtonState
    })

    return Roact.createElement(var1, var6)
end))
