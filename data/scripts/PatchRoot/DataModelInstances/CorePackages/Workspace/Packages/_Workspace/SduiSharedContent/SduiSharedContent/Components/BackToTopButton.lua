-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local AppPageShell = require(SduiSharedContentParent.AppPageShell)
local DiscoveryAnalytics = require(SduiSharedContentParent.DiscoveryAnalytics)
local Foundation = require(SduiSharedContentParent.Foundation)
local Localization = require(SduiSharedContentParent.Localization)
local React = require(SduiSharedContentParent.React)
local Responsive = require(SduiSharedContentParent.Responsive)

local scrollToTop = AppPageShell.scrollToTop
local backToTopClickEvent = DiscoveryAnalytics.Events.backToTopClickEvent
local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local CursorType = Foundation.Enums.CursorType
local useLocalization = Localization.Hooks.useLocalization

local FFlagAppPageShellScrollToTopFocus = require(SduiSharedContentParent.SharedFlags).FFlagAppPageShellScrollToTopFocus

local SelectionOrder = if FFlagAppPageShellScrollToTopFocus then 1000000 else math.huge

local function scrollBackWithFocus(current: Instance)
    local tween = TweenService:Create(current, TweenInfo.new(0.3), { CanvasPosition = Vector2.new(0, 0) })

    tween:Play()
    tween.Completed:Connect(function()
        GuiService:Select(current)
    end)
end

local function BackToTopButton(tbl1)
    local var1 = useTokens()
    local selectionImageObject = useCursor(CursorType.RoundedRect)
    local bool1 = if FFlagAppPageShellScrollToTopFocus then nil else Responsive.useLastInput() == Responsive.Input.Directional
    local var3 = useLocalization({ backToTop = "Feature.GamePage.Action.BackToTop" })

    local var4 = React.useCallback(function()
        local current = tbl1.scrollingFrameRef.current
        if not current then
            return
        end

        if FFlagAppPageShellScrollToTopFocus then
            scrollToTop(current)
        elseif UserGameSettings.ReducedMotion then
            current.CanvasPosition = Vector2.new(0, 0)
        elseif bool1 then
            scrollBackWithFocus(current)
        else
            current:ScrollToTop()
        end

        backToTopClickEvent(tbl1.pageContext)
    end, { tbl1.scrollingFrameRef, tbl1.pageContext, bool1 })

    local createElement = React.createElement
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 70),
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        BackToTopButton = React.createElement("TextButton", {
            Size = UDim2.new(0.5, 0, 0, 30),
            Position = UDim2.new(0.25, 0, 0, 20),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            SelectionOrder = SelectionOrder,
            Text = var3.backToTop,
            FontFace = normalizeFontFace(var1.Typography.BodyLarge.Font),
            TextSize = var1.Typography.BodyLarge.FontSize,
            TextColor3 = var1.Color.Content.Emphasis.Color3,
            TextTransparency = var1.Color.Content.Emphasis.Transparency,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            SelectionImageObject = selectionImageObject,
            [React.Event.Activated] = var4
        })
    }
    return createElement("Frame", tbl2, tbl3)
end

return BackToTopButton
