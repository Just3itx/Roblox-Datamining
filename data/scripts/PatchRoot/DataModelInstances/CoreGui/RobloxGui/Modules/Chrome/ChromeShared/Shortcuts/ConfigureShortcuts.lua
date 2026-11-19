-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local CorePackages = game:GetService("CorePackages")
local GamepadService = game:GetService("GamepadService")
local GameSettings = UserSettings().GameSettings

local Chrome = script:FindFirstAncestor("Chrome")
local ChromeShared = script:FindFirstAncestor("ChromeShared")
local FocusSelectExpChat = require(ChromeShared.Utility.FocusSelectExpChat)
local Service = require(ChromeShared.Service)
local GuiService = game:GetService("GuiService")
local Constants = require(ChromeShared.Unibar.Constants)
local RespawnUtils = require(Chrome.Integrations.RespawnUtils)
local FocusUtils = require(CorePackages.Workspace.Packages.Chrome).FocusUtils

local var1 = require(CorePackages.Workspace.Packages.ExpChat).Stores.GetFocusNavigationStore(false)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local FFlagEnableConsoleExpControls = SharedFlags.FFlagEnableConsoleExpControls
local FFlagChromeShortcutAddRespawnLeaveToIEM = SharedFlags.FFlagChromeShortcutAddRespawnLeaveToIEM
local FFlagChromeShortcutRemoveLeaveOnRespawnPage = SharedFlags.FFlagChromeShortcutRemoveLeaveOnRespawnPage
local FFlagChromeShortcutRemoveRespawnOnLeavePage = SharedFlags.FFlagChromeShortcutRemoveRespawnOnLeavePage
local FFlagConsoleChatUseChromeFocusUtils = SharedFlags.FFlagConsoleChatUseChromeFocusUtils
local FFlagChromeShortcutChatOpenKeyboard = SharedFlags.FFlagChromeShortcutChatOpenKeyboard
local FFlagAddSwitchTabHintsToIEM = SharedFlags.FFlagAddSwitchTabHintsToIEM
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagSideSheetFocusNav = SharedFlags.FFlagSideSheetFocusNav

local Flags = Chrome.Flags
local FFlagRespawnChromeShortcutTelemetry = require(Flags.FFlagRespawnChromeShortcutTelemetry)
local FFlagLeaveActionChromeShortcutTelemetry = require(Flags.FFlagLeaveActionChromeShortcutTelemetry)
local FFlagLeaveChromeShortcutTelemetry = require(Flags.FFlagLeaveChromeShortcutTelemetry)
local FFlagRespawnActionChromeShortcutTelemetry = require(Flags.FFlagRespawnActionChromeShortcutTelemetry)
local Flags2 = require(ChromeShared.Flags)
local FFlagRemoveLeaveShortcutFromLeaveConfirm = Flags2.FFlagRemoveLeaveShortcutFromLeaveConfirm

local FFlagRemoveRespawnShortcutFromRespawnConfirmation = Flags2.FFlagRemoveRespawnShortcutFromRespawnConfirmation
local ChatSelector = if FFlagEnableConsoleExpControls then require(RobloxGui.Modules.ChatSelector) else nil
local leaveGame = require(RobloxGui.Modules.Settings.leaveGame)
local PioneerUtils = require(CorePackages.Workspace.Packages.PioneerUtils)
local FFlagPioneerLeaveLogsOut = SharedFlags.FFlagPioneerLeaveLogsOut

local InExperienceSideSheet = require(CorePackages.Workspace.Packages.InExperienceSideSheet)
local getSideSheetVisibility = InExperienceSideSheet.getSideSheetVisibility
local toggleSideSheet = InExperienceSideSheet.toggleSideSheet

local FFlagShowUnibarOnVirtualCursor = SharedFlags.FFlagShowUnibarOnVirtualCursor

