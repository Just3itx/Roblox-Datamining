-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent

local React = require(FriendsMenuParent.React)
local UIBlox = require(FriendsMenuParent.UIBlox)
local LocalizationHelper = require(FriendsMenuParent.NotificationsCommon).LocalizationHelper
local Debounce = require(FriendsMenuParent.NotificationsCommon).Debounce
local SharedFlags = require(FriendsMenuParent.SharedFlags)
local Foundation = require(FriendsMenuParent.Foundation)
local useCursor = Foundation.Hooks.useCursor
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local GetFFlagEnableFriendsListSearchNormalizationErrorFix = SharedFlags.GetFFlagEnableFriendsListSearchNormalizationErrorFix

local useStyle = UIBlox.Core.Style.useStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local Images = UIBlox.App.ImageSet.Images
local getLocalizedStrings = LocalizationHelper.getLocalizedStrings

local FriendsListContext = require(FriendsMenu.Context.FriendsListContext)

local iconsMenuSearch = Images["icons/menu/search"]
local iconsActionsEditClear = Images["icons/actions/edit/clear"]
local Size_200 = 8
local Size_150 = 6
local Size_400 = 18
local Size_100 = 4
local Size_600 = 24
local FontSize_300 = 16
local num1 = Size_400 + Size_600 + Size_100
local Small = 4

local tbl1 = {
    searchPlaceHolder = "Feature.SettingsHub.Label.SearchForFriendsPlaceholder.FriendsRename"
}

return (React.memo(React.forwardRef(function(tbl2, arg1)
    local var1 = useStyle()
    local var2 = useTokens()
    local var3 = React.useContext(FriendsListContext)
    local localizedStrings = getLocalizedStrings(tbl1)
    local var4 = React.useRef(nil)

    if var2 then
        Size_200 = var2.Size.Size_200
        Size_150 = var2.Size.Size_150
        Size_400 = var2.Size.Size_400
        Size_600 = var2.Size.Size_600
        Size_100 = var2.Size.Size_100
        FontSize_300 = var2.FontSize.FontSize_300
        Small = var2.Radius.Small
        num1 = Size_400 + Size_600 + Size_100
    end

    local selectionImageObject = useCursor(Foundation.Enums.CursorType.RoundedRect)

    var4 = arg1 or var4

    local searchFriendsString = var3.searchFriendsString
    local searchFriends = var3.searchFriends
    local bool1 = #searchFriendsString > 0

    local var6 = not GetFFlagEnableFriendsListSearchNormalizationErrorFix() and function(tbl3)
        searchFriends(tbl3.Text)
    end or React.useCallback(Debounce(function(tbl3)
        searchFriends(tbl3.Text:lower())
    end, 0.5), { searchFriends })

    React.useEffect(function()
        if var4.current and tbl2.focusElement then
            var4.current:CaptureFocus()
        end
    end, { var4.current })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Size = tbl2.size,
        LayoutOrder = tbl2.layoutOrder
    }
    local tbl4 = {
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, Size_100)
        }),
        UIStroke = React.createElement(
            "UIStroke",
            {
                Thickness = 1,
                Color = var1.Theme.UIDefault.Color,
                Transparency = var1.Theme.UIDefault.Transparency
            }
        ),
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, Small) }),
        UIPadding = React.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, Size_200),
            PaddingRight = UDim.new(0, Size_200),
            PaddingTop = UDim.new(0, Size_150),
            PaddingBottom = UDim.new(0, Size_150)
        }),
        SearchIcon = React.createElement(ImageSetLabel, {
            LayoutOrder = 0,
            Size = UDim2.fromOffset(Size_400, Size_400),
            BackgroundTransparency = 1,
            Image = iconsMenuSearch,
            ImageColor3 = var1.Theme.IconEmphasis.Color,
            ImageTransparency = var1.Theme.IconEmphasis.Transparency
        }),
        SearchField = React.createElement("TextBox", {
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, num1 * -1, 1, 0),
            ClearTextOnFocus = false,
            PlaceholderColor3 = var1.Theme.TextDefault.Color,
            PlaceholderText = localizedStrings.searchPlaceHolder,
            Text = searchFriendsString,
            TextColor3 = var1.Theme.TextDefault.Color,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextSize = FontSize_300,
            FontFace = normalizeFontFace(var2.Typography.BodyLarge.Font),
            ref = var4,
            [React.Event.Focused] = tbl2.onFocus,
            [React.Change.Text] = var6,
            SelectionImageObject = selectionImageObject
        }),
        ClearButton = 0
    }
    local var7

    if bool1 then
        local createElement2 = React.createElement
        local var8 = ImageSetButton
        local tbl5 = {
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Size = UDim2.new(0, Size_600, 0, Size_600),
            Image = iconsActionsEditClear,
            ImageColor3 = var1.Theme.IconEmphasis.Color,
            ImageTransparency = var1.Theme.IconEmphasis.Transparency
        }

        tbl5[React.Event.Activated] = function()
            searchFriends("")
        end
        tbl5.SelectionImageObject = selectionImageObject
        var7 = createElement2(var8, tbl5) or nil
    else
        var7 = nil
    end

    tbl4.ClearButton = var7
    return createElement(str1, tbl3, tbl4)
end)))
