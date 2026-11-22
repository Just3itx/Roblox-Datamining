-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local Logger = require(Squads.Logger)
local dependencies = require(Squads.dependencies)
local React = dependencies.React
local Foundation = dependencies.Foundation
local useLocalization = dependencies.Hooks.useLocalization
local useSelector = dependencies.Hooks.useSelector
local useDispatch = dependencies.Hooks.useDispatch
local useCurrentSquadId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadId
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local Image = Foundation.Image
local Enums = require(SquadsParent.SquadsCore.Enums)

local getRbxthumbWithTypeSizeAndOptions = require(SquadsParent.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = require(SquadsParent.UserLib).Utils.Constants

local CreateExperienceInvite = require(Squads.Thunks.CreateExperienceInvite)
local useIsExperienceInviteRetryBlocked = require(SquadsParent.SquadsCore.Hooks).useIsExperienceInviteRetryBlocked

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local EventNames = require(SquadsParent.SquadsCore.EventNames)
local SquadToastActionsAndStates = Enums.SquadToastActionsAndStates
local SquadExperienceInviteSource = Enums.SquadExperienceInviteSource
local SquadRegroupEntryPoint = Enums.SquadRegroupEntryPoint

local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local bool1 = game:DefineFastFlag("RegroupTextTruncationFix", false)
local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)
local FFlagSquadsPresenceStoreMigration = require(SquadsParent.SquadsCore.Flags).FFlagSquadsPresenceStoreMigration
local FFlagUseSignalsForSquadExperienceInvite = dependencies.SharedFlags.FFlagUseSignalsForSquadExperienceInvite
local GetSquadExperienceInviteStore = require(SquadsParent.SquadsCore.Stores).GetSquadExperienceInviteStore
local useSignalState = require(SquadsParent.SignalsReact).useSignalState
local useGetPresenceByUserId = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil

local function SquadLobbyRegroupRow(tbl1)
    local var1 = useDispatch()
    local var2 = React.useContext(SquadExternalContractContext)
    local var3 = useLocalization({
        Title = "Notifications.SquadRegroupPrompt.ToastLabel.ContinuePlayingTogether",
        Body = "Notifications.SquadRegroupPrompt.ToastLabel.JoinANewServer",
        Join = "Notifications.SquadRegroupPrompt.ToastAction.Join"
    })

    local var4 = React.useCallback(function(arg1)
        return arg1.Squad and arg1.Squad.Squad and arg1.Squad.Squad.currentExperienceInvite
    end, {})

    local isDisabled = if FFlagUseSignalsForSquadExperienceInvite then useSignalState(GetSquadExperienceInviteStore(false).getHasCurrentExperienceInvite) else useSelector(var4) ~= nil
    local squadId = useCurrentSquadId()
    local var6 = useIsExperienceInviteRetryBlocked(squadId)

    local var7 = React.useCallback(function(arg1)
        return arg1
            and arg1.Squad
            and arg1.Squad.Presence
            and arg1.Squad.Presence.byUserId
            and arg1.Squad.Presence.byUserId[tostring(tbl1.localUserId)]
    end, { tbl1.localUserId })

    local var8 = if FFlagSquadsPresenceStoreMigration then useGetPresenceByUserId(tostring(tbl1.localUserId)) else useSelector(var7)
    local rootPlaceId = if FFlagSquadsPresenceStoreMigration then if var8 and var8.rootPlaceId ~= "" then var8.rootPlaceId else nil elseif var8 then var8.rootPlaceId or nil else nil
    local var9 = if FFlagSquadsPresenceStoreMigration then if var8 and var8.universeId ~= "" then var8.universeId elseif var8 and var8.gameId ~= "" then var8.gameId else nil elseif var8 then var8.universeId or var8.gameId or nil else nil
    local image = if var9 == nil then nil else getRbxthumbWithTypeSizeAndOptions(tostring(var9), Constants.RbxthumbTypes.GameIcon, 150, false)

    return React.createElement(Foundation.View, {
        tag = "align-y-center row auto-none size-full radius-medium gap-medium gui-object-defaults padding-x-xlarge padding-y-medium",
        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-regroup-row" else nil
    }, {
        Thumbnail = if image then React.createElement(Image, {
            tag = "radius-small bg-surface-100 size-1000",
            LayoutOrder = 1,
            Image = image,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-regroup-row--thumbnail" else nil
        }) else nil,
        TextContainer = React.createElement(
            Foundation.View,
            { tag = "auto-y fill col gap-xsmall align-x-left gui-object-defaults", LayoutOrder = 2 },
            {
                Title = React.createElement(Foundation.Text, {
                    tag = {
                        ["auto-y text-align-x-left text-no-wrap text-title-medium content-emphasis"] = true,
                        ["size-full-0 text-truncate-end"] = bool1
                    },
                    LayoutOrder = 1,
                    Text = var3.Title,
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-regroup-row--title" else nil
                }),
                Body = React.createElement(Foundation.Text, {
                    tag = {
                        ["auto-y content-default text-body-medium text-align-x-left text-no-wrap gui-object-defaults"] = true,
                        ["size-full-0 text-truncate-end"] = bool1
                    },
                    LayoutOrder = 2,
                    Text = var3.Body,
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-regroup-row--body" else nil
                })
            }
        ),
        JoinButton = React.createElement(Foundation.Button, {
            LayoutOrder = 3,
            text = var3.Join,
            size = ButtonSize.Medium,
            variant = ButtonVariant.Standard,
            isDisabled = isDisabled or var6,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-regroup-row--join-button" else nil,
            onActivated = React.useCallback(function()
                if rootPlaceId == nil then
                    Logger:warning("SquadRegroupEventReceiver: Join clicked but rootPlaceId is missing from local presence")
                    return
                end

                var1(CreateExperienceInvite(tostring(rootPlaceId), var2, SquadExperienceInviteSource.Regroup)):andThen(function(experienceInviteId)
                    var2.fireSquadAnalytics(EventNames.SquadRegroupButtonClicked, {
                        clientTimestamp = os.time(),
                        squadId = squadId,
                        initiatorId = tbl1.localUserId,
                        gameInstanceId = if FFlagSquadsPresenceStoreMigration then var8 and var8.gameId else var8.gameId,
                        rootPlaceId = if FFlagSquadsPresenceStoreMigration then var8 and var8.rootPlaceId else var8.rootPlaceId,
                        placeId = if FFlagSquadsPresenceStoreMigration then var8 and var8.placeId else var8.placeId,
                        universeId = if FFlagSquadsPresenceStoreMigration then var8 and var8.universeId else var8.universeId,
                        playSessionId = RbxAnalyticsService:GetPlaySessionId(),
                        experienceInviteId = experienceInviteId,
                        button = SquadToastActionsAndStates.RegroupJoin,
                        entryPoint = SquadRegroupEntryPoint.SquadLobbyButton
                    })
                end)
            end, {
                var1,
                CreateExperienceInvite,
                rootPlaceId,
                var2,
                squadId,
                tbl1.localUserId,
                var8
            })
        })
    })
end

return SquadLobbyRegroupRow
