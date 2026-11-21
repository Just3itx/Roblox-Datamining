-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent

local React = require(GameCollectionsParent.React)
local UIBlox = require(GameCollectionsParent.UIBlox)
local Foundation = require(GameCollectionsParent.Foundation)
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local Images = UIBlox.App.ImageSet.Images
local useCursor = UIBlox.App.SelectionCursor.useCursor
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useLocalization = require(GameCollectionsParent.Localization).Hooks.useLocalization
local useDesignTokens = require(GameCollectionsParent.Style).useDesignTokens
local useTokens = Foundation.Hooks.useTokens
local FFlagSduiComponentsUseFoundationTokens = require(GameCollectionsParent.SharedFlags).FFlagSduiComponentsUseFoundationTokens

local iconsNavigationPushRight = Images["icons/navigation/pushRight"]

function SeeAllTile(tbl1)
    local size = tbl1.size
    local layoutOrder = tbl1.layoutOrder
    local var1 = if FFlagSduiComponentsUseFoundationTokens then useTokens() else useDesignTokens()
    local var2 = useLocalization({ seeAll = "Feature.Home.ActionSeeAll" })

    local uDim = UDim.new(0, var1.Size.Size_200)

    local selectionImageObject = useCursor(uDim)

    local titleLarge = var1.Typography.TitleLarge
    local color3 = var1.Color.Content.Emphasis.Color3
    local color3_2 = var1.Color.Content.Emphasis.Color3
    local emphasisTransparency = var1.Color.Content.Emphasis.Transparency

    local var4 = tbl1.title or var2.seeAll
    local image = tbl1.icon or iconsNavigationPushRight
    local size900 = var1.Size.Size_900

    return React.createElement("TextButton", {
        AutoButtonColor = false,
        Text = "",
        Size = size,
        LayoutOrder = layoutOrder,
        BackgroundTransparency = var1.Color.Surface.Surface_300.Transparency,
        BackgroundColor3 = var1.Color.Surface.Surface_300.Color3,
        [React.Event.Activated] = tbl1.onActivated,
        SelectionImageObject = selectionImageObject
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = uDim }),
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var1.Size.Size_100)
        }),
        Icon = React.createElement(ImageSetLabel, {
            Size = UDim2.fromOffset(size900, size900),
            BackgroundTransparency = 1,
            Image = image,
            ImageColor3 = color3_2,
            ImageTransparency = emphasisTransparency,
            LayoutOrder = 1
        }),
        Title = React.createElement("TextLabel", {
            Text = var4,
            Size = UDim2.new(1, 0, 0, titleLarge.FontSize),
            TextXAlignment = Enum.TextXAlignment.Center,
            LayoutOrder = 2,
            FontFace = normalizeFontFace(titleLarge.Font),
            TextSize = titleLarge.FontSize,
            TextColor3 = color3,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1
        })
    })
end

return SeeAllTile