local tbl1 = {
    keyCode = Enum.KeyCode.ButtonX,
    activated = function()
        local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
        local leaveGamePage = settingsHub.Instance.LeaveGamePage
        local function switchToLeavePage() -- Luacid: Inlined by compiler; 2 call sites recovered
            settingsHub.Instance:SwitchToPage(leaveGamePage, true, nil, nil, nil, { used_shortcut = true })
        end

        if not settingsHub:GetVisibility() then
            if FFlagConsoleChatUseChromeFocusUtils and var1.getChatInputBarFocused(false) then
                var1.unfocusChatInputBar()
            end

            if FFlagRespawnChromeShortcutTelemetry then
                settingsHub:SetVisibility(true)
                switchToLeavePage()
                return
            end

            settingsHub:SetVisibility(true, false, leaveGamePage)

            return
        end

        if settingsHub.Instance.Pages.CurrentPage ~= leaveGamePage then
            if FFlagLeaveChromeShortcutTelemetry then
                switchToLeavePage()
            else
                settingsHub:SwitchToPage(leaveGamePage, true)
            end

            return
        end

        if FFlagPioneerLeaveLogsOut and PioneerUtils.isPioneerLaunch() then
            leaveGame(false, {
                leaveReason = PioneerUtils.PioneerLeaveReason.Logout,
                inhibitAppRating = true,
                telemetryFields = FFlagLeaveActionChromeShortcutTelemetry and {
                    used_shortcut = true
                } or nil
            })
        elseif FFlagLeaveActionChromeShortcutTelemetry then
            leaveGame(true, { telemetryFields = { used_shortcut = true } })
        else
            leaveGame(true)
        end
    end
}
local tbl2 = {
    keyCode = Enum.KeyCode.ButtonY,
    integration = "respawn",
    activated = function()
        local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)

        if settingsHub:GetVisibility() and settingsHub.Instance.Pages.CurrentPage == settingsHub.Instance.ResetCharacterPage then
            if FFlagRespawnActionChromeShortcutTelemetry then
                settingsHub.Instance.ResetCharacterPage.ResetFunction({ resetTelemetryFields = { used_shortcut = true } })
                return
            end

            settingsHub.Instance.ResetCharacterPage.ResetFunction()
            return
        end

        if FFlagConsoleChatUseChromeFocusUtils and var1.getChatInputBarFocused(false) then
            var1.unfocusChatInputBar()
        end

        if FFlagRespawnChromeShortcutTelemetry then
            RespawnUtils.respawnPage({ usedShortcut = true })
            return
        end

        Service:activate("respawn")
    end
}

local function activateBack()
    local var2 = FFlagEnableConsoleExpControls and FocusUtils.MenuIconSelectedSignal:get()
    local var3 = not FFlagConsoleChatUseChromeFocusUtils or Service:inFocusNav():get()
    local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
    if settingsHub:GetVisibility() then
        settingsHub.Instance:PopMenu(false, true)
        if not settingsHub:GetVisibility() then
            Service:selectMenuIcon()
        end
        return Enum.ContextActionResult.Sink
    end

    if not (var3 or var2) then
        if FFlagConsoleChatUseChromeFocusUtils and var1.getChatInputBarFocused(false) then
            FocusUtils.FocusOnChrome(function()
                var1.unfocusChatInputBar()
            end, "chat")
            return Enum.ContextActionResult.Sink
        end

        return
    end

    local var4 = Service:currentSubMenu():get()
    if var4 then
        Service:toggleSubMenu(var4)
        Service:setSelected(var4)
    else
        Service:disableFocusNav()
        Service:setShortcutBar(nil)
        GuiService.SelectedCoreObject = nil
        if FFlagEnableConsoleExpControls then
            FocusUtils.MenuIconSelectedSignal:set(false)
        end
    end
    return Enum.ContextActionResult.Sink
end

