-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Roact = require(AppChatParent.Roact)
local withLocalization = require(AppChatParent.Localization).withLocalization
local UIBlox = require(AppChatParent.UIBlox)
local withStyle = UIBlox.Style.withStyle
local AppNavBar = require(AppChatParent.AppNavBar)
local VisibilityControl = AppNavBar.VisibilityControl
local HeaderBarTitleLeftAligned = require(AppChat.Components.ChatConversation.HeaderBarTitleLeftAligned)
local SharedFlags = require(AppChatParent.SharedFlags)
local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway
local FFlagEnableHomeRobloxLogo = SharedFlags.FFlagEnableHomeRobloxLogo

local HeaderBar = UIBlox.App.Bar.HeaderBar
local AppHeaderBar = require(AppChatParent.AppHeaderBar)
local Foundation = require(AppChatParent.Foundation)
local React = require(AppChatParent.React)
local FFlagAppChatDomLocatorFoundationMigration = require(AppChat.Flags.FFlagAppChatDomLocatorFoundationMigration)
local createBackFunc = require(AppChat.Components.TopBar.createBackFunc)
local ThemeBackground = require(AppChatParent.ThemeBackground)
local FFlagAppThemeHalloween2026ChatBackground = require(AppChat.Flags.FFlagAppThemeHalloween2026ChatBackground)
local FlyoutSidePanelIXP = require(AppChatParent.SharedExperimentDefinition).FlyoutSidePanelIXP
local FlyoutLeftHeader = if FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() then require(AppChatParent.FlyoutSidePanel).Components.FlyoutLeftHeader else nil

local function noOpt()
    return nil
end

