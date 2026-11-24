-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local React = require(ExpChatParent.React)

local Localization = require(ExpChatParent.RobloxAppLocales).Localization
local LocalizationService = game:GetService("LocalizationService")
local LocalizationProvider = require(ExpChatParent.Localization).LocalizationProvider

local ChatBoxContextMenu = require(ExpChatParent.ChatLineReporting).ChatBoxContextMenu
local Constants = require(ExpChatParent.ChatLineReporting).Constants
local GetFFlagMemoizeChatReportingMenu = require(ExpChatParent.SharedFlags).GetFFlagMemoizeChatReportingMenu
local ReactFocusNavigation = require(ExpChatParent.ReactFocusNavigation)
local SignalsReact = require(ExpChatParent.SignalsReact)

local Foundation = require(ExpChatParent.Foundation)
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local View = Foundation.View

local getFFlagChatWindowUseCallbackOptimizations = require(ExpChat.Flags.getFFlagChatWindowUseCallbackOptimizations)
local bool1 = game:DefineFastFlag("ExpChatTopBannerZIndexFix", false)

local var1 = require(ExpChat.Stores.GetFocusNavigationStore)(false)

local function func1(arg1)
    local ref = React.useRef(nil)
    local var3, setContextMenuOpen = React.useState(false)
    local localization = Localization.new(LocalizationService.RobloxLocaleId)

    local var5 = ReactFocusNavigation.useFocusGuiObject()
    local var6 = SignalsReact.useSignalState(var1.getChatInputBarFocused)

    local current = React.useCallback(function()
        arg1.onUnfocus()
        if var6 and ref.current then
            var5(ref.current)
            GuiService.SelectedCoreObject = nil
        end
    end, { var6, var5, arg1.onUnfocus })

    local var8 = React.useRef(current)

    React.useEffect(function()
        var8.current = current
    end, { current })

    React.useEffect(function()
        return function()
            if var3 and var8.current then
                var8.current()
            end
        end
    end, { var3 })

    React.useEffect(function(): (() -> ())?
        return if var6 and var3 then function()
            setContextMenuOpen(false)
        end else nil
    end, { var6, var3 })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 0, Constants.TopBannerSize),
        BackgroundTransparency = 1,
        ZIndex = if bool1 then 2 else nil
    }

    local tbl2 = {
        DotMenu = React.createElement(
            View,
            {
                Size = UDim2.new(0, Constants.IconButtonSize, 0, Constants.IconButtonSize),
                Position = UDim2.new(1, Constants.IconButtonPositionXOffset, 0, Constants.IconButtonPositionYOffset),
                onActivated = not getFFlagChatWindowUseCallbackOptimizations() and function()
                    setContextMenuOpen(true)
                    arg1.onFocus()
                end or React.useCallback(function()
                    setContextMenuOpen(true)
                    arg1.onFocus()
                end, { setContextMenuOpen, arg1.onFocus }),
                tag = "auto-xy padding-small radius-medium align-x-center align-y-center",
                ref = ref
            },
            React.createElement(
                Icon,
                {
                    name = IconName.ThreeDotsHorizontal,
                    size = IconSize.Large,
                    style = {
                        Transparency = arg1.iconTransparency
                    }
                }
            )
        ),
        LocalizationProvider = 0
    }

    local createElement2 = React.createElement
    local var9 = LocalizationProvider
    local tbl3 = { localization = localization }
    local tbl4 = {
        ContextMenu = if var3 then React.createElement(ChatBoxContextMenu, {
            setContextMenuOpen = setContextMenuOpen,
            backgroundColor3 = arg1.backgroundColor3,
            backgroundTransparency = arg1.backgroundTransparency,
            getMessages = if GetFFlagMemoizeChatReportingMenu() then arg1.getMessages else nil,
            messages = if GetFFlagMemoizeChatReportingMenu() then nil else arg1.messages
        }) else nil
    }
    tbl2.LocalizationProvider = createElement2(var9, tbl3, tbl4)
    return createElement(str1, tbl1, tbl2)
end

if GetFFlagMemoizeChatReportingMenu() then
    return (React.memo(func1))
end

return func1
