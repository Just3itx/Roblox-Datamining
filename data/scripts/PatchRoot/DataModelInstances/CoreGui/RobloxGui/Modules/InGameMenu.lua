-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:10:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local LocalizationService = game:GetService("LocalizationService")
local GuiService = game:GetService("GuiService")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local UIBlox = InGameMenuDependencies.UIBlox

local FeedbackManagerInjectionContextProvider = require(CorePackages.Workspace.Packages.InteractionFeedback).FeedbackManagerInjectionContextProvider

local AppInteractionFeedbackProvider = require(CorePackages.Workspace.Packages.RobloxAppInteractionFeedbackConfig).AppInteractionFeedbackProvider

local Localization = require(CorePackages.Workspace.Packages.InExperienceLocales).Localization
local LocalizationProvider = require(CorePackages.Workspace.Packages.Localization).LocalizationProvider

local SelectionCursorProvider = UIBlox.App.SelectionImage.SelectionCursorProvider

local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local bindMenuActions = require(script.SetupFunctions.bindMenuActions)
local registerSetCores = require(script.SetupFunctions.registerSetCores)
local requestGameNameAndDescription = require(script.SetupFunctions.requestGameNameAndDescription)
local createStore = require(script.createStore)

local App = require(script.Components.App)
local FocusHandlerContextProvider = require(script.Components.Connection.FocusHandlerUtils.FocusHandlerContextProvider)
local initVoiceChatStore = require(RobloxGui.Modules.VoiceChat.initVoiceChatStore)
local TrustAndSafety = require(RobloxGui.Modules.TrustAndSafety)

local SetLocaleId = require(script.Actions.SetLocaleId)
local SetInspectMenuEnabled = require(script.Actions.SetInspectMenuEnabled)
local SetCurrentPage = require(script.Actions.SetCurrentPage)
local SetScreenSize = require(script.Actions.SetScreenSize)
local SetMenuIconTooltipOpen = require(script.Actions.SetMenuIconTooltipOpen)
local SetRespawning = require(script.Actions.SetRespawning)
local OpenMenu = require(script.Thunks.OpenMenu)
local CloseMenu = require(script.Thunks.CloseMenu)
local InGameMenuPolicy = require(script.InGameMenuPolicy)

local GlobalConfig = require(script.GlobalConfig)
local Constants = require(script.Resources.Constants)

local GetFFlagIGMGamepadSelectionHistory = require(script.Flags.GetFFlagIGMGamepadSelectionHistory)

local bindableEvent = Instance.new("BindableEvent")
local bindableEvent2 = Instance.new("BindableEvent")

local store = createStore()

