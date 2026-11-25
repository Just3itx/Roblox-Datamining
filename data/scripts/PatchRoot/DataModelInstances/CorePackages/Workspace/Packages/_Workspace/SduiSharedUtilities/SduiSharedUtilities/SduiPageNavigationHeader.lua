-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent

local React = require(SduiSharedUtilitiesParent.React)
local Foundation = require(SduiSharedUtilitiesParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local IconButton = Foundation.IconButton
local BuilderIcons = require(SduiSharedUtilitiesParent.BuilderIcons)
local Responsive = require(SduiSharedUtilitiesParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)
local GetDisplayStore = require(SduiSharedUtilitiesParent.Display).GetDisplayStore
local AppHeaderBar = require(SduiSharedUtilitiesParent.AppHeaderBar)

local NavButtonType = require(SduiSharedUtilities.SduiIntegrationTypes).NavButtonType

local useScrollAwayHeaderPosition = require(SduiSharedUtilities.useScrollAwayHeaderPosition)

local function calculateSize(arg1): UDim2
    local displayStore = GetDisplayStore(arg1)
    local guiInset = displayStore.getGuiInset(arg1)
    return UDim2.new(1, 0, 0, displayStore.getTopBarHeight(arg1) - guiInset.top or 0)
end

return React.memo(function(tbl1) -- name: SduiPageNavigationHeader
    local closeCallback = tbl1.closeCallback

    local var1 = useTokens()
    local bool1 = usePreferredInput() == Responsive.Input.Directional
    local var2 = SignalsReact.useSignalBinding(calculateSize)

    local renderNavigation = React.useMemo(function(): (() -> any)?
        return if bool1 or not closeCallback or tbl1.navButtonType ~= NavButtonType.back and tbl1.navButtonType ~= NavButtonType.close then nil else function()
            local createElement = React.createElement
            local str1 = "Frame"
            local tbl2 = {
                Size = UDim2.new(0, var1.Size.Size_1400, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            }

            local tbl3 = {
                UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, -var1.Size.Size_250) }),
                IconButton = React.createElement(IconButton, {
                    SelectionOrder = 10,
                    onActivated = closeCallback,
                    isCircular = true,
                    size = Foundation.Enums.InputSize.Large,
                    icon = {
                        name = if tbl1.navButtonType == NavButtonType.close then BuilderIcons.Icon.X else BuilderIcons.Icon.ChevronLargeLeft,
                        variant = Foundation.Enums.IconVariant.Regular
                    }
                })
            }
            return createElement(str1, tbl2, tbl3)
        end
    end, { bool1, tbl1.navButtonType, closeCallback })

    local tbl2 = {
        AppHeaderBarLayout = React.createElement(
            "UIListLayout",
            {
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Bottom
            }
        ),
        AppHeaderBar = React.createElement(AppHeaderBar.AppHeaderBar, {
            renderNavigation = renderNavigation,
            title = tbl1.title,
            renderUtilities = tbl1.renderUtilities,
            automaticHeight = true,
            paddingLeft = UDim.new(0, 0),
            paddingRight = UDim.new(0, 0),
            isTitleCentered = tbl1.navButtonType ~= NavButtonType.back,
            shouldRenderTitle = true,
            onMedia = false
        })
    }

    local var4 = useScrollAwayHeaderPosition(
        {
            enabled = tbl1.scrollAwayHeader,
            scrollAwayHeight = if tbl1.scrollAwayHeader then var2:getValue().Y.Offset else nil
        }
    )
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        [React.Tag] = tbl1.contentTag,
        Size = var2,
        LayoutOrder = tbl1.layoutOrder or -1,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = if renderNavigation then Enum.AutomaticSize.Y else nil,
        ZIndex = 2,
        ClipsDescendants = false
    }
    local tbl4 = {
        Content = React.createElement("Frame", {
            BackgroundColor3 = var1.Color.Surface.Surface_0.Color3,
            Size = var2,
            Position = var4,
            BorderSizePixel = 0,
            AutomaticSize = if renderNavigation then Enum.AutomaticSize.Y else nil
        }, tbl2)
    }
    return createElement(str1, tbl3, tbl4)
end)
