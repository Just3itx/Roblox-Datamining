-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local UIBlox = require(scriptParentParentParent.UIBlox)
local Cryo = require(scriptParentParentParent.Cryo)
local Foundation = require(scriptParentParentParent.Foundation)
local GetTextSize = require(scriptParentParentParent.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useStyle = UIBlox.Core.Style.useStyle
local HeaderBar = UIBlox.App.Bar.HeaderBar
local UtilityActionIcon = UIBlox.App.Button.UtilityActionIcon

local SharedFlags = require(scriptParentParentParent.SharedFlags)

local FFlagEnableConsoleRobloxLogo = SharedFlags.FFlagEnableConsoleRobloxLogo
local bool1 = game:DefineFastFlag("AppHeaderBarUseSizeFull", false)
local FFlagEnableClassicThemeHeaderBackground = SharedFlags.FFlagEnableClassicThemeHeaderBackground
local AppHeaderBarClassicThemeBackground = if FFlagEnableClassicThemeHeaderBackground then require(script.Parent.AppHeaderBarClassicThemeBackground) else nil
local useClassicThemeHeaderBackgroundConfig = if FFlagEnableClassicThemeHeaderBackground then require(script.Parent.Parent.Hooks.useClassicThemeHeaderBackgroundConfig) else nil
local _Types = require(scriptParentParent.Types)

local tbl1 = {
    automaticHeight = false,
    hasDivider = false,
    onMedia = false,
    isTitleCentered = false,
    enableHeaderImageBackground = not FFlagEnableClassicThemeHeaderBackground and nil,
    utilitiesGap = UDim.new(0, 0)
}

local function BarTitle(tbl2)
    local tokens = useStyle().Tokens

    local layoutOrder = tbl2.layoutOrder
    local title = tbl2.title
    local var1 = tbl2.titleFont or tokens.Typography.HeadingLarge
    local var2 = if tbl2.onMedia then tokens.Color.Extended.White.White_100 else tokens.Color.Content.Emphasis

    local var3 = React.useMemo(function(): UDim2
        local vector2 = Vector2.new(math.huge, math.huge)
        local textSize = GetTextSize(title, var1.FontSize, var1.Font, vector2, { addTemporaryPadding = false })

        return UDim2.fromOffset(textSize.X + 2, textSize.Y + tokens.Size.Size_50 * 2)
    end, {
        title,
        var1.FontSize,
        var1.Font,
        tokens
    })
    return React.createElement(
        "TextLabel",
        {
            LayoutOrder = layoutOrder,
            Size = var3,
            BackgroundTransparency = 1,
            Text = title,
            FontFace = normalizeFontFace(var1.Font),
            TextSize = var1.FontSize,
            LineHeight = var1.LineHeight,
            TextColor3 = var2.Color3,
            TextTransparency = var2.Transparency,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        },
        Cryo.Dictionary.join(tbl2.children or {}, {
            Padding = React.createElement(
                "UIPadding",
                {
                    PaddingTop = UDim.new(0, tokens.Size.Size_50),
                    PaddingBottom = UDim.new(0, tokens.Size.Size_50)
                }
            )
        })
    )
end

local function useRenderLeft(arg1)
    local renderNavigation = arg1.renderNavigation
    local title = arg1.title
    local onMedia = arg1.onMedia
    local titleFontStyle = arg1.titleFontStyle
    local isTitleCentered = arg1.isTitleCentered
    local groupTransparencyLeft = arg1.groupTransparencyLeft

    return React.useCallback(function(arg2)
        local createElement = React.createElement
        local str1 = if groupTransparencyLeft then "CanvasGroup" else "Frame"
        local tbl2 = {
            BackgroundTransparency = 1,
            GroupTransparency = if groupTransparencyLeft then groupTransparencyLeft.transparency else nil,
            ref = if groupTransparencyLeft then groupTransparencyLeft.guiObjectRef else nil,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY
        }
        local tbl3 = {
            ListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            Navigation = if renderNavigation then renderNavigation({ layoutOrder = 1 }) else nil,
            Title = if title and not isTitleCentered then React.createElement(
                BarTitle,
                { layoutOrder = 2, title = title, titleFont = titleFontStyle, onMedia = onMedia },
                if arg2 then arg2.children else nil
            ) else nil
        }
        return createElement(str1, tbl2, tbl3)
    end, {
        renderNavigation,
        title,
        titleFontStyle,
        groupTransparencyLeft,
        onMedia,
        isTitleCentered
    })
end

local function useRenderCenter(arg1)
    local renderCenter = arg1.renderCenter
    local title = arg1.title
    local onMedia = arg1.onMedia
    local titleFontStyle = arg1.titleFontStyle
    local isTitleCentered = arg1.isTitleCentered
    local groupTransparencyCenter = if FFlagEnableConsoleRobloxLogo then arg1.groupTransparencyCenter else nil

    return React.useCallback(function()
        if renderCenter then
            if not FFlagEnableConsoleRobloxLogo then
                return renderCenter()
            end

            return React.createElement(
                if groupTransparencyCenter then "CanvasGroup" else "Frame",
                {
                    BackgroundTransparency = 1,
                    GroupTransparency = if groupTransparencyCenter then groupTransparencyCenter.transparency else nil,
                    ref = if groupTransparencyCenter then groupTransparencyCenter.guiObjectRef else nil,
                    BorderSizePixel = 0,
                    Size = if bool1 then UDim2.fromScale(1, 1) else nil,
                    AutomaticSize = if bool1 then nil else Enum.AutomaticSize.XY
                },
                {
                    CenterContent = renderCenter()
                }
            )
        elseif title and isTitleCentered then
            return React.createElement(BarTitle, { title = title, titleFont = titleFontStyle, onMedia = onMedia })
        else
            return nil
        end
    end, {
        renderCenter,
        title,
        titleFontStyle,
        isTitleCentered,
        onMedia,
        groupTransparencyCenter
    })
end

local function useRenderRight(arg1)
    local renderUserInfo = arg1.renderUserInfo
    local avatarActionIcon = arg1.avatarActionIcon
    local searchActionIcon = arg1.searchActionIcon
    local renderUtilities = arg1.renderUtilities
    local utilitiesGap = arg1.utilitiesGap
    local groupTransparencyRight = arg1.groupTransparencyRight

    return React.useCallback(function()
        return React.createElement(if groupTransparencyRight then "CanvasGroup" else "Frame", {
            Size = UDim2.fromScale(0, 1),
            BackgroundTransparency = 1,
            GroupTransparency = if groupTransparencyRight then groupTransparencyRight.transparency else nil,
            ref = if groupTransparencyRight then groupTransparencyRight.guiObjectRef else nil,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X
        }, {
            ListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = utilitiesGap
            }),
            UserInfo = if renderUserInfo then renderUserInfo({ layoutOrder = 1, itemsGap = utilitiesGap }) else nil,
            Avatar = if avatarActionIcon then React.createElement(
                UtilityActionIcon,
                {
                    layoutOrder = 2,
                    icon = avatarActionIcon.icon,
                    iconColor = {},
                    onActivated = avatarActionIcon.onActivated
                }
            ) else nil,
            SearchIcon = if searchActionIcon then React.createElement(
                UtilityActionIcon,
                {
                    layoutOrder = 3,
                    icon = searchActionIcon.icon,
                    onActivated = searchActionIcon.onActivated
                }
            ) else nil,
            Utilities = if renderUtilities then renderUtilities({ layoutOrder = 4, itemsGap = utilitiesGap }) else nil
        })
    end, {
        renderUserInfo,
        avatarActionIcon,
        searchActionIcon,
        renderUtilities,
        utilitiesGap,
        groupTransparencyRight
    })