function registerShortcuts()
    Service:registerShortcut({
        id = "leave",
        label = "CoreScripts.TopBar.Leave",
        keyCode = tbl1.keyCode,
        integration = nil,
        actionName = "UnibarGamepadLeaveGame",
        activated = tbl1.activated
    })

    Service:registerShortcut({
        id = "respawn",
        label = "CoreScripts.InGameMenu.QuickActions.Respawn",
        keyCode = tbl2.keyCode,
        integration = tbl2.integration,
        actionName = "UnibarGamepadRespawn",
        activated = tbl2.activated
    })

    if FFlagChromeShortcutAddRespawnLeaveToIEM then
        Service:registerShortcut({
            id = "leave_in_experience_menu",
            label = nil,
            keyCode = tbl1.keyCode,
            integration = nil,
            actionName = "IEMGamepadLeaveGame",
            activated = tbl1.activated
        })

        Service:registerShortcut({
            id = "respawn_in_experience_menu",
            label = nil,
            keyCode = tbl2.keyCode,
            integration = tbl2.integration,
            actionName = "IEMGamepadRespawn",
            activated = tbl2.activated
        })
    end

    Service:registerShortcut({
        id = "chat",
        label = "CoreScripts.TopBar.Chat",
        keyCode = if FFlagChromeShortcutChatOpenKeyboard then Enum.KeyCode.ButtonL2 else Enum.KeyCode.ButtonR1,
        integration = "chat",
        actionName = "UnibarGamepadChat",
        activated = FFlagEnableConsoleExpControls and function()
            local visibility = ChatSelector:GetVisibility()
            if FFlagChromeShortcutChatOpenKeyboard then
                if FFlagConsoleChatUseChromeFocusUtils and var1.getChatInputBarFocused(false) then
                    FocusUtils.FocusOnChrome(function()
                        var1.unfocusChatInputBar()
                    end, "chat")
                    ChatSelector:SetVisible(false)
                    GameSettings.ChatVisible = false
                    return
                end
                ChatSelector:SetVisible(true)
                GameSettings.ChatVisible = true
                ChatSelector:FocusChatBar()
                FocusSelectExpChat("chat")
                return
            end

            ChatSelector:SetVisible(not visibility)
            if not visibility then
                FocusSelectExpChat("chat")
            elseif FFlagConsoleChatUseChromeFocusUtils and var1.getChatInputBarFocused(false) then
                FocusUtils.FocusOnChrome(function()
                    var1.unfocusChatInputBar()
                end, "chat")
            end
        end or nil
    })

    Service:registerShortcut({
        id = "tiltMenu",
        label = "CoreScripts.TopBar.Menu",
        keyCode = Enum.KeyCode.ButtonR2,
        integration = nil,
        actionName = "UnibarGamepadMenu",
        activated = function()
            local settingsHub = require(RobloxGui.Modules.Settings.SettingsHub)
            if settingsHub:GetVisibility() then
                settingsHub:SetVisibility(false)
                return
            end

            if FFlagConsoleChatUseChromeFocusUtils and var1.getChatInputBarFocused(false) then
                var1.unfocusChatInputBar()
            end
            if isSideSheetEnabled and FFlagSideSheetFocusNav then
                if not getSideSheetVisibility() then
                    toggleSideSheet(true)
                end
            else
                settingsHub:SetVisibility(true)
            end
        end
    })

    Service:registerShortcut({
        id = "back",
        label = "CoreScripts.TopBar.Back",
        keyCode = Enum.KeyCode.ButtonB,
        displayPriority = if FFlagEnableConsoleExpControls then -10 else nil,
        integration = nil,
        actionName = "UnibarGamepadBack",
        activated = activateBack
    })

    if FFlagRemoveLeaveShortcutFromLeaveConfirm or FFlagRemoveRespawnShortcutFromRespawnConfirmation then
        Service:registerShortcut({
            id = "back-invisible",
            label = nil,
            keyCode = Enum.KeyCode.ButtonB,
            actionName = "UnibarGamepadBackInvisible",
            activated = activateBack
        })
    end

    Service:registerShortcut({
        id = "close",
        label = nil,
        keyCode = Enum.KeyCode.ButtonStart,
        actionName = "UnibarGamepadClose",
        activated = function()
            require(RobloxGui.Modules.Settings.SettingsHub):SetVisibility(false)
            Service:disableFocusNav()
            Service:setShortcutBar(nil)
            GuiService.SelectedCoreObject = nil
        end
    })

    Service:registerShortcut({
        id = "virtualCursor",
        label = nil,
        keyCode = Enum.KeyCode.ButtonSelect,
        actionName = "VirtualCursorShortcut",
        activated = function()
            Service:disableFocusNav()
            Service:setShortcutBar(nil)
            GuiService.SelectedCoreObject = nil
            GamepadService.GamepadCursorEnabled = true
        end
    })

    Service:registerShortcut({
        id = "tiltMenuPreviousTab",
        label = "CoreScripts.InGameMenu.Controls.PreviousTab",
        keyCode = Enum.KeyCode.ButtonL1,
        integration = nil,
        actionName = nil,
        activated = nil
    })

    Service:registerShortcut({
        id = "tiltMenuNextTab",
        label = "CoreScripts.InGameMenu.Controls.NextTab",
        keyCode = Enum.KeyCode.ButtonR1,
        integration = nil,
        actionName = nil,
        activated = nil
    })
