-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local UserInputService = game:GetService("UserInputService")

local React = require(ProfilePlatformParent.React)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local Foundation = require(ProfilePlatformParent.Foundation)

local FullscreenPageWithSafeArea = require(ProfilePlatformParent.AppBlox).FullscreenPageWithSafeArea

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local useIsMeTab = require(ProfilePlatform.Hooks.useIsMeTab)
local Constants = require(ProfilePlatform.Common.Constants)
local VisibilityControl = require(ProfilePlatformParent.AppNavBar).VisibilityControl
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagProfilePlatformMeTabScrollAway = require(ProfilePlatform.Flags.FFlagProfilePlatformMeTabScrollAway)

local View = Foundation.View
local IconButton = Foundation.IconButton
local IconSize = Foundation.Enums.IconSize
local useStyle = UIBlox.Core.Style.useStyle

local function ProfileFullView(tbl1)
    local theme = useStyle().Theme

    local bool1 = useProfileFormFactor().formFactor == Enums.ProfileFormFactor.Wide
    local var1 = if FFlagAXEnableProfileTab then useProfileWrapperContext() else nil
    local bool2 = if FFlagAXEnableProfileTab then var1.forceFullView == true else nil
    local var2 = if FFlagAXEnableProfileTab then useIsMeTab() else nil
    local offset = if bool1 then 36 else 16
    local offset2 = if bool1 then 24 else 16

    local x = if bool1 and not (FFlagAXEnableProfileTab and var2) then 1018 else math.huge

    local var3 = useProfileJsonComponent(Enums.Components.CoverPhoto) or {}

    local yOffset = if bool2 then 0 elseif var3.coverPhotoId == nil then 56 else -Constants.PAGE_PADDING

    local var4, var5 = React.useState(0)
    local bool3 = var4 > 50
    local var6 = if FFlagProfilePlatformMeTabScrollAway then bool2 else nil
    local var7 = if FFlagProfilePlatformMeTabScrollAway then React.useRef(false) else nil
    local var8 = if FFlagProfilePlatformMeTabScrollAway then React.useRef(0) else nil

    local var9 = React.useCallback(function(arg1)
        local canvasPosition = arg1.CanvasPosition
        local num1 = math.abs(canvasPosition.Y)
        var5(num1)

        if not var6 then
            return
        end

        if var7.current then
            local var9 = canvasPosition.Y - var8.current
            if var9 ~= 0 then
                VisibilityControl.onTouchMoved(-var9)
            end
        end
        var8.current = canvasPosition.Y
    end, { if FFlagProfilePlatformMeTabScrollAway then var6 else nil })

    if FFlagProfilePlatformMeTabScrollAway then
        React.useEffect(function()
            if not var6 then
                return function() end
            end
            local connection = UserInputService.TouchStarted:Connect(function()
                var7.current = true
            end)
            local connection2 = UserInputService.TouchEnded:Connect(function()
                var7.current = false
                VisibilityControl.onTouchEnded()
            end)
            return function()
                connection:Disconnect()
                connection2:Disconnect()
                VisibilityControl.show()
            end
        end, { var6 })
    end

    local element = React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, 56),
        Position = UDim2.fromOffset(0, 0),
        BackgroundColor3 = theme.BackgroundDefault.Color,
        BackgroundTransparency = if bool3 then 0.1 else 1,
        BorderSizePixel = 0,
        ZIndex = 1000
    }, {
        DropShadow = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 2),
            Position = UDim2.new(0, 0, 1, 0),
            BackgroundColor3 = theme.DropShadow.Color,
            BackgroundTransparency = if bool3 then theme.DropShadow.Transparency else 1,
            BorderSizePixel = 0
        }),
        HeaderContent = React.createElement(View, {
            Size = UDim2.fromScale(1, 1),
            tag = "padding-medium"
        }, {
            CloseButton = React.createElement(IconButton, {
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 0, 0.5, 0),
                iconSize = IconSize.Medium,
                icon = "icons/navigation/close",
                onActivated = tbl1.navigateBack,
                backgroundTransparency = 1
            })
        })
    })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromScale(1, if bool1 then 0 else 1),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, yOffset)
    }
    local tbl3 = {
        UIListLayout = if bool1 then React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 0)
        }) else nil,
        ConstrainedContent = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.fromScale(1, if bool1 then 0 else 1),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = if bool1 then 1 else nil
    }
    local tbl5 = {
        UISizeConstraint = if bool1 then React.createElement("UISizeConstraint", { MaxSize = Vector2.new(x, math.huge) }) else nil,
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = if FFlagAXEnableProfileTab and var2 or not bool1 then nil else UDim.new(0, offset),
            PaddingRight = if FFlagAXEnableProfileTab and var2 or not bool1 then nil else UDim.new(0, offset),
            PaddingTop = if FFlagAXEnableProfileTab and var2 then UDim.new(0, 24) elseif bool1 then UDim.new(0, offset2) else nil,
            PaddingBottom = UDim.new(0, offset2)
        }),
        Content = tbl1.renderContent()
    }
    tbl3.ConstrainedContent = createElement2(str2, tbl4, tbl5)
    local contentFrame = createElement(str1, tbl2, tbl3)

    local createElement3 = React.createElement
    local var10 = FullscreenPageWithSafeArea
    local tbl6 = {
        includeStatusBar = not (FFlagAXEnableProfileTab and bool2),
        useFullScalePage = if FFlagAXEnableProfileTab then bool2 or nil else nil,
        BackgroundColor3 = theme.BackgroundDefault.Color,
        BackgroundTransparency = theme.BackgroundDefault.Transparency
    }
    local tbl7 = { ContentContainer = 0, StickyHeader = 0 }
    local createElement4 = React.createElement
    local tbl8 = {
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }

    local tbl9 = {
        ScrollingFrame = React.createElement("ScrollingFrame", {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromOffset(0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            CanvasSize = UDim2.new(1, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Selectable = false,
            ElasticBehavior = Enum.ElasticBehavior.Never,
            [React.Change.CanvasPosition] = var9
        }, { ContentFrame = contentFrame })
    }
    tbl7.ContentContainer = createElement4("Frame", tbl8, tbl9)

    if FFlagAXEnableProfileTab and bool2 then
        element = nil
    end

    tbl7.StickyHeader = element
    return createElement3(var10, tbl6, tbl7)
end

return ProfileFullView
