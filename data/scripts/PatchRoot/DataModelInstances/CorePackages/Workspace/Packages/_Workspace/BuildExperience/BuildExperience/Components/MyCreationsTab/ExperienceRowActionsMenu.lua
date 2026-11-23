-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local ArchiveGameDialog = require(BuildExperience.Components.GameConfigurations.ArchiveGameDialog)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local ExperienceShareOverlays = require(BuildExperience.Components.ShareAudience.ExperienceShareOverlays)
local _createBuildOverflowMenuStore = require(BuildExperience.Stores.GetBuildOverflowMenuStore.createBuildOverflowMenuStore)
local useArchiveGameFlow = require(BuildExperience.utils.useArchiveGameFlow)
local useClosableFocusRoot = require(BuildExperience.utils.useClosableFocusRoot)
local useExperienceShareFlow = require(BuildExperience.utils.useExperienceShareFlow)
local useGamePermissions = require(BuildExperience.useGamePermissions)
local FFlagBuildExperiencePrivateInvites = require(BuildExperience.Flags.FFlagBuildExperiencePrivateInvites)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperienceHomeTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceHomeTelemetry)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local Menu = Foundation.Menu
local useScaledValue = Foundation.Hooks.useScaledValue
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local PrivacyType = UniverseConfiguration.PrivacyType

local function getTelemetryGranularity(target) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        universeId = target.universeId,
        placeId = target.placeId,
        conversationId = target.sessionId
    }
end

local function ExperienceRowActionsMenu(tbl1)
    local var1 = useLocalization({
        archiveGame = LocalizationStrings.GAME_CONFIGURATION_ARCHIVE_GAME,
        publish = LocalizationStrings.BUILD_MENU_PUBLISH,
        settings = LocalizationStrings.BUILD_MENU_SETTINGS,
        share = LocalizationStrings.BUILD_MENU_SHARE
    })
    local archiveGame = var1.archiveGame
    local publish = var1.publish
    local settings = var1.settings
    local share = var1.share
    local offset = useScaledValue(216)
    local target = tbl1.target
    local var2 = useExperienceShareFlow(if target == nil then nil else target.universeId, if target == nil then nil else target.placeId)

    local var3 = useArchiveGameFlow({ context = "games_list" })
    local canPublish = true
    local canEdit = true
    if FFlagBuildCheckGamePermissions then
        local var4 = useGamePermissions({ universeId = if target == nil then nil else target.universeId })

        canPublish = var4.canPublish
        canEdit = var4.canEdit
    end

    local isDisabled = var2.audience == nil or var2.audience == PrivacyType.Private and not FFlagBuildExperiencePrivateInvites

    local anchorRef = React.useMemo(function()
        return {
            current = tbl1.anchor
        }
    end, { tbl1.anchor })

    local items = React.useMemo(function()
        return {
            {
                id = "publish",
                text = publish,
                isDisabled = not canPublish
            },
            { id = "share", text = share, isDisabled = isDisabled },
            {
                id = "settings",
                text = settings,
                isDisabled = not canEdit
            },
            {
                id = "archive-game",
                text = archiveGame,
                isDisabled = not canEdit
            }
        }
    end, {
        archiveGame,
        canEdit,
        canPublish,
        isDisabled,
        publish,
        settings,
        share
    })
    local onClose = tbl1.onClose
    local onOpenConfigurationPage = tbl1.onOpenConfigurationPage
    local onShare = var2.onShare
    local requestArchive = var3.requestArchive
    local onActivated = React.useCallback(function(arg1)
        onClose()
        if target == nil then
            return
        end
        if FFlagBuildExperienceHomeTelemetry then
            sendBuildExperienceEvent("MY_CREATIONS_MENU_ITEM_CLICK", getTelemetryGranularity(target), { item = tostring(arg1) })
        end

        if arg1 == "publish" then
            onOpenConfigurationPage("publish", target)
        elseif arg1 == "share" then
            onShare()
        elseif arg1 == "settings" then
            onOpenConfigurationPage("settings", target)
        elseif arg1 == "archive-game" and target.universeId ~= nil then
            requestArchive(target.universeId)
        end
    end, {
        onClose,
        onOpenConfigurationPage,
        onShare,
        requestArchive,
        target
    })
    local isOpen = tbl1.isOpen

    if isOpen then
        if target == nil then
            isOpen = false
        else
            isOpen = tbl1.anchor ~= nil
        end
    end

    if FFlagBuildExperienceHomeTelemetry then
        React.useEffect(function()
            if isOpen and target ~= nil then
                sendBuildExperienceEvent("MY_CREATIONS_MENU_OPEN", (getTelemetryGranularity(target)))
            end
        end, { isOpen, target })
    end

    local ref = useClosableFocusRoot(
        {
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
            isOpen = isOpen,
            onClose = onClose
        }
    )
    local createElement = React.createElement
    local fragment = React.Fragment
    local var8 = nil
    local tbl2 = {
        Menu = React.createElement(Menu, {
            ref = ref,
            isOpen = isOpen,
            items = items,
            anchorRef = anchorRef,
            side = PopoverSide.Bottom,
            align = if tbl1.isAtPointer then PopoverAlign.Start else PopoverAlign.End,
            size = InputSize.Large,
            width = UDim.new(0, offset),
            onActivated = onActivated,
            onPressedOutside = onClose,
            testId = "ExperienceRowActionsMenu"
        }),
        ShareOverlays = React.createElement(ExperienceShareOverlays, {
            activeDialog = var2.activeDialog,
            hasShareError = var2.hasShareError,
            onCancel = var2.onCancelDialog,
            onConfirmFriends = var2.onConfirmFriends,
            onConfirmPlaytesters = var2.onConfirmPlaytesters
        }),
        ArchiveDialog = React.createElement(ArchiveGameDialog, { isOpen = var3.isOpen, onArchive = var3.confirm, onCancel = var3.cancel })
    }
    return createElement(fragment, var8, tbl2)
end

return ExperienceRowActionsMenu
