-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent

local CallbackInputBox = require(SocialCommonParent.LuaSocialLibrariesDeps).SocialLibraries.config({}).Components.CallbackInputBox

local React = require(SocialCommonParent.React)
local RoactAppExperiment = require(SocialCommonParent.RoactAppExperiment)
local Dash = require(SocialCommonParent.Dash)
local UIBlox = require(SocialCommonParent.UIBlox)
local IconSize = UIBlox.App.Constant.IconSize

local TextButton = UIBlox.App.Button.TextButton
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local useStyle = UIBlox.Core.Style.useStyle

local Foundation = require(SocialCommonParent.Foundation)

local FFlagAppThemeHalloween2026FriendsBackground = require(SocialCommonParent.SharedFlags).FFlagAppThemeHalloween2026FriendsBackground
local useThemeBackground = require(SocialCommonParent.ThemeBackground).useThemeBackground
local Icon = Foundation.Icon
local Enums = Foundation.Enums
local GetTextSize = require(SocialCommonParent.Style).GetTextSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local iconsActionsEditClear_small = Images["icons/actions/edit/clear_small"]

local FFlagDisableAutocorrectSocialUserSearch = require(SocialCommonParent.SharedFlags).FFlagDisableAutocorrectSocialUserSearch
local FFlagLuaAppLogSocialUserSearchUXExposure = require(SocialCommonParent.SharedFlags).FFlagLuaAppLogSocialUserSearchUXExposure

local str1 = game:DefineFastString("DisableAutocorrectExperimentLayer", "Social.UserSearchUX")

local tbl1 = {
    cancelText = "Cancel",
    searchPlaceholderText = "Text",
    initialInputText = nil,
    LayoutOrder = 1,
    isDisabled = false,
    captureFocusOnMount = false,
    cancelCallback = nil,
    textChangedCallback = nil,
    focusChangedCallback = function() end
}

return function(arg1)
    local var1 = if FFlagDisableAutocorrectSocialUserSearch then RoactAppExperiment.useUserExperiment({ str1 }, function(arg2)
        return (arg2[str1] or {}).disableAutocorrectSocialUserSearch
    end, not FFlagLuaAppLogSocialUserSearchUXExposure) else nil

    local var2 = Dash.join(tbl1, arg1 or {})
    local var3 = useStyle()
    local bool1 = if FFlagAppThemeHalloween2026FriendsBackground then useThemeBackground() ~= nil else false
    local inputBoxRef = React.useRef(nil)
    local var5, var6 = React.useState(nil)
    local var7, var8 = React.useState(nil)

    React.useEffect(function()
        if var2.onSelectCallback then
            var2.onSelectCallback()
        end
        if var2.resetOnMount then
            var2.resetOnMount()
        end
    end, {})

    local header2 = var3.Font.Header2
    local var9 = var3.Font.BaseSize * header2.RelativeSize
    local textSizeX = GetTextSize(var2.cancelText, var9, var3.Tokens.Typography.TitleLarge.Font, Vector2.new(10000, 10000)).X

    local uDim = UDim.new(0, 4)
    local uDim2 = if var2.isDisabled then UDim2.new(1, 0, 1, 0) else UDim2.new(1, -textSizeX - 12, 1, 0)
    local body = var3.Font.Body
    local var10 = var3.Font.BaseSize * body.RelativeSize

    local function focusChangedCallback(arg2, arg3)
        if var2.focusChangedCallback then
            var2.focusChangedCallback(arg2, arg3)
        end
        if arg2 then
            var6(var3.Theme.SecondaryOnHover.Color)
            var8(var3.Theme.SecondaryOnHover.Transparency)
            return
        end
        var6(var3.Theme.Divider.Color)
        var8(var3.Theme.Divider.Transparency)
    end

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl2 = {
        BackgroundTransparency = if bool1 then 1 else var3.Theme.BackgroundDefault.Transparency,
        BackgroundColor3 = var3.Theme.BackgroundDefault.Color,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        LayoutOrder = var2.LayoutOrder
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = uDim
        }),
        Padding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6) }),
        CancelTextButton = if var2.isDisabled then nil else var2.cancelCallback
            and React.createElement(TextButton, { text = var2.cancelText, layoutOrder = 2, onActivated = var2.cancelCallback }),
        FilterBoxBackground = 0
    }

    local createElement2 = React.createElement
    local var11 = ImageSetLabel
    local tbl4 = {
        Size = uDim2,
        BackgroundColor3 = var3.Theme.UIMuted.Color,
        BackgroundTransparency = var3.Theme.UIMuted.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = 1
    }

    local tbl5 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
        UIStroke = React.createElement(
            "UIStroke",
            {
                Color = var5 or var3.Theme.Divider.Color,
                Transparency = var7 or var3.Theme.Divider.Transparency,
                Thickness = 1
            }
        ),
        UIListLayout = React.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 4)
        }),
        UIPadding = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }),
        SearchIcon = React.createElement(Icon, { name = Enums.IconName.MagnifyingGlass, size = Enums.IconSize.Medium }),
        FilterBoxContainer = 0
    }
    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl6 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -28, 1, 0),
        LayoutOrder = 2
    }
    local tbl7 = { filterBox = 0 }
    local element

    if var2.isDisabled then
        element = React.createElement("TextLabel", {
            Text = var2.searchPlaceholderText,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            TextSize = var10,
            FontFace = normalizeFontFace(var3.Tokens.Typography.BodyLarge.Font),
            TextColor3 = var3.Theme.TextDefault.Color,
            TextTransparency = var3.Theme.TextMuted.Transparency
        })
    else
        element = React.createElement(CallbackInputBox, {
            initialInputText = var2.initialInputText,
            inputTextColor3 = var3.Theme.TextEmphasis.Color,
            inputTextFont = body.Font,
            inputTextSize = var10,
            inputTextTransparency = var3.Theme.TextEmphasis.Transparency,
            inputTextXAlignment = Enum.TextXAlignment.Left,
            textInputType = if FFlagDisableAutocorrectSocialUserSearch and var1 then Enum.TextInputType.NoSuggestions else nil,
            returnKeyType = if FFlagDisableAutocorrectSocialUserSearch and var1 then Enum.ReturnKeyType.Search else nil,
            placeholderText = var2.searchPlaceholderText,
            placeholderTextColor3 = var3.Theme.TextDefault.Color,
            placeholderTextTransparency = var3.Theme.TextMuted.Transparency,
            captureFocusOnMount = var2.captureFocusOnMount,
            clearButtonDisabled = false,
            clearIcon = iconsActionsEditClear_small,
            clearIconColor3 = var3.Theme.IconEmphasis.Color,
            clearIconTransparency = var3.Theme.IconEmphasis.Transparency,
            clearButtonSize = IconSize.Small,
            textChangedCallback = var2.textChangedCallback,
            onSelectCallback = var2.onSelectCallback,
            focusChangedCallback = focusChangedCallback,
            returnPressedFromOnScreenKeyboardCallback = var2.returnPressedFromOnScreenKeyboardCallback,
            inputBoxRef = inputBoxRef
        })
    end

    tbl7.filterBox = element
    tbl5.FilterBoxContainer = createElement3(str3, tbl6, tbl7)
    tbl3.FilterBoxBackground = createElement2(var11, tbl4, tbl5)
    return createElement(str2, tbl2, tbl3)
end
