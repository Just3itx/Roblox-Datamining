-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)
local FocusNavigationUtils = require(GiftingParent.FocusNavigationUtils)
local InputHandlers = require(GiftingParent.InputHandlers)
local _ReactFocusNavigation = require(GiftingParent.ReactFocusNavigation)

local IconButton = Foundation.IconButton
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View
local DialogSize = Foundation.Enums.DialogSize
local IconName = Foundation.Enums.IconName
local useTextSize = Foundation.Hooks.useTextSize
local useTextSizeOffset = Foundation.Hooks.useTextSizeOffset
local useTokens = Foundation.Hooks.useTokens
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local function useFooterLayout(captionText: string?)
    local var1 = useTokens()
    local var2 = useTextSizeOffset()
    local captionSmall = var1.Typography.CaptionSmall

    local x, var3 = React.useState(0)
    local var4 = React.useCallback(function(arg1)
        local num1 = math.floor(arg1.AbsoluteSize.X)
        var3(function(num2: number): number
            return if num2 == num1 then num2 else num1
        end)
    end, {})

    local var5 = useTextSize(
        if x > 0 then captionText else nil,
        {
            Font = captionSmall.Font,
            FontSize = captionSmall.FontSize + var2
        },
        Vector2.new(x, math.huge)
    )

    local captionHeight = React.useMemo(function()
        if captionText == nil or x <= 0 then
            return 0
        end

        return captionSmall.LineHeight * (if var5 then var5.Y else captionSmall.FontSize + var2)
    end, {
        captionText,
        x,
        captionSmall,
        var2,
        var5
    })
    local tbl1 = {
        topInset = var1.Padding.Medium - var1.Margin.Small,
        captionHeight = captionHeight,
        onAbsoluteSizeChanged = 0
    }

    if not captionText then
        var4 = nil
    end

    tbl1.onAbsoluteSizeChanged = var4
    return tbl1
end

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function useSheetFocusRoot(tbl2)
    local var1 = tbl2.onBack or tbl2.onClose
    local eventHandlers = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                arg1:cancel()
                var1()
            end)
        }
        return result
    end, { var1 })

    return useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        eventMap = eventMap,
        eventHandlers = eventHandlers,
        isAutoFocusRoot = true,
        isFocusable = tbl2.isOpen
    })
end

return React.memo(function(tbl2) -- name: GiftSheetLayoutView
    local bool1 = tbl2.actions ~= nil or tbl2.captionText ~= nil
    local tbl3 = useFooterLayout(tbl2.captionText)
    local ref = useSheetFocusRoot(tbl2)

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl4 = {
        ref = ref,
        isOpen = tbl2.isOpen,
        preferCenterSheet = true,
        size = DialogSize.Medium,
        centerSheetHeight = tbl2.centerSheetHeight,
        snapPoints = tbl2.snapPoints,
        onClose = tbl2.onClose,
        testId = "GiftSheetLayoutView"
    }
    local tbl5 = {
        Header = React.createElement(Sheet.Header, {}, {
            Back = if tbl2.onBack then React.createElement(
                IconButton,
                {
                    icon = IconName.ChevronLargeLeft,
                    onActivated = tbl2.onBack,
                    testId = "gift-sheet-layout-back",
                    LayoutOrder = 1
                }
            ) else nil,
            Title = React.createElement(FoundationText, {
                tag = "fill auto-y text-heading-small text-align-x-left content-emphasis",
                Text = tbl2.titleText,
                testId = "gift-sheet-layout-title",
                LayoutOrder = 2
            })
        }),
        Content = React.createElement(Sheet.Content, { testId = "gift-sheet-layout-content" }, {
            Body = React.createElement(View, {
                tag = "col gap-medium size-full-0 auto-y padding-bottom-xsmall padding-top-xxsmall",
                testId = "gift-sheet-layout-body"
            }, {
                Main = React.createElement(
                    View,
                    {
                        tag = "col size-full-0 auto-y",
                        testId = "gift-sheet-layout-main",
                        LayoutOrder = 1
                    },
                    tbl2.content
                )
            })
        }),
        Actions = 0
    }
    local var2

    if bool1 then
        local createElement2 = React.createElement
        local actions = Sheet.Actions
        local tbl6 = {}
        local tbl7 = {
            Footer = React.createElement(View, {
                tag = "col gap-medium size-full-0 auto-y",
                padding = {
                    top = UDim.new(0, tbl3.topInset)
                },
                testId = "gift-sheet-layout-footer",
                onAbsoluteSizeChanged = tbl3.onAbsoluteSizeChanged
            }, {
                Actions = if tbl2.actions then React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = 1 }, tbl2.actions) else nil,
                Caption = if tbl2.captionText then React.createElement(FoundationText, {
                    Size = UDim2.new(1, 0, 0, tbl3.captionHeight),
                    tag = "text-caption-small text-wrap text-align-x-left text-align-y-top content-muted",
                    Text = tbl2.captionText,
                    testId = "gift-sheet-layout-caption",
                    LayoutOrder = 2
                }) else nil
            })
        }
        var2 = createElement2(actions, tbl6, tbl7)
    else
        var2 = nil
    end

    tbl5.Actions = var2
    return createElement(root, tbl4, tbl5)
end)
