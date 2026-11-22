-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local dependencies = require(Squads.dependencies)
local React = dependencies.React
local Foundation = dependencies.Foundation
local LuauPolyfill = dependencies.LuauPolyfill
local useSelector = dependencies.Hooks.useSelector
local useDispatch = dependencies.Hooks.useDispatch
local useLocalization = dependencies.Hooks.useLocalization

local setTimeout = LuauPolyfill.setTimeout
local clearTimeout = LuauPolyfill.clearTimeout

local ButtonVariant = Foundation.Enums.ButtonVariant
local DialogSize = Foundation.Enums.DialogSize
local IconSize = Foundation.Enums.IconSize
local ProgressShape = Foundation.Enums.ProgressShape
local ProgressSize = Foundation.Enums.ProgressSize
local Button = Foundation.Button
local Dialog = Foundation.Dialog
local Icon = Foundation.Icon
local Image = Foundation.Image
local OverlayProvider = Foundation.OverlayProvider
local Progress = Foundation.Progress
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local ReactOtter = require(SquadsParent.ReactOtter)

local getRbxthumbWithTypeSizeAndOptions = require(SquadsParent.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = require(SquadsParent.UserLib).Utils.Constants

local CreateExperienceInvite = require(Squads.Thunks.CreateExperienceInvite)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local Enums = require(SquadsParent.SquadsCore.Enums)
local SquadExperienceInviteSource = Enums.SquadExperienceInviteSource
local SquadLuckyRecommendationPhase = Enums.SquadLuckyRecommendationPhase
local Hooks = require(SquadsParent.SquadsCore.Hooks)
local useLuckyRecommendation = Hooks.useLuckyRecommendation
local useLuckyRecommendationAnalytics = Hooks.useLuckyRecommendationAnalytics
local useIsExperienceInviteRetryBlocked = Hooks.useIsExperienceInviteRetryBlocked
local FFlagUseSignalsForSquadExperienceInvite = dependencies.SharedFlags.FFlagUseSignalsForSquadExperienceInvite
local GetSquadExperienceInviteStore = require(SquadsParent.SquadsCore.Stores).GetSquadExperienceInviteStore
local useSignalState = require(SquadsParent.SignalsReact).useSignalState
local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SQUAD_LOBBY_MODAL_DISPLAY_ORDER = require(Squads.Common.Constants).SQUAD_LOBBY_MODAL_DISPLAY_ORDER

local function SquadLobbyLuckyRecommendationModal(tbl1)
    local var1 = useTokens()
    local var2 = useDispatch()

    local size300 = var1.Size.Size_300
    local var3 = React.useContext(SquadExternalContractContext)
    local var4 = useLuckyRecommendation()
    local state = var4.state
    local actions = var4.actions

    local sessionId = tbl1.sessionId
    local var5 = useLuckyRecommendationAnalytics(sessionId)

    local var6 = useLocalization({
        rollingTitle = "Feature.Squads.Label.LuckyRecommendationRolling",
        rollingSubtitle = "Feature.Squads.Description.LuckyRecommendationRolling",
        revealedTitle = "Feature.Squads.Label.LuckyRecommendationRevealed",
        revealedSubtitle = "Feature.Squads.Description.LuckyRecommendationRevealed",
        errorTitle = "CommonUI.Messages.Response.SomethingWentWrong",
        joinText = "Feature.Squads.Action.JoinWithParty",
        cancelText = "CommonUI.Controls.Action.Cancel",
        retryText = "Feature.Squads.Action.Retry"
    })

    local phase = state.phase
    local bool1 = phase == SquadLuckyRecommendationPhase.Rolling
    local bool2 = phase == SquadLuckyRecommendationPhase.Revealed
    local bool3 = bool2 or phase == SquadLuckyRecommendationPhase.Errored
    local recommendation = if state.phase == SquadLuckyRecommendationPhase.Revealed then state.recommendation else nil
    local universeId = recommendation and recommendation.universeId
    local rootPlaceId = recommendation and recommendation.rootPlaceId
    local image = if universeId == nil then nil else getRbxthumbWithTypeSizeAndOptions(tostring(universeId), Constants.RbxthumbTypes.GameIcon, 150, false)

    local var7 = React.useCallback(function(arg1)
        return arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentSquad and arg1.Squad.Squad.currentSquad.squadId
    end, {})
    local var8 = useSelector(var7)

    local var9 = React.useCallback(function(arg1)
        return arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentExperienceInvite
    end, {})

    local isActionDisabled = if FFlagUseSignalsForSquadExperienceInvite then useSignalState(GetSquadExperienceInviteStore(false).getHasCurrentExperienceInvite) else useSelector(var9) ~= nil
    local var10 = useIsExperienceInviteRetryBlocked(var8)

    local var11 = React.useCallback(function()
        var5.fire(EventNames.LuckyRecommendationDismissed, { phaseAtDismiss = phase })

        tbl1.onClose()
    end, { var5, phase, tbl1.onClose })

    local var12 = React.useCallback(function()
        var5.fire(EventNames.LuckyRecommendationRerolled, { phaseAtReroll = phase })

        actions.startRoll(var8, false)
    end, {
        actions.startRoll,
        var8,
        var5,
        phase
    })
    local onAction = React.useCallback(function()
        local context = var5.getContext()
        var5.fire(EventNames.LuckyRecommendationJoinTapped, { rootPlaceId = rootPlaceId })

        if rootPlaceId == nil then
            return
        end
        var2(CreateExperienceInvite(tostring(rootPlaceId), var3, SquadExperienceInviteSource.LuckyRecommendation)):andThen(
            function(experienceInviteId: string)
                if not experienceInviteId then
                    return
                end

                var5.fire(EventNames.LuckyRecommendationExperienceInviteCreated, {
                    pickRequestId = context.pickRequestId,
                    revealType = context.revealType,
                    rootPlaceId = rootPlaceId,
                    experienceInviteId = experienceInviteId
                })
            end
        )
    end, {
        var2,
        rootPlaceId,
        var3,
        var5
    })
    React.useLayoutEffect(function()
        actions.startRoll(var8, true)
    end, { actions.startRoll, var8 })

    React.useEffect(function()
        if phase == SquadLuckyRecommendationPhase.Rolling then
            local var14 = setTimeout(actions.endRoll, 1000)
            return function()
                clearTimeout(var14)
            end
        end
    end, { phase, actions.endRoll })

    React.useEffect(function()
        return function()
            actions.cancelFetch()
        end
    end, { actions.cancelFetch })

    React.useEffect(function()
        if phase == SquadLuckyRecommendationPhase.Revealed then
            var5.fire(EventNames.LuckyRecommendationRevealShown, { universeId = universeId })
        elseif phase == SquadLuckyRecommendationPhase.Errored then
            var5.fire(EventNames.LuckyRecommendationErrorShown, { errorType = state.error })
        end
    end, {
        phase,
        var5,
        state,
        universeId
    })
    local value, var15 = ReactOtter.useAnimatedBinding(0)

    React.useEffect(function()
        if bool1 then
            var15(ReactOtter.ease(100, { duration = 1, easingStyle = Enum.EasingStyle.Quad, startingValue = 0 }))
            return
        end

        if bool3 then
            var15(ReactOtter.ease(100, { duration = 0 }))
        end
    end, { bool1, bool3, var15 })

    local var16 = bool2
        and {
            title = var6.revealedTitle,
            subtitle = var6.revealedSubtitle,
            actionText = var6.joinText,
            onAction = onAction,
            isActionDisabled = isActionDisabled or var10
        }
        or bool3 and {
            title = var6.errorTitle,
            actionText = var6.retryText,
            onAction = var12
        }
        or {
            title = var6.rollingTitle,
            subtitle = var6.rollingSubtitle,
            actionText = var6.cancelText,
            onAction = var11
        }

    local tbl2 = {
        Title = React.createElement(FoundationText, {
            tag = "size-full-0 auto-y text-heading-small text-align-x-left content-emphasis",
            LayoutOrder = 1,
            Text = var16.title,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lucky-recommendation-dialog--title" else nil
        })
    }
    if var16.subtitle ~= nil then
        tbl2.Subtitle = React.createElement(FoundationText, {
            tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
            LayoutOrder = 2,
            Text = var16.subtitle,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lucky-recommendation-dialog--subtitle" else nil
        })
    end

    local tbl3 = {
        Header = React.createElement(View, { tag = "col gap-small size-full-0 auto-y", LayoutOrder = 1 }, tbl2)
    }

    if recommendation then
        tbl3.GameResult = React.createElement(View, {
            tag = "row align-y-center gap-medium size-full-0 auto-y padding-large stroke-standard stroke-position-inner stroke-default radius-medium bg-surface-200",
            LayoutOrder = 2
        }, {
            Thumbnail = if image then React.createElement(Image, {
                tag = "radius-small",
                LayoutOrder = 1,
                Image = image,
                Size = UDim2.fromOffset(var1.Size.Size_1000, var1.Size.Size_1000),
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lucky-recommendation-dialog--game-thumbnail" else nil
            }) else nil,
            GameInfo = React.createElement(
                View,
                {
                    tag = "col align-y-center fill",
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 0, var1.Size.Size_1000)
                },
                {
                    GameName = React.createElement(FoundationText, {
                        tag = "size-full-0 auto-y text-title-medium text-no-wrap text-align-x-left text-truncate-end content-emphasis",
                        LayoutOrder = 1,
                        Text = recommendation.universeName,
                        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lucky-recommendation-dialog--game-name" else nil
                    })
                }
            )
        })
    end
    if not bool3 then
        tbl3.ProgressBar = React.createElement(
            View,
            {
                tag = "row align-y-center size-full-0",
                LayoutOrder = 3,
                Size = UDim2.new(1, 0, 0, var1.Size.Size_500)
            },
            {
                Bar = React.createElement(Progress, {
                    shape = ProgressShape.Bar,
                    size = ProgressSize.Medium,
                    value = value,
                    width = UDim.new(1, 0),
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lucky-recommendation-dialog--progress" else nil
                })
            }
        )
    end
    local createElement = React.createElement
    local var17 = OverlayProvider
    local tbl4 = { DisplayOrder = SQUAD_LOBBY_MODAL_DISPLAY_ORDER }
    local tbl5 = { Dialog = 0 }
    local createElement2 = React.createElement
    local root = Dialog.Root
    local tbl6 = {
        onClose = var11,
        size = DialogSize.Small,
        hasBackdrop = tbl1.hasBackdrop == nil or tbl1.hasBackdrop,
        disablePortal = not (tbl1.disablePortal == nil) and tbl1.disablePortal,
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lucky-recommendation-dialog" else nil
    }
    local tbl7 = { Content = 0 }
    local createElement3 = React.createElement
    local var18 = View
    local tbl8 = { tag = "size-full-0 auto-y", LayoutOrder = 1 }

    local tbl9 = {
        Main = React.createElement(
            View,
            {
                tag = "col size-full-0 auto-y",
                padding = {
                    top = UDim.new(0, size300 + var1.Size.Size_200)
                }
            },
            {
                Body = React.createElement(View, { tag = "col gap-large size-full-0 auto-y padding-bottom-large", LayoutOrder = 1 }, tbl3),
                ActionButton = React.createElement(Button, {
                    LayoutOrder = 2,
                    onActivated = var16.onAction,
                    text = var16.actionText,
                    variant = ButtonVariant.Standard,
                    width = UDim.new(1, 0),
                    isDisabled = var16.isActionDisabled,
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lucky-recommendation-dialog--action-button" else nil
                })
            }
        ),
        ResetButton = 0
    }
    local element

    if bool2 then
        element = React.createElement(View, {
            tag = "row align-x-center align-y-center auto-xy padding-small radius-circle clip bg-over-media-100",
            onActivated = var12,
            Size = UDim2.fromOffset(var1.Size.Size_1000, var1.Size.Size_1000),
            AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -var1.Size.Size_1000, 0, size300),
            ZIndex = 2,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lucky-recommendation-dialog--reroll-button" else nil
        }, {
            Icon = React.createElement(Icon, { name = "arrow-spin-clockwise", size = IconSize.Small, style = var1.Color.Content.Emphasis })
        })
    else
        element = nil
    end

    tbl9.ResetButton = element
    tbl7.Content = createElement3(var18, tbl8, tbl9)
    tbl5.Dialog = createElement2(root, tbl6, tbl7)
    return (createElement(var17, tbl4, tbl5))
end

return SquadLobbyLuckyRecommendationModal