end

function configureShortcutBars()
    Service:configureShortcutBar(
        Constants.UNIBAR_SHORTCUTBAR_ID,
        FFlagShowUnibarOnVirtualCursor and {
            "leave",
            "respawn",
            "chat",
            "tiltMenu",
            "back",
            "virtualCursor"
        }
            or {
                "leave",
                "respawn",
                "chat",
                "tiltMenu",
                "back"
            }
    )

    Service:configureShortcutBar(
        Constants.TILTMENU_SHORTCUTBAR_ID,
        FFlagAddSwitchTabHintsToIEM and {
            "leave_in_experience_menu",
            "respawn_in_experience_menu",
            "back-invisible",
            "close"
        }
            or FFlagChromeShortcutAddRespawnLeaveToIEM
                and {
                    "leave_in_experience_menu",
                    "respawn_in_experience_menu",
                    "tiltMenuPreviousTab",
                    "tiltMenuNextTab",
                    "back",
                    "close"
                }
            or {
                "tiltMenuPreviousTab",
                "tiltMenuNextTab",
                "back",
                "close"
            }
    )

    if not (FFlagChromeShortcutRemoveRespawnOnLeavePage and FFlagChromeShortcutRemoveLeaveOnRespawnPage) then
        Service:configureShortcutBar(Constants.TILTMENU_DIALOG_SHORTCUTBAR_ID, { "leave", "respawn", "back", "close" })
    end

    if FFlagRemoveLeaveShortcutFromLeaveConfirm then
        Service:configureShortcutBar(Constants.TILTMENU_LEAVE_DIALOG_SHORTCUTBAR_ID, { "back-invisible", "close" })
    elseif FFlagChromeShortcutRemoveRespawnOnLeavePage then
        Service:configureShortcutBar(Constants.TILTMENU_LEAVE_DIALOG_SHORTCUTBAR_ID, { "leave", "back", "close" })
    end

    if FFlagRemoveRespawnShortcutFromRespawnConfirmation then
        Service:configureShortcutBar(Constants.TILTMENU_RESPAWN_DIALOG_SHORTCUTBAR_ID, { "back-invisible", "close" })
        return
    end
    if not FFlagChromeShortcutRemoveLeaveOnRespawnPage then
        return
    end

    Service:configureShortcutBar(Constants.TILTMENU_RESPAWN_DIALOG_SHORTCUTBAR_ID, { "respawn", "back", "close" })
end

return function()
    registerShortcuts()
    configureShortcutBars()
end