end

local function shouldRenderRight(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local renderUserInfo = arg1.renderUserInfo
    local avatarActionIcon = arg1.avatarActionIcon
    local searchActionIcon = arg1.searchActionIcon
    local renderUtilities = arg1.renderUtilities

    return not not (renderUserInfo or avatarActionIcon or searchActionIcon or renderUtilities)
end

local function AppHeaderBarComponent(arg1)
    local var1 = Cryo.Dictionary.join(tbl1, arg1)

    local barHeight = var1.barHeight
    local zIndex = var1.zIndex
    local automaticHeight = var1.automaticHeight
    local groupTransparency = var1.groupTransparency
    local backgroundStyle = var1.backgroundStyle
    local hasDivider = var1.hasDivider
    local onMedia = var1.onMedia
    local onHeaderActivated = var1.onHeaderActivated

    local paddingLeft = var1.paddingLeft
    local paddingTop = var1.paddingTop
    local paddingRight = var1.paddingRight
    local paddingBottom = var1.paddingBottom
    local tag = var1.tag

    local renderLeft = useRenderLeft(var1)
    local renderCenter = useRenderCenter(var1)
    local var4 = useRenderRight(var1)
    local bool2 = shouldRenderRight(var1)
    local config = if FFlagEnableClassicThemeHeaderBackground then useClassicThemeHeaderBackgroundConfig() else nil
    local var6 = FFlagEnableClassicThemeHeaderBackground and var1.enableHeaderImageBackground and config ~= nil

    local guiObjectRef = nil
    local var7 = nil
    if FFlagEnableClassicThemeHeaderBackground then
        var7 = React.useRef(nil)
        local guiObjectRef2 = if groupTransparency then groupTransparency.guiObjectRef else nil

        guiObjectRef = React.useCallback(function(current)
            var7.current = current
            if type(guiObjectRef2) == "function" then
                guiObjectRef2(current)
            elseif guiObjectRef2 then
                guiObjectRef2.current = current
            end
        end, { guiObjectRef2 })
    end

    local createElement = React.createElement
    local str1 = if groupTransparency then "CanvasGroup" else "Frame"
    local tbl2 = {
        Size = UDim2.fromScale(1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        GroupTransparency = if groupTransparency then groupTransparency.transparency else nil
    }

    if not FFlagEnableClassicThemeHeaderBackground then
        if groupTransparency then
            guiObjectRef = groupTransparency.guiObjectRef
        else
            guiObjectRef = nil
        end
    end

    tbl2.ref = guiObjectRef

    tbl2.AutomaticSize = Enum.AutomaticSize.Y
    tbl2[React.Tag] = tag
    local tbl3 = {
        HeaderImageBackground = if var6 then React.createElement(AppHeaderBarClassicThemeBackground, { config = config, containerRef = var7 }) else nil,
        Bar = 0
    }

    local createElement2 = React.createElement
    local var8 = HeaderBar
    local tbl4 = {
        barHeight = barHeight,
        renderLeft = renderLeft,
        renderCenter = renderCenter,
        renderRight = 0,
        onHeaderActivated = 0,
        backgroundStyle = 0,
        backgroundTransparency = 0,
        isOnMedia = 0,
        automaticHeight = 0,
        paddingLeft = 0,
        paddingTop = 0,
        paddingRight = 0,
        paddingBottom = 0,
        zIndex = 0,
        hasDivider = 0
    }

    if not bool2 then
        var4 = nil
    end

    tbl4.renderRight = var4
    tbl4.onHeaderActivated = onHeaderActivated
    tbl4.backgroundStyle = backgroundStyle
    tbl4.backgroundTransparency = if var6 then 1 else nil
    tbl4.isOnMedia = onMedia
    tbl4.automaticHeight = automaticHeight
    tbl4.paddingLeft = paddingLeft
    tbl4.paddingTop = paddingTop
    tbl4.paddingRight = paddingRight
    tbl4.paddingBottom = paddingBottom
    tbl4.zIndex = zIndex
    tbl4.hasDivider = hasDivider
    tbl3.Bar = createElement2(var8, tbl4)
    return createElement(str1, tbl2, tbl3)
end

return AppHeaderBarComponent