return function(arg1)
    local var1 = if FFlagAppThemeHalloween2026ChatBackground then ThemeBackground.useThemeBackground() else nil
    local screenProps = if FFlagAppIaScrollAway or FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() then arg1.navigation.getScreenProps("isInExperience", false) else nil
    local barHeight = arg1.navigation.getScreenProps("topBarHeight", 0)

    local navigateToRootStack = arg1.navigation.getScreenProps("navigateToRootStack", nil)

    local var2 = arg1.shouldRenderCenter and arg1.renderCenter ~= nil
    local headerText = arg1.headerText or {}
    local makeBackButton = AppHeaderBar.makeBackButton

    local makeCloseButton = AppHeaderBar.makeCloseButton

    local var3 = withLocalization
    local tbl1 = {
        headerText = if headerText.shouldLocalize then headerText.raw or nil else nil
    }

    return var3(tbl1)(function(arg2)
        local str1 = headerText.shouldLocalize and arg2.headerText or headerText.raw
        local var4, var5, renderCenter

        if var2 then
            str1 = ""

            var4 = nil
            var5 = nil
            renderCenter = arg1.renderCenter
        else
            var4 = function()
                return if arg1.renderRight then not arg1.rightHidden and arg1.renderRight() or nil else nil
            end

            renderCenter = nil

            local backFunc = createBackFunc({
                navigation = arg1.navigation,
                navigateToRootStack = navigateToRootStack,
                isRoot = arg1.isRoot,
                closeInputBar = arg1.closeInputBar
            })

            local function func1()
                backFunc()
            end

            if arg1.backButtonEnabled then
                var5 = makeBackButton(func1)
                if FFlagAppChatDomLocatorFoundationMigration and arg1.backButtonTestId then
                    local var6 = var5
                    var5 = function()
                        return React.createElement(Foundation.View, { tag = "auto-xy", testId = arg1.backButtonTestId }, { backButton = var6() })
                    end
                end
            elseif arg1.closeButtonEnabled then
                var5 = makeCloseButton(func1)
            else
                var5 = noOpt
            end
        end

        local bool1 = not (arg1.backButtonEnabled or var2)

        var5 = FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() and not screenProps and bool1 and not arg1.conversationId and function()
            return Roact.createElement(FlyoutLeftHeader, {
                titleText = str1,
                isRobloxLogoEnabled = false,
                isFlyoutEntrypointEnabled = if FFlagEnableHomeRobloxLogo then FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() else nil,
                isAlternateEntryPointEnabled = FlyoutSidePanelIXP.isAlternateEntryPointEnabled()
            })
        end or var5

        if arg1.shouldBoldHeader and var5 == noOpt then
            var5 = nil
        end

        local function func1()
            return Roact.createElement(HeaderBarTitleLeftAligned, {
                renderLeft = if var5 == noOpt then nil else var5,
                renderRight = var4,
                titleText = str1,
                conversationId = arg1.conversationId,
                navigateToChatDetails = arg1.navigateToChatDetails,
                ignoreRightMargin = arg1.rightPaddingOverride ~= nil
            })
        end

        local uDim = UDim.new(0, 12)
        local uDim2 = UDim.new(0, 12)
        if arg1.leftPaddingOverride ~= nil then
            uDim = UDim.new(0, arg1.leftPaddingOverride)
        end
        if arg1.rightPaddingOverride ~= nil then
            uDim2 = UDim.new(0, arg1.rightPaddingOverride)
        end

        local var6 = if FFlagAppIaScrollAway and not screenProps and AppNavBar.getScrollAwayEnabled() then VisibilityControl.getHeaderBinding():map(function(num1: number): UDim2
            local yOffset = (num1 - 1) * (barHeight + 36)
            return UDim2.new(0, 0, 0, yOffset)
        end) else nil

        local var7 = FlyoutSidePanelIXP.isFlyoutSidePanelEnabled() and not screenProps and bool1

        if navigateToRootStack then
            local createElement = Roact.createElement
            local str2 = "Frame"
            local tbl2 = {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, barHeight),
                LayoutOrder = -1,
                ZIndex = if FFlagAppIaScrollAway then 2 else nil,
                Position = 0
            }

            if not FFlagAppIaScrollAway then
                var6 = nil
            end

            tbl2.Position = var6
            local tbl3 = {
                BackgroundSlot = if var1 then Roact.createElement(ThemeBackground.ThemeBackgroundHeaderSlot) else nil,
                headerBar = withStyle(function(arg3)
                    return Roact.createElement(HeaderBar, {
                        title = if arg1.conversationId or var7 then nil else str1,
                        barHeight = barHeight,
                        renderLeft = if arg1.conversationId then nil else var5,
                        isSecondary = arg1.isSecondary,
                        renderCenter = if arg1.conversationId then func1 else renderCenter,
                        renderRight = if arg1.conversationId then nil else var4,
                        paddingLeft = uDim,
                        paddingRight = uDim2,
                        isTitleCentered = not arg1.isTitleLeftAligned,
                        contentPaddingRight = UDim.new(0, 0),
                        backgroundTransparency = if var1 then 1 elseif FFlagAppIaScrollAway and not (screenProps or arg1.isDialog) then nil else arg3.Tokens.Color.None.Transparency
                    })
                end)
            }

            return createElement(str2, tbl2, tbl3)
        end

        local createElement = Roact.createElement
        local str2 = "Frame"
        local tbl2 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, barHeight),
            LayoutOrder = -1,
            ZIndex = if FFlagAppIaScrollAway then 2 else nil,
            Position = 0
        }

        if not FFlagAppIaScrollAway then
            var6 = nil
        end

        tbl2.Position = var6
        local tbl3 = {
            BackgroundSlot = if var1 then Roact.createElement(ThemeBackground.ThemeBackgroundHeaderSlot) else nil,
            headerBar = withStyle(function(arg3)
                return Roact.createElement(HeaderBar, {
                    title = if arg1.conversationId or var7 then nil else str1,
                    barHeight = barHeight,
                    renderLeft = if arg1.conversationId or bool1 then nil else var5 or nil,
                    isSecondary = arg1.isSecondary,
                    renderCenter = if arg1.conversationId then func1 else renderCenter,
                    renderRight = if arg1.conversationId then nil else var4,
                    paddingLeft = uDim,
                    paddingRight = uDim2,
                    isTitleCentered = not arg1.isTitleLeftAligned,
                    contentPaddingRight = UDim.new(0, 0),
                    backgroundTransparency = if var1 then 1 elseif FFlagAppIaScrollAway and not (screenProps or arg1.isDialog) then nil else arg3.Tokens.Color.None.Transparency
                })
            end)
        }

        return createElement(str2, tbl2, tbl3)
    end)
end
