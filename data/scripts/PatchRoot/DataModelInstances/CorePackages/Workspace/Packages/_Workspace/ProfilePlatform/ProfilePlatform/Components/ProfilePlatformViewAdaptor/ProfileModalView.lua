-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local useStyle = require(ProfilePlatformParent.UIBlox).Core.Style.useStyle
local useStatusBarHeight = require(ProfilePlatformParent.RobloxAppHooks).useStatusBarHeight
local FFlagProfileModalViewStatusBarOffset = require(ProfilePlatform.Flags.FFlagProfileModalViewStatusBarOffset)
local FFlagProfileModalViewBottomSafeArea = require(ProfilePlatform.Flags.FFlagProfileModalViewBottomSafeArea)

local FocusNavigationUtils = require(ProfilePlatformParent.FocusNavigationUtils)
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local Enums = require(ProfilePlatform.Common.Enums)
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local InputHandlers = require(ProfilePlatformParent.InputHandlers)
local Display = require(ProfilePlatformParent.Display)
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local FFlagFixCommunityProfileWideCoverLayout = require(ProfilePlatform.Flags.FFlagFixCommunityProfileWideCoverLayout)

local View = require(ProfilePlatformParent.Foundation).View

return function(tbl1)
    local var1 = useStyle()

    local var2 = useSignalState(Display.GetDisplayStore().getDeviceSafePadding)

    local frameProps = {
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.fromScale(1, 0),
        Size = if tbl1.fillPane then UDim2.fromScale(1, 1) else UDim2.new(0, tbl1.viewWidth, 1, 0),
        BackgroundTransparency = var1.Theme.BackgroundDefault.Transparency,
        BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
        BorderSizePixel = 0
    }
    local yOffset = if FFlagProfileModalViewStatusBarOffset then useStatusBarHeight() else nil
    local yOffset2 = if FFlagProfileModalViewStatusBarOffset then yOffset else 0
    local yOffset3 = if FFlagProfileModalViewStatusBarOffset then -(yOffset + (if FFlagProfileModalViewBottomSafeArea then var2.bottom else 0)) else 0
    local var3 = if FFlagFixCommunityProfileWideCoverLayout then useProfileWrapperContext() else nil
    local var4 = if FFlagFixCommunityProfileWideCoverLayout then useProfileJsonComponent(Enums.Components.CoverPhoto) else nil
    local offset = if FFlagFixCommunityProfileWideCoverLayout
        and var3 ~= nil
        and var3.profileType == Enums.ProfileTypes.Community
        and var4 ~= nil
        and var4.coverPhotoId == nil then 56 else 0

    local var5 = React.useCallback(function(arg1)
        return React.createElement("TextButton", {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0, 0),
            Text = "",
            Selectable = false
        }, { arg1 })
    end)

    local handler = React.useMemo(function()
        return InputHandlers.onRelease(function(arg1)
            arg1:cancel()
            tbl1.navigateBack()
        end)
    end, { tbl1.navigateBack })

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl3 = {
        Position = UDim2.fromOffset(0, -var2.top),
        Size = UDim2.new(1, var2.right, 1, var2.top + var2.bottom),
        BackgroundTransparency = var1.Theme.Overlay.Transparency,
        BackgroundColor3 = var1.Theme.Overlay.Color,
        Active = true,
        AutoButtonColor = false,
        [React.Event.Activated] = tbl1.navigateBack
    }
    local tbl4 = { ProfileWindow = 0 }
    local createElement2 = React.createElement
    local var7 = FocusNavigableSurfaceWrapper
    local tbl5 = {
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isIsolated = true,
        frameProps = frameProps,
        customEventHandlers = {
            [FocusNavigationEventNameEnum.NavigateBack] = { handler = handler }
        }
    }

    local tbl6 = {
        ProfileTopBarContainer = React.createElement(View, {
            tag = {
                ["anchor-top-left"] = FFlagProfileModalViewStatusBarOffset,
                ["position-top-left"] = not FFlagProfileModalViewStatusBarOffset
            },
            Position = if FFlagProfileModalViewStatusBarOffset then UDim2.new(0, 0, 0, yOffset) else nil,
            Size = UDim2.new(1, 0, 0, 56),
            ZIndex = 100
        }, {
            ProfileTopBar = tbl1.renderTopBar()
        }),
        PeekViewContainer = React.createElement("ScrollingFrame", {
            ScrollingDirection = Enum.ScrollingDirection.Y,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 1, 1, yOffset3),
            Position = UDim2.new(0, 0, 0, yOffset2),
            ScrollBarThickness = 0,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Selectable = false
        }, {
            TopInset = if FFlagFixCommunityProfileWideCoverLayout and offset > 0 then React.createElement("UIPadding", { PaddingTop = UDim.new(0, offset) }) else nil,
            Content = tbl1.renderContent()
        })
    }
    tbl4.ProfileWindow = createElement2(var7, tbl5, { var5(tbl6) })
    return createElement(str1, tbl3, tbl4)
end
