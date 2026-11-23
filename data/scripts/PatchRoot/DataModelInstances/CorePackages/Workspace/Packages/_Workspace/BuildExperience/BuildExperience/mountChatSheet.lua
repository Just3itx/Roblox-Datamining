-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local LocalizationService = game:GetService("LocalizationService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local SharedFlags = require(BuildExperienceParent.SharedFlags)
local FFlagBuildExperienceInGameShell = SharedFlags.FFlagBuildExperienceInGameShell
local var1 = SharedFlags.FFlagBuildExperienceInstanceSelection and FFlagBuildExperienceInGameShell
local isImageAttachmentSupported = if SharedFlags.FFlagBuildExperienceInGameCaptureToChat then require(BuildExperience.utils.isImageAttachmentSupported) else nil
local var2 = SharedFlags.FFlagBuildExperienceInGameCaptureToChat and isImageAttachmentSupported()
local Display = if FFlagBuildExperienceInGameShell then require(BuildExperienceParent.Display) else nil
local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)
local RoactUtils = require(BuildExperienceParent.RoactUtils)
local SignalsReact = if FFlagBuildExperienceInGameShell then require(BuildExperienceParent.SignalsReact) else nil
local BuildExperienceCompositionStyleSheet = require(BuildExperience.Components.BuildExperienceCompositionStyleSheet)
local _BuildPillMenuPortal = require(BuildExperience.Components.BuildPillMenu.BuildPillMenuPortal)
local BuildModeLaunch = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.BuildModeLaunch)
local ChatSheet = require(BuildExperience.Components.ChatSheet.ChatSheet)
local InGameBuildShell = if FFlagBuildExperienceInGameShell then require(BuildExperience.Components.ChatSheet.InGameBuildShell) else nil
local InstanceSelectionProtocol = if var1 then require(BuildExperience.Components.ChatSheet.InstanceSelectionProtocol) else nil
local LibraryTypes = if var1 then require(BuildExperience.Components.Library.LibraryTypes) else nil
local clientDataModelCollector = if var1 then require(BuildExperience.Chat.clientDataModelCollector) else nil
local useCaptureToChat = require(BuildExperience.Components.ChatSheet.useCaptureToChat)
local GetAssistantBuildStore = if FFlagBuildExperienceInGameShell then require(BuildExperience.Stores.GetAssistantBuildStore) else nil
local GetPlayButtonStore = require(BuildExperience.Stores.GetPlayButtonStore)
local LibraryThemeProvider = require(BuildExperience.Components.Library.LibraryThemeProvider)
local teamCreateUtils = require(BuildExperienceParent.BuildExperiencePlaytestLaunch.teamCreateUtils)
local trackBuildOpenSafetyService = require(BuildExperience.utils.trackBuildOpenSafetyService)
local FFlagReportBuildUIVisibility = require(BuildExperience.Flags.FFlagReportBuildUIVisibility)
local clientLogsCollector = require(BuildExperience.Chat.clientLogsCollector)
local LocalizationProvider = Localization.LocalizationProvider

local AppInteractionFeedbackProvider = require(BuildExperienceParent.RobloxAppInteractionFeedbackConfig).AppInteractionFeedbackProvider

