-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local PeekView = require(ProfilePlatformParent.PeekView)
local PeekView2 = PeekView.PeekView
local PeekViewState = PeekView.PeekViewState
local RoactUtils = require(ProfilePlatformParent.RoactUtils)
local Foundation = require(ProfilePlatformParent.Foundation)
local View = Foundation.View
local BackgroundStyleContext = Foundation.BackgroundStyleContext
local useStyle = require(ProfilePlatformParent.UIBlox).Core.Style.useStyle
local Enums = require(ProfilePlatform.Common.Enums)
local FFlagProfilePlatformNewProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformNewProfileHeader
local FFlagProfilePlatformPeekDraggerContrast = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformPeekDraggerContrast
local FFlagSduiMarkdownTextComponentEnabled = require(ProfilePlatformParent.SharedFlags).FFlagSduiMarkdownTextComponentEnabled

local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local num1 = if FFlagProfilePlatformNewProfileHeader then 0 else 25

local function SheetBackground(tbl1)
    local theme = useStyle().Theme
    local value = React.useMemo(function()
        return {
            Color3 = theme.BackgroundContrast.Color,
            Transparency = 0
        }
    end, { theme })
    return React.createElement(BackgroundStyleContext.Provider, { value = value }, tbl1.children)
end

local function ProfilePeekView(tbl1)
    local yOffset = tbl1.statusBarHeight or useSelector(function(arg1)
        return arg1.TopBar.statusBarHeight
    end)

    local var1 = if FFlagProfilePlatformNewProfileHeader then useStyle() else nil

    local viewStateChanged = React.useCallback(function(closed, arg1, arg2)
        if closed == PeekViewState.Closed and tbl1.onClosed then
            tbl1.onClosed()
        end

        if tbl1.onViewStateChanged then
            tbl1.onViewStateChanged(closed, arg1, arg2)
        end
    end, { tbl1.onClosed, tbl1.onViewStateChanged })

    local var3, var4 = React.useBinding(0)
    local function briefToFullTransitionPercent(arg1)
        var4(arg1)
        if tbl1.transitionPercentCallback then
            tbl1.transitionPercentCallback(arg1)
        end
    end

    local uDim2 = if FFlagProfilePlatformNewProfileHeader then UDim2.new(1, 0, 1, -yOffset) else UDim2.new(1, 0, 1, -yOffset + num1)
    local uDim2_2 = if FFlagProfilePlatformNewProfileHeader then UDim2.new(0, 0, 0, yOffset) else UDim2.new(0, 0, 0, yOffset - num1)
    local contrast = if FFlagProfilePlatformNewProfileHeader
        and FFlagProfilePlatformPeekDraggerContrast
        and tbl1.profileType == Enums.ProfileTypes.User then var1.Tokens.Color.System.Contrast else nil
    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = "position-top-left",
        Size = UDim2.new(tbl1.viewWidth or UDim.new(1, 0), UDim.new(1, 0))
    }
    local tbl3 = {
        StatusBarSpace = if FFlagProfilePlatformNewProfileHeader then nil else React.createElement(
            View,
            {
                tag = "position-top-left bg-surface-0",
                Size = UDim2.new(1, 0, 0, yOffset),
                BorderSizePixel = 0,
                ZIndex = 999
            }
        ),
        ProfileContent = 0,
        PeekViewTopBar = 0,
        TransparentTopBarOverlay = 0
    }

    local createElement2 = React.createElement
    local var6 = View
    local tbl4 = { Size = uDim2, Position = uDim2_2 }
    local tbl5 = {
        PeekView = React.createElement(PeekView2, {
            hasScrim = true,
            fullViewContentHeight = tbl1.fullViewContentHeight,
            briefViewContentHeight = if tbl1.briefViewContentHeight then tbl1.briefViewContentHeight else UDim.new(0.5, 0),
            bottomDockedContainerHeight = tbl1.bottomDockedContainerHeight,
            bottomDockedContainerContent = {
                PeekViewBottomBar = tbl1.bottomBarSlot
            },
            mountAsFullView = tbl1.mountAsFullView,
            mountAnimation = tbl1.mountAnimation,
            viewStateChanged = viewStateChanged,
            briefToFullTransitionPercent = briefToFullTransitionPercent,
            hasSolidDragger = not (FFlagProfilePlatformNewProfileHeader and tbl1.profileType == Enums.ProfileTypes.User) and nil,
            draggerImageStyle = contrast
        }, {
            UIListLayout = React.createElement("UIListLayout", {
                Padding = UDim.new(0, 0),
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top
            }),
            Content = if FFlagSduiMarkdownTextComponentEnabled then React.createElement(SheetBackground, nil, { Content = tbl1.contentSlot }) else tbl1.contentSlot
        })
    }
    tbl3.ProfileContent = createElement2(var6, tbl4, tbl5)
    local element

    if FFlagProfilePlatformNewProfileHeader then
        element = React.createElement("CanvasGroup", {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 0, yOffset + 56),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            GroupTransparency = var3:map(function(arg1): number
                return 1 - arg1
            end),
            ZIndex = 1000
        }, {
            StatusBarBackground = React.createElement("Frame", {
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 0, yOffset),
                BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
                BackgroundTransparency = 0,
                BorderSizePixel = 0
            }),
            TopBarSlotContainer = React.createElement("Frame", {
                Position = UDim2.new(0, 0, 0, yOffset),
                Size = UDim2.new(1, 0, 0, 56),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }, {
                TopBar = tbl1.topBarSlot
            })
        })
    else
        element = nil
    end

    tbl3.PeekViewTopBar = element

    tbl3.TransparentTopBarOverlay = if FFlagProfilePlatformNewProfileHeader then nil else React.createElement(
        "CanvasGroup",
        {
            Size = UDim2.new(1, 0, 0, 56),
            Position = UDim2.new(0, 0, 0, yOffset),
            BackgroundTransparency = 1,
            ZIndex = 1000,
            GroupTransparency = var3:map(function(arg1): number
                return 1 - arg1
            end)
        },
        {
            TopBar = tbl1.topBarSlot
        }
    )

    return createElement(var5, tbl2, tbl3)
end

return ProfilePeekView
