-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Signals = require(InExperienceSideSheetParent.Signals)

local Responsive = require(InExperienceSideSheetParent.Responsive)
local GetInputModeStore = Responsive.GetInputModeStore
local Input = Responsive.Input

local IconName = require(InExperienceSideSheetParent.Foundation).Enums.IconName

local Enums = require(InExperienceSideSheet.Common.Enums)
local Constants = require(InExperienceSideSheet.Common.Constants)
local _Types = require(InExperienceSideSheet.Common.Types)

local isPioneerLaunch = require(InExperienceSideSheetParent.PioneerUtils).isPioneerLaunch
local FFlagPioneerLeaveLogsOut = require(InExperienceSideSheetParent.SharedFlags).FFlagPioneerLeaveLogsOut
local getPioneerLeaveCopy = require(InExperienceSideSheet.Common.getPioneerLeaveCopy)

local GetSwitchServerStore = require(InExperienceSideSheetParent.SwitchServer).GetSwitchServerStore

local GetActionBindingsStore = require(InExperienceSideSheet.Stores.GetActionBindingsStore)
local FFlagPioneerLogoutButtonLabel = require(InExperienceSideSheet.Flags).FFlagPioneerLogoutButtonLabel
local FFlagSideSheetEmphasizeLeave = require(InExperienceSideSheet.Flags).FFlagSideSheetEmphasizeLeave

local ButtonWidth = Enums.ButtonWidth

local tbl1 = {
    ["rbxasset://textures/ui/Controls/DefaultController/ButtonX@2x.png"] = IconName.XboxX,
    ["rbxasset://textures/ui/Controls/DefaultController/ButtonY@2x.png"] = IconName.XboxY,
    ["rbxasset://textures/ui/Controls/XboxController/ButtonX@2x.png"] = IconName.XboxX,
    ["rbxasset://textures/ui/Controls/XboxController/ButtonY@2x.png"] = IconName.XboxY,
    ["rbxasset://textures/ui/Controls/PlayStationController/ButtonSquare@2x.png"] = IconName.PsSquare,
    ["rbxasset://textures/ui/Controls/PlayStationController/ButtonTriangle@2x.png"] = IconName.PsTriagle
}

local function getIsSwitchServerButtonHidden(arg1): boolean
    return not GetSwitchServerStore(arg1).shouldEnableSwitchServer(arg1)
end

local function createRespawnButtonConfig(sessionActionBindings, getShortcutIcon, setShortcutIcon)
    return {
        name = "RespawnButton",
        label = "CoreScripts.InGameMenu.QuickActions.Respawn",
        keyboardIcon = IconName.SquareTextR,
        gamepadKeyCode = Enum.KeyCode.ButtonY,
        getShortcutIcon = getShortcutIcon,
        setShortcutIcon = setShortcutIcon,
        getOnActivated = sessionActionBindings[Enums.ActionBinding.Respawn].getOnActivated,
        getIsEnabled = sessionActionBindings[Enums.ActionBinding.Respawn].getIsEnabled,
        width = ButtonWidth.Full,
        testId = if FFlagSideSheetEmphasizeLeave then "--in-experience-side-sheet-button-respawn" else nil
    }
end

local function createLeaveButtonConfig(sessionActionBindings, getShortcutIcon, setShortcutIcon, bool1: boolean, isEmphasized: boolean)
    return {
        name = "LeaveButton",
        label = if FFlagPioneerLogoutButtonLabel then getPioneerLeaveCopy.getPioneerLeaveButtonKey(bool1) elseif not bool1 or FFlagPioneerLeaveLogsOut then "CoreScripts.InGameMenu.LeaveGame" else Constants.LocalizationKeys.QuitButton,
        keyboardIcon = IconName.SquareTextL,
        gamepadKeyCode = Enum.KeyCode.ButtonX,
        getShortcutIcon = getShortcutIcon,
        setShortcutIcon = setShortcutIcon,
        getOnActivated = sessionActionBindings[Enums.ActionBinding.Leave].getOnActivated,
        getIsEnabled = sessionActionBindings[Enums.ActionBinding.Leave].getIsEnabled,
        width = if bool1 then ButtonWidth.Half else ButtonWidth.Full,
        isEmphasized = isEmphasized,
        testId = if FFlagSideSheetEmphasizeLeave then "--in-experience-side-sheet-button-leave" else nil
    }
end

local function createSwitchServerButtonConfig(sessionActionBindings)
    return {
        name = Constants.SessionActionButtonNames.SwitchServer,
        label = "CoreScripts.InGameMenu.PeoplePage.SwitchServer",
        getOnActivated = sessionActionBindings[Enums.ActionBinding.SwitchServer].getOnActivated,
        getIsEnabled = sessionActionBindings[Enums.ActionBinding.SwitchServer].getIsEnabled,
        getIsHidden = getIsSwitchServerButtonHidden,
        width = ButtonWidth.Half,
        testId = if FFlagSideSheetEmphasizeLeave then "--in-experience-side-sheet-button-switch-server" else nil
    }
end

local function createSessionActionButtonsStore()
    local sessionActionBindings = GetActionBindingsStore().sessionActionBindings
    local var1 = isPioneerLaunch()

    local getShortcutIcon, var2 = Signals.createSignal(nil)
    local getShortcutIcon2, var3 = Signals.createSignal(nil)

    local leaveButtonConfig = createLeaveButtonConfig(sessionActionBindings, getShortcutIcon, var2, var1, FFlagSideSheetEmphasizeLeave)

    local respawnButtonConfig = createRespawnButtonConfig(sessionActionBindings, getShortcutIcon2, var3)

    local sessionActionButtonConfigs = {}
    if FFlagSideSheetEmphasizeLeave then
        table.insert(sessionActionButtonConfigs, leaveButtonConfig)
    else
        table.insert(sessionActionButtonConfigs, respawnButtonConfig)
    end

    if var1 then
        local switchServerButtonConfig = createSwitchServerButtonConfig(sessionActionBindings)
        table.insert(sessionActionButtonConfigs, switchServerButtonConfig)
    end

    if FFlagSideSheetEmphasizeLeave then
        table.insert(sessionActionButtonConfigs, respawnButtonConfig)
    else
        table.insert(sessionActionButtonConfigs, leaveButtonConfig)
    end

    local connection = nil
    local effect = Signals.createEffect(function(arg1)
        local var4 = GetInputModeStore(arg1).getLastInputType(arg1)

        if connection then
            connection:Disconnect()
        end

        if var4 == Input.Directional then
            local function setGamepadIcons()
                for _, value in sessionActionButtonConfigs do
                    if value.setShortcutIcon and value.gamepadKeyCode then
                        local contentId = UserInputService:GetImageForKeyCode(value.gamepadKeyCode)
                        value.setShortcutIcon(tbl1[contentId])
                    end
                end
            end

            connection = UserInputService.GamepadConnected:Connect(function(_userInputType: Enum.UserInputType)
                setGamepadIcons()
            end)

            setGamepadIcons()
        elseif var4 == Input.Pointer then
            for _, value in sessionActionButtonConfigs do
                if value.keyboardIcon and value.setShortcutIcon then
                    value.setShortcutIcon(value.keyboardIcon)
                end
            end
        else
            for _, value in sessionActionButtonConfigs do
                if value.setShortcutIcon then
                    value.setShortcutIcon(nil)
                end
            end
        end
    end)

    return {
        sessionActionButtonConfigs = sessionActionButtonConfigs,
        cleanUp = function()
            if connection then
                connection:Disconnect()
            end
            if effect then
                effect()
            end
        end
    }
end

return createSessionActionButtonsStore
