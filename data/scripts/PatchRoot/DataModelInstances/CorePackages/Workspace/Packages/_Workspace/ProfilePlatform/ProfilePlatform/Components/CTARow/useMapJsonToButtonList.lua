-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local _Types = require(ProfilePlatform.Components.CTARow.Types)

local Foundation = require(ProfilePlatformParent.Foundation)
local IconName = Foundation.Enums.IconName
local ButtonVariant = Foundation.Enums.ButtonVariant

local React = require(ProfilePlatformParent.React)
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useEffectOnce = RoactUtils.Hooks.useEffectOnce
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local NavigateDown = require(ProfilePlatformParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(ProfilePlatformParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(ProfilePlatformParent.RobloxAppNavigation).NavigationCommands else nil
local NetworkingPresence = require(ProfilePlatform.Networking.NetworkingPresence)
local NetworkStatus = require(ProfilePlatform.Networking.myRoduxNetworking).Enum.NetworkStatus

local useProfileActions = require(ProfilePlatform.Hooks.useProfileActions)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local Enums = require(ProfilePlatform.Common.Enums)

local FFlagEnableProfilePlatformDisabledActions = require(ProfilePlatformParent.SharedFlags).FFlagEnableProfilePlatformDisabledActions
local FFlagEnableCommunityVerificationModal = require(ProfilePlatform.Flags.FFlagEnableCommunityVerificationModal)

local FFlagPortEnableCommunityVerificationModal = require(ProfilePlatform.Flags.FFlagPortEnableCommunityVerificationModal)

local FFlagEnableProfilePlatformDisabledReasonText = require(ProfilePlatform.Flags.FFlagEnableProfilePlatformDisabledReasonText)
local FFlagProfilePlatformAddCurrentlyPlaying = require(ProfilePlatform.Flags.FFlagProfilePlatformAddCurrentlyPlaying)

local FFlagProfilePlatformPresenceStoreMigration = require(ProfilePlatform.Flags.FFlagProfilePlatformPresenceStoreMigration)
local FFlagJoinabilityCTARefactor = require(ProfilePlatformParent.SharedFlags).FFlagJoinabilityCTARefactor
local var1 = if FFlagProfilePlatformPresenceStoreMigration then require(ProfilePlatformParent.DataHydration).Presence.PresenceStore.get() else nil
local useProfileAnalyticsContext = require(ProfilePlatform.Contexts.useProfileAnalyticsContext)
local EventNames = require(ProfilePlatform.Analytics.EventNames)

local function profileMenuItemFromResolvedAction(id, arg2, profileType)
    local onActivated = arg2.onActivated[profileType]
    if not onActivated then
        warn("profileMenuItemFromResolvedAction: action not available for profile type", id, profileType)
        return nil
    end
    return {
        id = id,
        displayValue = {
            icon = arg2.icon,
            text = arg2.text
        },
        onActivated = onActivated,
        isDisabled = arg2.isDisabled
    }
end

local function contextualMenuItemsFromJsonActions(tbl1, tbl2, profileType)
    local result = {}
    for _, value in ipairs(tbl1 or {}) do
        local tbl3 = {
            items = {}
        }
        local var2 = type(value) ~= "table" and { value } or value

        for _, value2 in ipairs(var2) do
            local var3 = tbl2[value2]
            if not var3 then
                continue
            end
            local var4 = profileMenuItemFromResolvedAction(value2, var3, profileType)
            if var4 then
                table.insert(tbl3.items, var4)
            end
        end

        if #tbl3.items > 0 then
            table.insert(result, tbl3)
        end
    end
    return result
end

local function hasJoinExperience(buttons)
    for _, button in buttons do
        if button.type == Enums.ProfileActions.JoinExperience then
            return true
        end
        if FFlagJoinabilityCTARefactor and button.type == Enums.ProfileActions.PlayExperience then
            return true
        end
    end
    return false
end

local function useMapJsonToButtonList(str1: string)
    local var2 = useDispatch()
    local var3 = useProfileJsonComponent(Enums.Components.Actions) or {}

    local var4 = useProfileActions(Enums.ButtonSurface.Actions)
    local profileType = useProfileWrapperContext().profileType
    local var5 = useProfileAnalyticsContext()

    local var6 = if FFlagProfilePlatformPresenceStoreMigration then nil else useSelector(function(arg1): boolean
        return NetworkingPresence.GetPresencesFromUserIds.getStatus(arg1, str1) == NetworkStatus.NotStarted
    end)

    if FFlagProfilePlatformAddCurrentlyPlaying then
        React.useEffect(function()
            if not var3.buttons or not hasJoinExperience(var3.buttons) then
                return
            end

            if FFlagProfilePlatformPresenceStoreMigration then
                var1.RefreshPresenceByUserId(str1)
                return
            end
            var2(NetworkingPresence.GetPresencesFromUserIds.API({ str1 }))
        end, { var3.buttons, var2, str1 })
    else
        useEffectOnce(function()
            if FFlagProfilePlatformPresenceStoreMigration then
                var1.RefreshPresenceByUserId(str1)
                return
            end
            var2(NetworkingPresence.GetPresencesFromUserIds.API({ str1 }))
        end, not (var3.buttons == nil)
            and hasJoinExperience(var3.buttons)
            and (if FFlagProfilePlatformPresenceStoreMigration then true else var6))
    end

    return (React.useMemo(function()
        local result = {}

        for _, value in ipairs(var3.buttons or {}) do
            local var7 = var4[value.type]
            if not var7 then
                warn("useMapJsonToButtonList: unrecognized action type", value.type)
            else
                local var8 = table.clone(var7)
                local contextualMenuItems = contextualMenuItemsFromJsonActions(value.subActions, var4, profileType)

                if FFlagEnableProfilePlatformDisabledActions and value.disabledReason then
                    if FFlagEnableCommunityVerificationModal
                        and value.type == Enums.ProfileActions.JoinCommunity
                        and (value.disabledReason == Enums.DisabledReasons.InsufficientVerificationLevelLow
                            or value.disabledReason == Enums.DisabledReasons.InsufficientVerificationLevelMedium
                            or value.disabledReason == Enums.DisabledReasons.InsufficientVerificationLevelHigh)
                    then
                        var8.icon = if FFlagEnableCommunityVerificationModal and FFlagPortEnableCommunityVerificationModal then IconName.LockClosed else nil

                        var8.onActivated = {
                            [profileType] = function()
                                local tbl2 = {
                                    name = Enums.Screens.CommunityVerificationModal,
                                    extraProps = {
                                        disabledReason = value.disabledReason
                                    }
                                }
                                if FFlagSignalsNavP3Dispatch then
                                    return NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
                                end
                                return var2(NavigateDown(tbl2))
                            end
                        }
                    else
                        var8.isDisabled = true
                        var8.disabledReason = if FFlagEnableProfilePlatformDisabledReasonText then value.disabledReason else nil
                    end
                end

                local buttonStyle = if #result == 0 and not var8.isDisabled then var8.variant or ButtonVariant.Emphasis else ButtonVariant.Standard
                local menuItem = profileMenuItemFromResolvedAction(value.type, var8, profileType)
                if menuItem then
                    table.insert(result, {
                        contextualMenuItems = contextualMenuItems,
                        menuItem = menuItem,
                        buttonStyle = buttonStyle,
                        isLoading = var8.isLoading,
                        disabledReason = var8.disabledReason
                    })
                end
            end
        end

        local contextualMenuItems = contextualMenuItemsFromJsonActions(var3.contextual, var4, profileType)
        if #contextualMenuItems > 0 then
            table.insert(result, {
                menuItem = {
                    id = Enums.ProfileActions.ContextualOverflow,
                    displayValue = {
                        icon = IconName.ThreeDotsHorizontal
                    },
                    onActivated = function()
                        var5.fireAnalyticsEvent(EventNames.ContextualMenuButton)
                    end
                },
                contextualMenuItems = contextualMenuItems,
                buttonStyle = ButtonVariant.Standard
            })
        end

        return result
    end, {
        var3.buttons,
        var3.contextual,
        var4,
        var2,
        profileType,
        var5
    }))
end
return useMapJsonToButtonList
