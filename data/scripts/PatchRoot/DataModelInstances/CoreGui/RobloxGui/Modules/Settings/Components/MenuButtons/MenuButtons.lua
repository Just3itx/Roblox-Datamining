-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Utility = require(RobloxGui.Modules.Settings.Utility)

local Constants = require(RobloxGui.Modules:WaitForChild("InGameMenu"):WaitForChild("Resources"):WaitForChild("Constants"))
local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local _Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local MenuButton = require(script.Parent.MenuButton)

local useSignalState = SignalsReact.useSignalState
local useLastInput = Responsive.useLastInput

local View = Foundation.View

local FIntRelocateMobileMenuButtonsVariant = require(RobloxGui.Modules.Settings.Flags.FIntRelocateMobileMenuButtonsVariant)
local FFlagAddTraversalHistoryReactMenuButtons = require(RobloxGui.Modules.Settings.Flags.FFlagAddTraversalHistoryReactMenuButtons)
local FFlagGamepadIconSupportCheck = require(CorePackages.Workspace.Packages.SharedFlags).FFlagGamepadIconSupportCheck

local bool1 = game:DefineFastFlag("MenuButtonsDisconnectGamepadConnected", false)
local bool2 = game:DefineFastFlag("MenuButtonsUseGreyResumeButton", false)
local FFlagIEMFocusNavSupportNewButtons = require(RobloxGui.Modules.Settings.Flags.FFlagIEMFocusNavSupportNewButtons)

local function createMenuButtons(tbl1, lastInput: string, isSmall: boolean)
    local menuButtons = ({})
    for layoutOrder = 1, #tbl1 do
        local str1 = "MenuButtonContainer" .. layoutOrder
        local createElement = React.createElement
        local var1 = View
        local tbl2 = {
            tag = "fill row align-y-center",
            LayoutOrder = layoutOrder,
            SelectionGroup = if FFlagIEMFocusNavSupportNewButtons then true else nil
        }
        local tbl3 = {
            MenuButton = React.createElement(MenuButton, {
                text = tbl1[layoutOrder].text,
                lastInput = lastInput,
                keyboardButtonImageHint = tbl1[layoutOrder].hint.keyboardButtonImage,
                gamepadButton = if FFlagGamepadIconSupportCheck then tbl1[layoutOrder].hint.gamepadButton else nil,
                gamepadButtonImageHint = tbl1[layoutOrder].hint.gamepadButtonImage,
                onActivated = tbl1[layoutOrder].onActivated,
                layoutOrder = 1,
                isEmphasized = tbl1[layoutOrder].isEmphasized,
                isSmall = isSmall,
                isDisabled = tbl1[layoutOrder].getIsDisabled(),
                addTraversalHistoryMenu = if FFlagAddTraversalHistoryReactMenuButtons then tbl1[layoutOrder].addTraversalHistoryMenu else nil,
                currentPageChangeSignal = if FFlagAddTraversalHistoryReactMenuButtons then tbl1[layoutOrder].currentPageChangeSignal else nil,
                buttonRef = if FFlagIEMFocusNavSupportNewButtons then tbl1[layoutOrder].buttonRef else nil
            })
        }
        menuButtons[str1] = createElement(var1, tbl2, tbl3)
    end

    return menuButtons
end

