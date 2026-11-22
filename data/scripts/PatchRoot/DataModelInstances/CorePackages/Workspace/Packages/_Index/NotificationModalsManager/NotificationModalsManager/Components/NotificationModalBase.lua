-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local scriptParentParentParent = script.Parent.Parent.Parent
local React = require(scriptParentParentParent.React)
local ReactRoblox = require(scriptParentParentParent.ReactRoblox)
local ReactOtter = require(scriptParentParentParent.ReactOtter)
local useState = React.useState
local useEffect = React.useEffect
local useMemo = React.useMemo

local Localization = require(scriptParentParentParent.InExperienceLocales).Localization
local LocalizationProvider = require(scriptParentParentParent.Localization).LocalizationProvider
local StyleProviderWithDefaultTheme = require(scriptParentParentParent.Style).StyleProviderWithDefaultTheme

local SettingsShowSignal = require(scriptParentParentParent.CoreScriptsCommon).SettingsShowSignal

local GetFFlagManagerAddDisplayOrderAndBackgroundDismiss = require(script.Parent.Parent.Flags.GetFFlagManagerAddDisplayOrderAndBackgroundDismiss)

local GetFFlagEnablePushNotificationsUpsellModal = require(scriptParentParentParent.SharedFlags).GetFFlagEnablePushNotificationsUpsellModal
local GetFFlagNotificationModalSetMenuIsOpen = require(scriptParentParentParent.SharedFlags).GetFFlagNotificationModalSetMenuIsOpen

local tbl1 = { stiffness = 400, damping = 40, mass = 1 }

return function(tbl2)
    local var1, var2 = useState({})
    local var3, var4 = useState(GuiService.MenuIsOpen)

    useEffect(function()
        local connection = if GetFFlagNotificationModalSetMenuIsOpen() then SettingsShowSignal:connect(function(bool1: boolean)
            if not bool1 then
                var4(false)

                return
            end

            if tbl2.CloseModal then
                tbl2.CloseModal()
            end
            var4(true)
        end) else GuiService.MenuOpened:Connect(function()
            if tbl2.CloseModal then
                tbl2.CloseModal()
            end
            var4(true)
        end)

        local connection2 = if GetFFlagNotificationModalSetMenuIsOpen() then nil else GuiService.MenuClosed:Connect(function()
            var4(false)
        end)

        return function()
            if GetFFlagNotificationModalSetMenuIsOpen() then
                connection:disconnect()
                return
            end
            connection:Disconnect()
            if connection2 ~= nil then
                connection2:Disconnect()
            end
        end
    end, {})

    local var5, var6 = ReactOtter.useAnimatedBinding(0, function()
        if var1 ~= tbl2 then
            var2(tbl2)
        end
    end)

    useEffect(function()
        local connection = nil
        if tbl2.ModalKey then
            var2(tbl2)

            connection = UserInputService.InputBegan:Connect(function(input: InputObject)
                if (input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.ButtonB)
                    and UserInputService:GetFocusedTextBox() == nil
                    and tbl2.CloseModal
                then
                    tbl2.CloseModal()
                end
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, { tbl2 })

    local var7 = useMemo(function(): number
        return if tbl2.ModalKey == nil or var3 then 0 else 1
    end, { tbl2.ModalKey, var3 })

    useEffect(function()
        var6(ReactOtter.spring(var7, tbl1))
        if not GetFFlagNotificationModalSetMenuIsOpen() then
            return
        end

        if tbl2.Params and tbl2.Params.BlockNonCoreUserInput and var7 == 1 then
            GuiService:SetMenuIsOpen(true, "NotificationModal")
            return
        end
        GuiService:SetMenuIsOpen(false, "NotificationModal")
    end, { var7 })

    local createElement = React.createElement
    local str1 = "ScreenGui"

    local tbl3 = {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        DisplayOrder = GetFFlagManagerAddDisplayOrderAndBackgroundDismiss() and var1.Params and var1.Params.DisplayOrder or 0,
        Enabled = var5:map(function(arg1): boolean
            return arg1 > 0
        end)
    }

    local tbl4 = {
        Background = React.createElement("Frame", {
            BackgroundColor3 = Color3.new(0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BorderSizePixel = 1,
            BackgroundTransparency = var5:map(function(num1: number): number
                return 1 - num1 * 0.5
            end),
            ZIndex = 0
        }),
        Container = 0
    }

    local createElement2 = React.createElement
    local str2 = "TextButton"

    local tbl5 = {
        ZIndex = 1,
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Modal = true,
        Selectable = false,
        Position = var5:map(function(arg1): UDim2
            return UDim2.new(0, 0, 1 - arg1, 0)
        end)
    }

    tbl5[ReactRoblox.Event.Activated] = function()
        local disableBackgroundDismiss = if GetFFlagManagerAddDisplayOrderAndBackgroundDismiss() then var1.Params and var1.Params.DisableBackgroundDismiss else nil

        if tbl2.CloseModal and not disableBackgroundDismiss then
            tbl2.CloseModal()
        end
    end
    local tbl6 = { LocalizationProvider = 0 }
    local createElement3 = React.createElement
    local var8 = LocalizationProvider
    local tbl7 = {
        localization = if GetFFlagEnablePushNotificationsUpsellModal() then var1.Params and var1.Params.Localization or Localization.new(LocalizationService.RobloxLocaleId) else Localization.new(LocalizationService.RobloxLocaleId)
    }

    local tbl8 = {
        StyleProvider = React.createElement(StyleProviderWithDefaultTheme, {}, {
            ModalComponent = if var1.Component then React.createElement(var1.Component, var1.Params and var1.Params.Props or {}) else nil
        })
    }
    tbl6.LocalizationProvider = createElement3(var8, tbl7, tbl8)
    tbl4.Container = createElement2(str2, tbl5, tbl6)
    return createElement(str1, tbl3, tbl4)
end