return {
    mountInGameMenu = function()
        registerSetCores(store)
        bindMenuActions(store)
        requestGameNameAndDescription(store)

        if GlobalConfig.propValidation then
            Roact.setGlobalConfig({ propValidation = true })
        end

        if GlobalConfig.elementTracing then
            Roact.setGlobalConfig({ elementTracing = true })
        end

        store.changed:connect(function(arg1, arg2)
            if arg1.isMenuOpen ~= arg2.isMenuOpen then
                bindableEvent:Fire(arg1.isMenuOpen)
            end

            local enabled = arg1.respawn.enabled
            local enabled2 = arg2.respawn.enabled

            local customCallback = arg1.respawn.customCallback
            local customCallback2 = arg2.respawn.customCallback

            if enabled ~= enabled2 and customCallback ~= customCallback2 then
                bindableEvent2:Fire(enabled, customCallback)
            end
        end)

        local localization = Localization.new(LocalizationService.RobloxLocaleId)
        store:dispatch(SetLocaleId(LocalizationService.RobloxLocaleId))
        LocalizationService:GetPropertyChangedSignal("RobloxLocaleId"):Connect(function()
            localization:SetLocale(LocalizationService.RobloxLocaleId)
            store:dispatch(SetLocaleId(LocalizationService.RobloxLocaleId))
        end)

        store:dispatch(SetInspectMenuEnabled(GuiService:GetInspectMenuEnabled()))
        GuiService.InspectMenuEnabledChangedSignal:Connect(function(enabled: boolean)
            store:dispatch(SetInspectMenuEnabled(enabled))
        end)

        initVoiceChatStore(store)
        local var1 = renderWithCoreScriptsStyleProvider
        local tbl1 = { LocalizationProvider = 0 }
        local createElement = Roact.createElement
        local var2 = LocalizationProvider
        local tbl2 = { localization = localization }
        local tbl3 = {
            CursorProvider = Roact.createElement(SelectionCursorProvider, {}, {
                FocusHandlerContextProvider = GetFFlagIGMGamepadSelectionHistory()
                    and Roact.createElement(FocusHandlerContextProvider, {}, { InGameMenu = Roact.createElement(App) })
                    or nil,
                InGameMenu = if GetFFlagIGMGamepadSelectionHistory() then nil else Roact.createElement(App) or nil
            })
        }
        tbl1.LocalizationProvider = createElement(var2, tbl2, tbl3)
        local tree = var1(tbl1)

        local themeProvider = Roact.createElement(
            AppInteractionFeedbackProvider,
            {},
            {
                tree = Roact.createElement(FeedbackManagerInjectionContextProvider, nil, { tree = tree })
            }
        )

        local createElement2 = Roact.createElement
        local tbl4 = {
            ResetOnSpawn = false,
            IgnoreGuiInset = true,
            DisplayOrder = Constants.DisplayOrder.RootMenu,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            AutoLocalize = false
        }

        tbl4[Roact.Change.AbsoluteSize] = function(arg1)
            store:dispatch(SetScreenSize(arg1.AbsoluteSize))
        end

        local element2 = createElement2("ScreenGui", tbl4, {
            StoreProvider = Roact.createElement(RoactRodux.StoreProvider, { store = store }, {
                PolicyProvider = Roact.createElement(
                    InGameMenuPolicy.Provider,
                    {
                        policy = { InGameMenuPolicy.Mapper }
                    },
                    { ThemeProvider = themeProvider }
                )
            })
        })
        Roact.mount(element2, CoreGui, "InGameMenu")
    end,
    openInGameMenu = function(arg1)
        store:dispatch(OpenMenu(Constants.AnalyticsMenuOpenTypes.TopbarButton, arg1))
    end,
    closeInGameMenu = function()
        CloseMenu(store)
    end,
    openReportDialog = function(arg1, arg2)
        store:dispatch(OpenMenu(Constants.AnalyticsMenuOpenTypes.ReportAbuseTriggered, Constants.ReportDialogKey))
        if arg2 == nil then
            arg2 = Constants.AnalyticsInGameMenuName
        end

        TrustAndSafety.openReportDialogForPlayer(arg1, arg2)
    end,
    openGameSettingsPage = function()
        store:dispatch(OpenMenu(Constants.AnalyticsMenuOpenTypes.SettingsTriggered))
        store:dispatch(SetCurrentPage("GameSettings"))
    end,
    openGameLeavePage = function()
        store:dispatch(OpenMenu(Constants.AnalyticsMenuOpenTypes.GamepadLeaveGame))
        store:dispatch(SetCurrentPage(Constants.LeaveGamePromptPageKey))
    end,
    openCharacterResetPage = function()
        store:dispatch(OpenMenu(Constants.AnalyticsMenuOpenTypes.GamepadResetCharacter))
        store:dispatch(SetCurrentPage(Constants.MainPagePageKey))
        store:dispatch(SetRespawning(true))
    end,
    openPlayersPage = function()
        store:dispatch(OpenMenu(Constants.AnalyticsMenuOpenTypes.PlayersTriggered))
        store:dispatch(SetCurrentPage("Players"))
    end,
    getOpenChangedEvent = function()
        return bindableEvent
    end,
    getOpen = function()
        return store:getState().isMenuOpen
    end,
    getRespawnBehaviour = function()
        local state = store:getState()
        return state.respawn.enabled, state.respawn.customCallback
    end,
    getRespawnBehaviourChangedEvent = function()
        return bindableEvent2
    end,
    setMenuIconTooltipOpen = function(arg1)
        store:dispatch(SetMenuIconTooltipOpen(arg1))
    end
}