local function MenuButtons(tbl1)
    local isSmall, _ = React.useState(Utility:IsSmallTouchScreen())

    useSignalState(tbl1.getCanRespawn)

    local buttonRef = React.useRef(nil)
    local var2 = React.useRef(nil)
    if FFlagIEMFocusNavSupportNewButtons then
        React.useEffect(function()
            if tbl1.setResumeMenuButton then
                tbl1.setResumeMenuButton(var2.current)
            end
        end, { tbl1.setResumeMenuButton })
    end

    local gamepadButtonImage, setGamepadButtonImage = React.useBinding("")
    local var1, var3 = React.useBinding("")
    local var4, var5 = React.useBinding("")

    local var9 = useLocalization({
        LeaveGame = Constants.LeaveGameLocalizedKey,
        Respawn = Constants.RespawnLocalizedKey,
        Resume = Constants.ResumeLocalizedKey
    })
    local lastInput = useLastInput()

    local var10 = React.useMemo(function()
        local tbl2 = {
            name = "LeaveGameButton",
            text = var9.LeaveGame,
            hint = {
                keyboard = "L",
                keyboardButtonImage = "icons/controls/keys/key_l",
                gamepadButton = Enum.KeyCode.ButtonX,
                gamepadButtonImage = gamepadButtonImage,
                setGamepadButtonImage = setGamepadButtonImage
            },
            isEmphasized = false,
            getIsDisabled = function(): boolean
                return false
            end,
            onActivated = function()
                tbl1.onLeaveGame(Constants.AnalyticsMenuButtonSource)
            end,
            hotkeys = { Enum.KeyCode.L, Enum.KeyCode.ButtonX },
            hotkeyFunc = function()
                tbl1.onLeaveGame(Constants.AnalyticsMenuHotkeySource)
            end,
            addTraversalHistoryMenu = if FFlagAddTraversalHistoryReactMenuButtons then true else nil,
            currentPageChangeSignal = if FFlagAddTraversalHistoryReactMenuButtons then tbl1.currentPageChangeSignal else nil,
            buttonRef = buttonRef
        }
        local tbl3 = {
            name = "ResetButton",
            text = var9.Respawn,
            hint = {
                keyboard = "R",
                keyboardButtonImage = "icons/controls/keys/key_r",
                gamepadButton = Enum.KeyCode.ButtonY,
                gamepadButtonImage = var1,
                setGamepadButtonImage = var3
            },
            isEmphasized = false,
            getIsDisabled = function(): boolean
                return not tbl1.getCanRespawn(false)
            end,
            onActivated = function()
                tbl1.onRespawn(Constants.AnalyticsMenuButtonSource)
            end,
            hotkeys = { Enum.KeyCode.R, Enum.KeyCode.ButtonY },
            hotkeyFunc = function()
                tbl1.onRespawn(Constants.AnalyticsMenuHotkeySource)
            end
        }
        local tbl4 = {
            name = "ResumeButton",
            text = var9.Resume,
            hint = {
                keyboard = "ESC",
                keyboardButtonImage = "icons/controls/keys/key_esc",
                gamepadButton = Enum.KeyCode.ButtonStart,
                gamepadButtonImage = var4,
                setGamepadButtonImage = var5
            },
            isEmphasized = not bool2 and not (FIntRelocateMobileMenuButtonsVariant == 1),
            getIsDisabled = 0,
            onActivated = 0,
            hotkeyFunc = 0,
            hotkeys = 0,
            buttonRef = 0
        }

        function tbl4.getIsDisabled(): boolean
            return false
        end
        function tbl4.onActivated()
            tbl1.onResume(Constants.AnalyticsMenuButtonSource)
        end
        function tbl4.hotkeyFunc()
            tbl1.onResume(Constants.AnalyticsMenuHotkeySource)
        end
        tbl4.hotkeys = { Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart }
        tbl4.buttonRef = if FFlagIEMFocusNavSupportNewButtons then var2 else nil
        return { tbl2, tbl3, tbl4 }
    end, {
        var9,
        tbl1.onLeaveGame,
        tbl1.onRespawn,
        tbl1.onResume,
        tbl1.getCanRespawn
    })
    local var11 = React.useCallback(function(tbl2)
        if not tbl1.getVisibility() then
            return
        end

        for i = 1, #tbl2 do
            if tbl2[i].hotkeyFunc ~= nil then
                ContextActionService:BindCoreAction(tbl2[i].name, tbl2[i].hotkeyFunc, false, unpack(tbl2[i].hotkeys))
            end
        end
    end, {})

    local var12 = React.useCallback(function(tbl2)
        for i = 1, #tbl2 do
            ContextActionService:UnbindCoreAction(tbl2[i].name)
        end
    end, {})

    local var13 = React.useCallback(function<T>(tbl2): {T}
        local function func1(callback: (...any) -> (...any), getIsDisabled: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
            return function()
                if not getIsDisabled() then
                    var12(tbl2)
                    callback()
                end
            end
        end

        local function func2(hotkeyFunc: (...any) -> (...any), getIsDisabled: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
            return function(_, userInputState, _)
                if userInputState == Enum.UserInputState.Begin then
                    func1(hotkeyFunc, getIsDisabled)()
                end
            end
        end

        for i = 1, #tbl2 do
            tbl2[i].onActivated = func1(tbl2[i].onActivated, tbl2[i].getIsDisabled)
            tbl2[i].hotkeyFunc = func2(tbl2[i].hotkeyFunc, tbl2[i].getIsDisabled)
            tbl2[i].hint.setGamepadButtonImage(UserInputService:GetImageForKeyCode(tbl2[i].hint.gamepadButton))
        end

        tbl1.setAddMenuKeyBindings(function()
            var11(tbl2)
        end)
        tbl1.setRemoveMenuKeyBindings(function()
            var12(tbl2)
        end)

        return tbl2
    end, {})

    local var14 = React.useMemo(function()
        return var13(var10)
    end, { var10 })

    React.useEffect(function()
        local connection = UserInputService.GamepadConnected:Connect(function()
            for i = 1, #var14 do
                var14[i].hint.setGamepadButtonImage(UserInputService:GetImageForKeyCode(var14[i].hint.gamepadButton))
            end
        end)

        return function()
            if bool1 then
                connection:Disconnect()
            end
        end
    end, { var14 })

    return React.createElement(
        View,
        {
            tag = {
                ["size-full row align-y-center"] = true,
                ["gap-small"] = not isSmall,
                ["gap-xsmall"] = isSmall
            }
        },
        (createMenuButtons(var14, lastInput, isSmall))
    )
end
return MenuButtons
