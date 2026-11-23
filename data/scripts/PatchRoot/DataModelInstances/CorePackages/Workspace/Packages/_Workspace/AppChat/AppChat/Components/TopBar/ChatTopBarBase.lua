-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local FFlagAppChatFoundationHeaderBar = require(AppChat.Flags.FFlagAppChatFoundationHeaderBar)

local FFlagAppChatFoundationHeaderBarPageMarginInset = require(AppChat.Flags.FFlagAppChatFoundationHeaderBarPageMarginInset)
local FFlagAppChatPerfTracking = require(AppChat.Flags.FFlagAppChatPerfTracking)
local AppChatPerfTracker = require(AppChat.Telemetry.AppChatPerfTracker)
local createBackFunc = require(script.Parent.createBackFunc)
local Foundation = require(AppChatParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local React = require(AppChatParent.React)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local UIBlox = require(AppChatParent.UIBlox)
local useStyle = UIBlox.Core.Style.useStyle
local AppNavBar = require(AppChatParent.AppNavBar)
local VisibilityControl = AppNavBar.VisibilityControl
local FFlagAppIaScrollAway = require(AppChatParent.SharedFlags).FFlagAppIaScrollAway

local HeaderBar = UIBlox.App.Bar.HeaderBar
local HeaderBar2 = Foundation.HeaderBar
local AppHeaderBar = require(AppChatParent.AppHeaderBar)
local GetTopBarStore = require(AppChat.Stores.GetTopBarStore)
local SignalsReact = require(AppChatParent.SignalsReact)
local ThemeBackground = require(AppChatParent.ThemeBackground)
local FFlagAppThemeHalloween2026ChatBackground = require(AppChat.Flags.FFlagAppThemeHalloween2026ChatBackground)

local useSignalState = SignalsReact.useSignalState

local function noOp()
    return nil
end

local function createFoundationTitle(text: string?, shouldBoldHeader: boolean?, isTitleLeftAligned: boolean?)
    if not text or text == "" then
        return nil
    end

    return React.createElement(Foundation.Text, {
        Text = text,
        LayoutOrder = 1,
        tag = {
            ["auto-xy text-no-wrap text-truncate-end content-emphasis"] = true,
            ["text-heading-large"] = shouldBoldHeader == true,
            ["text-heading-medium"] = not shouldBoldHeader,
            shrink = not isTitleLeftAligned
        }
    })
end

local function ChatTopBarBase(tbl1)
    React.useEffect(function()
        if FFlagAppChatPerfTracking then
            AppChatPerfTracker.finish(AppChatPerfTracker.Events.TopBarRenderInterval)
        end
    end, {})

    local screenName = tbl1.screenName
    local navigation = tbl1.navigation

    local var1 = GetTopBarStore(false).getScreenTopBar(screenName)
    local var2 = useSignalState(var1)
    local screenProps = if FFlagAppIaScrollAway then navigation.getScreenProps("isInExperience", false) else nil
    local barHeight = navigation.getScreenProps("topBarHeight", 0)
    local navigateToRootStack = navigation.getScreenProps("navigateToRootStack", nil)

    local headerText = var2.headerText or {}
    local backButtonEnabled = var2.backButtonEnabled
    local closeButtonEnabled = var2.closeButtonEnabled
    local isRoot = var2.isRoot
    local shouldBoldHeader = var2.shouldBoldHeader
    local isTitleLeftAligned = var2.isTitleLeftAligned
    local leftPaddingOverride = var2.leftPaddingOverride
    local rightPaddingOverride = var2.rightPaddingOverride
    local closeInputBar = var2.closeInputBar
    local isSecondary = var2.isSecondary

    local makeBackButton = AppHeaderBar.makeBackButton
    local makeCloseButton = AppHeaderBar.makeCloseButton

    local var3 = useLocalization({ headerText = if headerText.shouldLocalize then headerText.raw or nil else nil })

    local var4 = headerText.shouldLocalize and var3.headerText or headerText.raw or ""

    local var5 = useStyle()
    local var6 = useTokens()
    local var7 = if tbl1.renderRight then tbl1.renderRight else noOp
    local renderCenter = if tbl1.renderCenter then tbl1.renderCenter else nil

    if renderCenter then
        var7 = nil
    end

    local renderLeft

    if renderCenter then
        renderLeft = nil
    elseif tbl1.renderLeft then
        renderLeft = tbl1.renderLeft
    else
        local backFunc = createBackFunc(
            {
                navigation = navigation,
                navigateToRootStack = navigateToRootStack,
                isRoot = isRoot,
                closeInputBar = closeInputBar
            }
        )
        if backButtonEnabled then
            renderLeft = makeBackButton(backFunc)
        elseif closeButtonEnabled then
            renderLeft = makeCloseButton(backFunc)
        else
            renderLeft = noOp
        end
    end

    local bool1 = not backButtonEnabled and not closeButtonEnabled and renderCenter == nil
    if shouldBoldHeader and renderLeft == noOp then
        renderLeft = nil
    end

    local medium = var6.Padding.Medium
    local new = UDim.new
    local num1 = 0

    if leftPaddingOverride == nil then
        leftPaddingOverride = medium
    end

    local paddingLeft = new(num1, leftPaddingOverride)
    local new2 = UDim.new
    local num2 = 0

    if rightPaddingOverride == nil then
        rightPaddingOverride = medium
    end

    local paddingRight = new2(num2, rightPaddingOverride)

    local var10 = if FFlagAppIaScrollAway and not screenProps and AppNavBar.getScrollAwayEnabled() then VisibilityControl.getHeaderBinding():map(function(num3: number): UDim2
        local yOffset = (num3 - 1) * (barHeight + 36)
        return UDim2.new(0, 0, 0, yOffset)
    end) else nil

    if renderCenter then
        renderLeft = nil
    elseif not (tbl1.renderLeft or navigateToRootStack) then
        renderLeft = not bool1 and renderLeft or nil
    end

    if renderCenter or tbl1.hideTitle then
        var4 = nil
    end

    local var11 = if FFlagAppThemeHalloween2026ChatBackground then ThemeBackground.useThemeBackground() else nil

    if not FFlagAppChatFoundationHeaderBar then
        local createElement = React.createElement
        local view = Foundation.View
        local tbl2 = {
            tag = "size-full-0",
            Size = UDim2.new(1, 0, 0, barHeight),
            LayoutOrder = -1,
            ZIndex = if FFlagAppIaScrollAway then 2 else nil,
            Position = 0
        }

        if not FFlagAppIaScrollAway then
            var10 = nil
        end

        tbl2.Position = var10
        local tbl3 = {
            BackgroundSlot = if var11 then React.createElement(ThemeBackground.ThemeBackgroundHeaderSlot) else nil,
            headerBar = React.createElement(HeaderBar, {
                title = var4,
                barHeight = barHeight,
                renderLeft = renderLeft,
                isSecondary = isSecondary,
                renderCenter = renderCenter,
                renderRight = var7,
                paddingLeft = paddingLeft,
                paddingRight = paddingRight,
                isTitleCentered = not isTitleLeftAligned,
                contentPaddingRight = UDim.new(0, 0),
                backgroundTransparency = if var11 then 1 elseif FFlagAppIaScrollAway and not screenProps then nil else var5.Tokens.Color.None.Transparency
            })
        }
        return createElement(view, tbl2, tbl3)
    end

    local foundationTitle = createFoundationTitle(var4, shouldBoldHeader, isTitleLeftAligned)
    local leftContent = if renderLeft then renderLeft() else nil
    local title = if isTitleLeftAligned then foundationTitle else nil

    if renderCenter then
        foundationTitle = renderCenter()
    elseif isTitleLeftAligned then
        foundationTitle = nil
    end

    local rightContent = if var7 then var7() else nil
    local var15 = var11 == nil and FFlagAppIaScrollAway and not screenProps
    local element = React.createElement(
        HeaderBar2.Root,
        {
            hasBackground = var15 and not FFlagAppChatFoundationHeaderBarPageMarginInset
        },
        {
            Leading = if leftContent or title then React.createElement(HeaderBar2.Leading, nil, { leftContent = leftContent, title = title }) else nil,
            Content = if foundationTitle then React.createElement(HeaderBar2.Content, nil, { centerContent = foundationTitle }) else nil,
            Trailing = if rightContent then React.createElement(HeaderBar2.Trailing, nil, { rightContent = rightContent }) else nil
        }
    )
    local element2

    if FFlagAppChatFoundationHeaderBarPageMarginInset then
        local xOffset = paddingLeft.Offset - medium
        local var16 = paddingRight.Offset - medium
        element2 = React.createElement(
            Foundation.View,
            {
                Position = UDim2.fromOffset(xOffset, 0),
                Size = UDim2.new(1, -(xOffset + var16), 1, 0)
            },
            { headerBar = element }
        )
    else
        element2 = nil
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = FFlagAppChatFoundationHeaderBarPageMarginInset and { ["bg-surface-0"] = var15 } or nil,
        Size = UDim2.new(1, 0, 0, barHeight),
        LayoutOrder = -1,
        ZIndex = if FFlagAppIaScrollAway then 2 else nil,
        Position = 0
    }

    if not FFlagAppIaScrollAway then
        var10 = nil
    end

    tbl2.Position = var10
    local tbl3 = {
        BackgroundSlot = if var11 then React.createElement(ThemeBackground.ThemeBackgroundHeaderSlot) else nil,
        headerBar = 0,
        headerBarInset = 0
    }

    if element2 then
        element = nil
    end

    tbl3.headerBar = element
    tbl3.headerBarInset = element2
    return createElement(view, tbl2, tbl3)
end

return ChatTopBarBase
