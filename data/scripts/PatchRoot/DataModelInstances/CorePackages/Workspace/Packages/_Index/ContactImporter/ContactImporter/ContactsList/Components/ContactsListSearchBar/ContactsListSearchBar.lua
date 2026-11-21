-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local dependencies = require(ContactImporter.dependencies)

local Roact = dependencies.Roact
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local SocialLibraries = dependencies.SocialLibraries

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local CallbackInputBox = SocialLibraries.Components.CallbackInputBox
local Images = UIBlox.App.ImageSet.Images
local TextKeys = require(ContactImporter.Common.TextKeys)
local useStyle = dependencies.useStyle

local useLocalization = dependencies.useLocalization

local iconsCommonSearch = Images["icons/common/search"]
local iconsActionsEditClear_small = Images["icons/actions/edit/clear_small"]

function ContactsListSearchBar(tbl1)
    local var1 = useLocalization({ searchContacts = TextKeys.SEARCH_CONTACTS })

    local var2 = useStyle()

    local var3, focusChangedCallback = React.useState(false)

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = var2.Theme.BackgroundMuted.Transparency,
        BorderSizePixel = 0,
        BackgroundColor3 = var2.Theme.BackgroundMuted.Color,
        Size = UDim2.new(1, 0, 0, tbl1.height),
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        layout = Roact.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4)
        }),
        BorderRadius = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
        Border = React.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = if var3 then var2.Theme.SecondaryOnHover.Color else var2.Theme.Divider.Color,
            Transparency = if var3 then var2.Theme.SecondaryOnHover.Transparency else var2.Theme.Divider.Transparency,
            Thickness = 1
        }),
        padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 13), PaddingRight = UDim.new(0, 13) }),
        icon = Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, IconSize.Small, 0, IconSize.Small),
            Image = iconsCommonSearch,
            ImageColor3 = var2.Theme.IconEmphasis.Color,
            LayoutOrder = 1
        }),
        searchBarWrapper = Roact.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Size = UDim2.new(1, -IconSize.Small, 0, tbl1.height)
            },
            {
                searchBar = Roact.createElement(CallbackInputBox, {
                    clearIcon = iconsActionsEditClear_small,
                    clearIconColor3 = var2.Theme.IconEmphasis.Color,
                    clearIconTransparency = var2.Theme.IconEmphasis.Transparency,
                    clearButtonSize = IconSize.Small,
                    clearButtonDisabled = false,
                    focusChangedCallback = focusChangedCallback,
                    inputTextColor3 = var2.Theme.TextEmphasis.Color,
                    inputTextTransparency = var2.Theme.TextEmphasis.Transparency,
                    placeholderText = var1.searchContacts,
                    placeholderTextColor3 = var2.Theme.TextMuted.Color,
                    placeholderTextTransparency = var2.Theme.TextMuted.Transparency,
                    inputTextXAlignment = Enum.TextXAlignment.Left,
                    textChangedCallback = tbl1.textChangeCallback
                })
            }
        )
    }
    return createElement(str1, tbl2, tbl3)
end

return ContactsListSearchBar
