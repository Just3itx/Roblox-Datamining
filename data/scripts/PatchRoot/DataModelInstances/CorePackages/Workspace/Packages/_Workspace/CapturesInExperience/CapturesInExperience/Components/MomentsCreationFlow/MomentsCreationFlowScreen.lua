-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

if require(scriptParentParentParent.Flags.FFlagCapturesInExpUseMomentsCreation) then
    local momentsCommon = require(scriptParentParentParentParent.MomentsCommon)
    local _momentsTypes = require(scriptParentParentParentParent.MomentsTypes)
    local react = require(scriptParentParentParentParent.React)
    local roactUtils = require(scriptParentParentParentParent.RoactUtils)
    local signals = require(scriptParentParentParentParent.Signals)
    local CoreGui = game:GetService("CoreGui")

    local useDispatch = roactUtils.Hooks.RoactRodux.useDispatch
    local useSelector = roactUtils.Hooks.RoactRodux.useSelector

    local constants = require(scriptParentParentParent.Constants)
    local fFlagCapturesInExpStickersAndVoice = require(scriptParentParentParent.Flags.FFlagCapturesInExpStickersAndVoice)
    local momentsCreationFlowClosed = require(scriptParentParentParent.Actions.MomentsCreationFlowClosed)
    local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

    local eventNames = momentsCommon.Analytics.EventNames

    local tbl1 = {
        [eventNames.EditingFlowNextButtonPressed] = true,
        [eventNames.EditingFlowReturnButtonPressed] = true
    }

    local function isTextFiltered(_: string): boolean
        return false
    end

    local function MomentsCreationScreen(tbl2)
        local momentsCreation = require(scriptParentParentParentParent.MomentsCreation)
        local createMoment = require(scriptParentParentParent.Thunks.CreateMoment)
        local creationFlowScreen = momentsCreation.CreationFlowScreen
        local getCreationFlowStore = momentsCreation.Stores.GetCreationFlowStore

        local var1, var2 = react.useState(function()
            return getCreationFlowStore(false).getSelectedCapture(false)
        end)
        react.useEffect(function()
            return signals.createEffect(function(arg1)
                var2(getCreationFlowStore(arg1).getSelectedCapture(arg1))
            end)
        end, { getCreationFlowStore })
        local bool1 = var1 == tbl2.expectedCapture
        local var3 = useDispatch()
        local fireEvent = useAnalytics().fireEvent
        local creationSessionId = useSelector(function(arg1)
            return arg1[constants.RoduxKey].MomentsCreationFlow.SessionId
        end)

        local registerAnalyticsListener = momentsCreation.registerAnalyticsListener

        react.useLayoutEffect(function()
            return registerAnalyticsListener(function(str1: string, tbl3)
                local var5 = table.clone(tbl3 or {})
                var5.creationSessionId = creationSessionId
                if tbl1[str1] then
                    var5.editFlowState = getCreationFlowStore(false).getStep(false)
                end
                fireEvent("XExp" .. str1, var5)
            end)
        end, {
            getCreationFlowStore,
            fireEvent,
            registerAnalyticsListener,
            creationSessionId
        })
        local exitCreationFlow = react.useCallback(function()
            var3(momentsCreationFlowClosed())
        end, { var3 })

        local var4 = react.useCallback(function(arg1, arg2, str1: string, str2: string?, _: number?, bool2: boolean?)
            var3(createMoment(arg1, arg2, str1, str2, nil, bool2))
        end, { var3, createMoment })

        local host = react.useMemo(function()
            return {
                createMoment = var4,
                disableDrafts = true,
                disableExperimentExposure = not fFlagCapturesInExpStickersAndVoice,
                exitCreationFlow = exitCreationFlow,
                isTextFiltered = isTextFiltered,
                publishDebounceSeconds = 0.5,
                toolKinds = not fFlagCapturesInExpStickersAndVoice and { "trim", "music", "text" } or nil,
                ttsAudioParent = if fFlagCapturesInExpStickersAndVoice then CoreGui else nil
            }
        end, { var4, exitCreationFlow })

        react.useEffect(function()
            if bool1 then
                return
            end

            if fFlagCapturesInExpStickersAndVoice then
                momentsCreation.resetCreationFlow(momentsCreation.Enums.CreationFlowState.Preview)
            end
            var3(momentsCreationFlowClosed())
        end, { bool1, var3, momentsCreation })

        if not bool1 then
            return nil
        end

        return react.createElement(creationFlowScreen, { excludeGallery = true, host = host })
    end

    local function MomentsCreationFlowScreen()
        local var1 = useSelector(function(arg1)
            return arg1[constants.RoduxKey].MomentsCreationFlow.IsOpen
        end)
        local expectedCapture = useSelector(function(arg1)
            return arg1[constants.RoduxKey].MomentsCreationFlow.Capture
        end)

        if not var1 or expectedCapture == nil then
            return nil
        end

        return react.createElement(MomentsCreationScreen, { expectedCapture = expectedCapture })
    end

    return MomentsCreationFlowScreen
end

local Cryo = require(scriptParentParentParentParent.Cryo)
local Dash = require(scriptParentParentParentParent.Dash)
local Localization = require(scriptParentParentParentParent.Localization)
local MomentsCommon = require(scriptParentParentParentParent.MomentsCommon)
local MomentsCreationFlow = require(scriptParentParentParentParent.MomentsCreationFlow)
local _MomentsTypes = require(scriptParentParentParentParent.MomentsTypes)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useLocalization = Localization.Hooks.useLocalization
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local CreateMoment = require(scriptParentParentParent.Thunks.CreateMoment)

