-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local useLocalization = require(InExperienceShopParent.Localization).Hooks.useLocalization

local tbl1 = {
    searchPlaceholder = "Feature.Catalog.Label.Search",
    clear = "Feature.Avatar.Action.Clear"
}

local function SearchInputView(tbl2)
    local var1 = useTokens()
    local var2 = useLocalization(tbl1)
    local fontFace = normalizeFontFace(var1.Typography.BodyMedium.Font)
    local fontSize = var1.Typography.BodyMedium.FontSize

    local createElement = React.createElement
    local view = Foundation.View

    local tbl3 = {
        BackButton = React.createElement(Foundation.IconButton, {
            icon = Foundation.Enums.IconName.ChevronLargeLeft,
            variant = Foundation.Enums.ButtonVariant.Utility,
            size = Foundation.Enums.ButtonSize.Small,
            onActivated = tbl2.onBack,
            LayoutOrder = 0
        }),
        SearchField = 0,
        ClearButton = 0
    }

    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = "fill radius-medium bg-surface-200",
        Size = UDim2.fromOffset(0, 36),
        LayoutOrder = 1
    }
    local tbl5 = {
        SearchIcon = React.createElement(Foundation.Icon, {
            name = Foundation.Enums.IconName.MagnifyingGlass,
            size = Foundation.Enums.IconSize.Small,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 12, 0.5, 0)
        }),
        TextBox = React.createElement("TextBox", {
            ref = tbl2.textBoxRef,
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ClearTextOnFocus = false,
            ClipsDescendants = true,
            FontFace = fontFace,
            PlaceholderText = var2.searchPlaceholder,
            PlaceholderColor3 = var1.Color.Content.Default.Color3,
            Position = UDim2.new(0, 40, 0.5, 0),
            Size = UDim2.new(1, -40, 1, 0),
            Text = tbl2.text,
            TextColor3 = var1.Color.Content.Emphasis.Color3,
            TextSize = fontSize,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = false,
            [React.Change.Text] = tbl2.onTextChanged,
            [React.Event.FocusLost] = tbl2.onFocusLost
        })
    }
    tbl3.SearchField = createElement2(view2, tbl4, tbl5)

    tbl3.ClearButton = React.createElement(Foundation.Button, {
        text = var2.clear,
        variant = Foundation.Enums.ButtonVariant.Utility,
        size = Foundation.Enums.InputSize.XSmall,
        onActivated = tbl2.onClear,
        LayoutOrder = 2
    })
    return createElement(
        view,
        {
            tag = "row align-y-center gap-small size-full-0 auto-y padding-x-xlarge radius-medium",
            testId = "SearchInputView"
        },
        tbl3
    )
end

return SearchInputView
