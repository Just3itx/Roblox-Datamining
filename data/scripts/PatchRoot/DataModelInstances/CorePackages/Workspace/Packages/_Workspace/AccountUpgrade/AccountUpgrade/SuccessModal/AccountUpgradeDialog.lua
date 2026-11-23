-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgrade = script:FindFirstAncestor("AccountUpgrade")
local AccountUpgradeParent = AccountUpgrade.Parent

local React = require(AccountUpgradeParent.React)

local FocusNavigationUtils = require(AccountUpgradeParent.FocusNavigationUtils)
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local Foundation = require(AccountUpgradeParent.Foundation)
local Dialog = Foundation.Dialog
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local DialogSize = Foundation.Enums.DialogSize
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local FFlagAccountUpgradeOAuthDialogFitsContent = require(AccountUpgrade.Flags.FFlagAccountUpgradeOAuthDialogFitsContent)

local function useFitHeights(bool1: boolean)
    local var1 = Foundation.Hooks.useOverlay()
    local overlayHeight, var3 = React.useBinding(math.huge)
    local headerHeight, setHeaderHeight = React.useBinding(0)
    local contentHeight, setContentHeight = React.useBinding(0)
    React.useEffect(function()
        if not bool1 or var1 == nil then
            return
        end

        local var8 = var1
        local function updateOverlayHeight() -- Luacid: Inlined by compiler; 1 call site recovered
            var3(var8.AbsoluteSize.Y)
        end

        updateOverlayHeight()
        local connection = var8:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateOverlayHeight)
        return function()
            connection:Disconnect()
        end
    end, { bool1, var1 })

    return {
        overlayHeight = overlayHeight,
        headerHeight = headerHeight,
        setHeaderHeight = setHeaderHeight,
        contentHeight = contentHeight,
        setContentHeight = setContentHeight
    }
end

local function AccountUpgradeDialog(tbl1)
    local var1 = Foundation.Hooks.useTokens()
    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isFocusable = tbl1.isFocusable,
        isAutoFocusRoot = true
    })

    local testId = tbl1.testId or "account-upgrade-dialog"
    local var3 = FFlagAccountUpgradeOAuthDialogFitsContent and tbl1.fitsContent == true
    local var4 = if FFlagAccountUpgradeOAuthDialogFitsContent then useFitHeights(var3) else nil
    local element = nil
    if tbl1.title and var3 then
        element = React.createElement(View, {
            tag = "size-full-0 auto-y",
            padding = {
                top = UDim.new(0, var1.Size.Size_500),
                right = UDim.new(0, var1.Size.Size_400 + var1.Size.Size_1000)
            },
            LayoutOrder = 1,
            testId = `{testId}--title`
        }, {
            Title = React.createElement(
                FoundationText,
                {
                    Text = tbl1.title,
                    tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-left content-emphasis"
                }
            )
        })
    elseif tbl1.title then
        element = React.createElement(Dialog.Title, { text = tbl1.title })
    end

    if tbl1.subtitle then
        element = React.createElement(
            View,
            {
                tag = "col gap-xsmall size-full-0 auto-y",
                LayoutOrder = 1,
                testId = `{testId}--header`
            },
            {
                Title = element,
                Subtitle = React.createElement(FoundationText, {
                    Text = tbl1.subtitle,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
                    LayoutOrder = 2,
                    testId = `{testId}--subtitle`
                })
            }
        )
    end
    if tbl1.onCloseActivated then
        local xLarge = var1.Padding.XLarge
        local size400 = var1.Size.Size_400

        element = React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = 1 }, {
            Title = element,
            CloseButtonAnchor = React.createElement(
                "Frame",
                {
                    Size = UDim2.fromScale(1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = -2147483648
                },
                {
                    CloseButton = React.createElement(
                        View,
                        {
                            tag = "row align-x-center align-y-center anchor-top-right clip",
                            Size = UDim2.fromOffset(var1.Size.Size_1000, var1.Size.Size_1000),
                            padding = UDim.new(0, var1.Size.Size_200),
                            cornerRadius = UDim.new(0, var1.Radius.Medium),
                            cursor = {
                                radius = UDim.new(0, var1.Radius.Medium),
                                offset = var1.Size.Size_150,
                                borderWidth = var1.Stroke.Thicker
                            },
                            onActivated = tbl1.onCloseActivated,
                            Position = UDim2.new(1, xLarge - size400, 0, size400),
                            testId = `{testId}--close-button`
                        },
                        {
                            Icon = React.createElement(Icon, { name = IconName.X, size = IconSize.Large, style = var1.Color.Content.Emphasis })
                        }
                    )
                }
            )
        })
    end

    local element2

    if var3 and var4 then
        local setHeaderHeight = var4.setHeaderHeight
        local setContentHeight = var4.setContentHeight
        element = element and React.createElement(View, {
            tag = "col size-full-0 auto-y",
            LayoutOrder = 1,
            onAbsoluteSizeChanged = function(arg1)
                setHeaderHeight(arg1.AbsoluteSize.Y)
            end
        }, { Header = element })

        local var5 = React.joinBindings({ var4.overlayHeight, var4.headerHeight, var4.contentHeight }):map(function(arg1)
            local var5 = arg1[2]
            local var6 = var1.Padding.XLarge * 3 + var5 + (if var5 > 0 then var1.Gap.XLarge else 0)
            return UDim2.new(1, 0, 0, math.min(math.ceil(arg1[3]), math.max(0, arg1[1] - var6)))
        end)

        local createElement = React.createElement
        local var6 = View
        local tbl2 = {
            tag = "size-full-0 auto-y",
            LayoutOrder = 2,
            testId = `{testId}--content`
        }
        local tbl3 = { ScrollingFrame = 0 }
        local createElement2 = React.createElement
        local tbl4 = {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            CanvasSize = UDim2.new(),
            Size = var5,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
            ScrollBarThickness = var1.Size.Size_150,
            ScrollBarImageColor3 = var1.Color.Shift.Shift_400.Color3,
            ScrollBarImageTransparency = var1.Color.Shift.Shift_400.Transparency,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Selectable = false
        }

        local tbl5 = { Layout = 0, Children = 0 }

        local createElement3 = React.createElement
        local tbl6 = {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            SortOrder = Enum.SortOrder.LayoutOrder
        }

        tbl6[React.Change.AbsoluteContentSize] = function(arg1)
            setContentHeight(arg1.AbsoluteContentSize.Y)
        end

        tbl5.Layout = createElement3("UIListLayout", tbl6)

        tbl5.Children = React.createElement(React.Fragment, nil, tbl1.children)
        tbl3.ScrollingFrame = createElement2("ScrollingFrame", tbl4, tbl5)
        element2 = createElement(var6, tbl2, tbl3)
    else
        element2 = React.createElement(Dialog.Content, { LayoutOrder = 2 }, tbl1.children)
    end

    return React.createElement(Dialog.Root, {
        ref = ref,
        size = DialogSize.Medium,
        disablePortal = false,
        hasBackdrop = tbl1.hasBackdrop,
        onClose = if tbl1.onCloseActivated then nil else tbl1.onClose,
        testId = testId
    }, {
        Title = element,
        Content = element2,
        Actions = tbl1.actions
    })
end

return AccountUpgradeDialog