local Constants = require(scriptParentParentParent.Constants)
local MomentsCreationFlowClosed = require(scriptParentParentParent.Actions.MomentsCreationFlowClosed)
local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)

local CreationFlowContextProvider = MomentsCreationFlow.CreationFlowContextProvider
local CreationFlowLocalization = MomentsCreationFlow.CreationFlowLocalization
local CreationFlowScreen = MomentsCreationFlow.CreationFlowScreen

local FFlagMomentsCreationBackCta = MomentsCommon.Flags.FFlagMomentsCreationBackCta

local tbl1 = {
    [CreationFlowLocalization.CommunityStandardsText] = "Feature.Moments.Description.CommunityStandards",
    [CreationFlowLocalization.CreationTooltip] = "Feature.Moments.Tooltip.Creation",
    [CreationFlowLocalization.EditingCtaMusic] = "Feature.Moments.Action.AddMusic",
    [CreationFlowLocalization.EditingCtaTextOverlay] = "Feature.Moments.Action.AddText",
    [CreationFlowLocalization.EditingCtaTrimming] = "Feature.Moments.Action.TrimVideo",
    [CreationFlowLocalization.GeneralAllChipLabel] = "Feature.Moments.Label.All",
    [CreationFlowLocalization.GeneralCtaBack] = "Feature.Moments.Action.Back",
    [CreationFlowLocalization.GeneralCtaCancel] = "Feature.Moments.Action.Cancel",
    [CreationFlowLocalization.GeneralCtaDone] = "Feature.Moments.Action.Done",
    [CreationFlowLocalization.GeneralCtaLeave] = "Feature.Moments.Action.Leave",
    [CreationFlowLocalization.GeneralCtaOk] = "Feature.Moments.Action.Ok",
    [CreationFlowLocalization.GeneralCtaShowMore] = "Feature.Moments.Action.ShowMore",
    [CreationFlowLocalization.GeneralEmptyStateText] = "Feature.Moments.Description.NothingHereYet",
    [CreationFlowLocalization.GeneralPhotosChipLabel] = "Feature.Moments.Label.Photos",
    [CreationFlowLocalization.GeneralSearchPlaceholder] = "Feature.Moments.Label.Search",
    [CreationFlowLocalization.GeneralVideosChipLabel] = "Feature.Moments.Label.Videos",
    [CreationFlowLocalization.LeaveMomentCreationBody] = "Feature.Moments.Description.LeaveMomentsCreation",
    [CreationFlowLocalization.LeaveMomentCreationTitle] = "Feature.Moments.Title.LeaveMomentCreation",
    [CreationFlowLocalization.MusicNoResults] = "Feature.Moments.Description.NoMusicResults",
    [CreationFlowLocalization.PostRemovedTitle] = "Feature.Moments.Title.MomentRemoved",
    [CreationFlowLocalization.PublishingCtaContinue] = "Feature.Moments.Action.Continue",
    [CreationFlowLocalization.PublishingCtaPrimary] = "Feature.Moments.Action.Post",
    [CreationFlowLocalization.PublishingCtaReturn] = if FFlagMomentsCreationBackCta then "Feature.Moments.Action.Back" else "Feature.Moments.Action.Return",
    [CreationFlowLocalization.PublishingCtaSecondary] = if FFlagMomentsCreationBackCta then "Feature.Moments.Action.Back" else "Feature.Moments.Action.ReturnToEditing",
    [CreationFlowLocalization.PublishingDescription] = "Feature.Moments.Description.PublishMoment",
    [CreationFlowLocalization.StayFriendlyModeration] = "Feature.Moments.Description.StayFriendly"
}

local function MomentsCreationFlowScreen()
    local var1 = useAnalytics()
    local var2 = useDispatch()

    local var3 = useLocalization(tbl1)

    local var4 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].MomentsCreationFlow.IsOpen
    end)

    local var5 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].MomentsCreationFlow.Capture
    end)

    local creationSessionId = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].MomentsCreationFlow.SessionId
    end)

    local exitCreationFlow = React.useCallback(function()
        var2(MomentsCreationFlowClosed())
    end, { var2 })

    local getLocalization = React.useCallback(function(arg1)
        return var3[arg1] or nil
    end, { var3 })

    local createMoment = React.useCallback(function(arg1, arg2, arg3)
        var2(CreateMoment(arg1, arg2, arg3))
    end, { var2 })

    if not (var4 and var5) then
        return nil
    end

    local value = {
        capturesPagesIsFinished = function(): boolean
            return true
        end,
        createMoment = createMoment,
        fetchAdditionalCaptures = Dash.noop,
        fetchInitialCaptures = Dash.noop,
        fireEvent = function(str1: string, arg1)
            var1.fireEvent("XExp" .. str1, Cryo.Dictionary.join(arg1 or {}, { creationSessionId = creationSessionId }))
        end,
        getLocalization = getLocalization,
        getUserConfiguration = Dash.noop,
        isTextFiltered = function(): boolean
            return false
        end,
        setScreenOrientation = Dash.noop
    }

    return React.createElement(
        CreationFlowContextProvider,
        {
            captures = { var5 },
            exitCreationFlow = exitCreationFlow,
            value = value
        },
        {
            Screen = React.createElement(CreationFlowScreen, { excludeGallery = true })
        }
    )
end

return MomentsCreationFlowScreen