local function createAppLocalization(robloxLocaleId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return require(BuildExperienceParent.InExperienceLocales).Localization.new(robloxLocaleId)
end

local num1 = game:DefineFastInt("FIntInGameBuildChatSheetSnapPoint", 50)

local tbl1 = { num1 / 100 }

local tbl2 = { num1 / 100, 1 }

local function beginInstanceSelection()
    InstanceSelectionProtocol.beginSelection(function(arg1)
        if arg1.status ~= "selected" or arg1.path == nil or arg1.className == nil then
            return
        end

        local path = clientDataModelCollector.resolveInstancePath(arg1.path, arg1.className)
        if path == nil then
            return
        end
        local playButtonStore = GetPlayButtonStore()
        playButtonStore.setPendingResourceAttachment(
            LibraryTypes.toResourceAttachment({ path = path, displayName = arg1.displayName or path, className = arg1.className })
        )
        playButtonStore.setIsActive(true)
    end)
end

local function ConnectedChatSheet(tbl3)
    local playButtonStore = GetPlayButtonStore()
    local isOpen = playButtonStore.useIsActive()

    local var4 = if var2 then useCaptureToChat(function()
        playButtonStore.setIsActive(true)
    end, tbl3.takeCapture) else nil

    local isLibraryMode = teamCreateUtils.isViewer()
    local tbl4 = {
        universeId = game.GameId,
        placeId = game.PlaceId,
        isNewGameTarget = false
    }

    local var6 = playButtonStore.useResumeTarget()
    local sessionId = if var6 then var6.sessionId else nil

    if isLibraryMode and var6 == nil then
        sessionId = BuildModeLaunch:getChatSessionId(game.PlaceId)
    end

    if FFlagReportBuildUIVisibility then
        trackBuildOpenSafetyService(isOpen)
    end

    local onClose = React.useCallback(function()
        playButtonStore.setIsActive(false)
    end, { playButtonStore })

    local createElement = React.createElement
    local var8 = if isLibraryMode then require(BuildExperience.Components.Library.LibraryChatSheet) else ChatSheet
    local tbl5 = {
        isOpen = isOpen,
        onClose = onClose,
        snapPoints = if isLibraryMode then tbl1 else tbl2,
        defaultSnapPointIndex = 1,
        topBarPillMenuTarget = 0,
        universeId = 0,
        placeId = 0,
        sessionId = 0,
        captureToAttach = 0,
        onCaptureAttached = 0
    }
    if not isOpen or isLibraryMode then
        tbl4 = nil
    end

    tbl5.topBarPillMenuTarget = tbl4
    tbl5.universeId = if var6 then var6.universeId else nil
    tbl5.placeId = if var6 then var6.placeId else nil
    tbl5.sessionId = sessionId
    tbl5.captureToAttach = if var4 == nil then nil else var4.captureToAttach
    tbl5.onCaptureAttached = if var4 == nil then nil else var4.onCaptureAttached
    local chatSheet = createElement(var8, tbl5)

    if not FFlagBuildExperienceInGameShell then
        return chatSheet
    end

    local assistantBuildStore = GetAssistantBuildStore()
    local displayStore = Display.GetDisplayStore(false)
    local isVisible = SignalsReact.useSignalState(assistantBuildStore.getIsOverlayVisible)
    local onInsetsChanged = React.useCallback(function(left: number, right: number, bottom: number)
        displayStore.setGuiInset(function(arg1)
            return {
                left = left,
                top = arg1.top,
                right = right,
                bottom = bottom
            }
        end)
    end, { displayStore })

    local createElement2 = React.createElement
    local fragment = React.Fragment
    local var11 = nil

    local tbl6 = {
        ChatSheet = chatSheet,
        Shell = React.createElement(InGameBuildShell, {
            isVisible = isVisible,
            isLibraryMode = isLibraryMode,
            onActivated = function()
                playButtonStore.setIsActive(true)
            end,
            onCaptureActivated = if var4 == nil then nil else var4.onCaptureActivated,
            onInsetsChanged = onInsetsChanged,
            onSelectionActivated = if var1 and not isLibraryMode then beginInstanceSelection else nil
        })
    }

    return createElement2(fragment, var11, tbl6)
end

local lazyComponent = RoactUtils.Components.createLazyComponent(function()
    return ConnectedChatSheet
end)

local function mountChatSheet(tbl3)
    clientLogsCollector.startServerLogCollection()

    local buildExperienceChatSheet = Instance.new("ScreenGui")
    buildExperienceChatSheet.Name = "BuildExperienceChatSheet"
    buildExperienceChatSheet.IgnoreGuiInset = true
    buildExperienceChatSheet.ResetOnSpawn = false
    if FFlagBuildExperienceInGameShell then
        buildExperienceChatSheet.ClipToDeviceSafeArea = false
        buildExperienceChatSheet.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
        buildExperienceChatSheet.ScreenInsets = Enum.ScreenInsets.None
    end
    buildExperienceChatSheet.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    buildExperienceChatSheet.Parent = CoreGui
    buildExperienceChatSheet.DisplayOrder = 9

    local root = ReactRoblox.createRoot(buildExperienceChatSheet)
    local localization = createAppLocalization(LocalizationService.RobloxLocaleId)
    local tbl4 = {
        CompositionStyleSheet = React.createElement(BuildExperienceCompositionStyleSheet),
        Sheet = React.createElement(lazyComponent, tbl3)
    }
    local foundationProvider = if teamCreateUtils.isViewer() then React.createElement(LibraryThemeProvider, { displayOrder = 9 }, tbl4) else React.createElement(
        Foundation.FoundationProvider,
        {
            colorMode = Foundation.Enums.ColorMode.Dark,
            overlayGui = { DisplayOrder = 9 }
        },
        tbl4
    )
    local chatSheet = React.createElement(AppInteractionFeedbackProvider, nil, { FoundationProvider = foundationProvider })

    root:render(React.createElement(LocalizationProvider, { localization = localization }, { ChatSheet = chatSheet }))

    return root
end

return mountChatSheet
