-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent
local FFlagFontFaceSocialFriends = require(FriendsLandingParent.SharedFlags).FFlagFontFaceSocialFriends

local dependencies = require(FriendsLanding.dependencies)

local React = dependencies.React
local Dash = dependencies.Dash

local UIBlox = dependencies.UIBlox
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize
local Colors = UIBlox.App.Style.Colors
local useStyle = UIBlox.Core.Style.useStyle
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel

local useLocalization = dependencies.Hooks.useLocalization

local TextKeys = require(FriendsLanding.Common.TextKeys)
local AppFonts = require(FriendsLandingParent.Style).AppFonts
local Foundation = require(FriendsLandingParent.Foundation)
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local FoundationCloudAssets = require(FriendsLandingParent.FoundationCloudAssets)
local Assets = FoundationCloudAssets.Assets
local preloadAsset = FoundationCloudAssets.preloadAsset

local bool1 = game:DefineFastFlag("MigrateNoFriendsViewToFoundation", false)

local tbl1 = {
    layoutOrder = 0,
    pageLoadingTimeReport = nil,
    pageRenderReport = nil,
    openAddFriendsPage = Dash.noop,
    addFriendsBtnLabelKey = TextKeys.ADD_FRIENDS_BTN,
    noFriendsTextLabelKey = TextKeys.NO_FRIENDS_TEXT,
    addFriendsBtnEnabled = true
}

local function loadFoundationCloudAsset(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    preloadAsset(str1)
    local asset = Assets[str1]
    return asset.assetId, asset.size
end

local function NoFriendsView(arg1)
    local var1 = Dash.join(tbl1, arg1 or {})

    local var2 = if bool1 then "pictograms/collaborators" else nil
    local assetId, size

    if bool1 then
        assetId, size = loadFoundationCloudAsset(var2)
    else
        size = nil
        assetId = nil
    end

    local var3 = if bool1 then size / 3 else nil

    React.useEffect(function()
        if var1.pageLoadingTimeReport then
            var1.pageLoadingTimeReport()
        end

        if var1.pageRenderReport then
            var1.pageRenderReport()
        end
    end, {})

    local var4 = useLocalization({
        addFriendsBtn = var1.addFriendsBtnLabelKey,
        noFriendsText = var1.noFriendsTextLabelKey,
        noFriendsHeader = var1.noFriendsHeaderKey
    })

    local var5 = useStyle()
    local var6 = useTokens()
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        LayoutOrder = var1.layoutOrder,
        BackgroundTransparency = 1
    }
    local tbl3 = { IndicatorInner = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }
    local tbl5 = {
        SidePadding = React.createElement("UIPadding", { PaddingRight = UDim.new(0, 30), PaddingLeft = UDim.new(0, 30) }),
        UIList = React.createElement("UIListLayout", {
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0, 15)
        }),
        Imagelabel = 0,
        Headerlabel = 0,
        Textlabel = 0,
        Padding = 0,
        AddFriendsButton = 0
    }
    local element

    if bool1 then
        element = React.createElement(
            Image,
            {
                Image = assetId,
                imageStyle = var6.Color.Content.Emphasis,
                Size = UDim2.fromOffset(var3.X, var3.Y),
                LayoutOrder = 1
            }
        )
    else
        element = React.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Image = Images["icons/graphic/findfriends_xlarge"],
            ImageColor3 = Colors.White,
            LayoutOrder = 1,
            Size = UDim2.fromOffset(96, 96)
        })
    end

    tbl5.Imagelabel = element
    local element2

    if var1.noFriendsHeaderKey and var4.noFriendsHeader then
        element2 = React.createElement(StyledTextLabel, {
            text = var4.noFriendsHeader,
            fontStyle = var5.Font.Header1,
            colorStyle = var5.Theme.TextEmphasis,
            automaticSize = Enum.AutomaticSize.Y,
            size = UDim2.new(1, 0, 0, 0),
            textXAlignment = Enum.TextXAlignment.Center,
            textYAlignment = Enum.TextYAlignment.Center,
            layoutOrder = 2
        })
    else
        element2 = nil
    end

    tbl5.Headerlabel = element2

    tbl5.Textlabel = React.createElement("TextLabel", {
        AutomaticSize = Enum.AutomaticSize.Y,
        TextWrapped = true,
        BackgroundTransparency = 1,
        Font = if FFlagFontFaceSocialFriends then nil else AppFonts.default:getDefault(),
        FontFace = if FFlagFontFaceSocialFriends then normalizeFontFace(var5.Tokens.Typography.BodySmall.Font) else nil,
        LayoutOrder = 3,
        Size = UDim2.new(1, 0, 0, 0),
        Text = var4.noFriendsText,
        TextColor3 = var5.Theme.TextMuted.Color,
        TextSize = var5.Font.Header2.RelativeSize * var5.Font.BaseSize,
        TextTransparency = var5.Theme.TextMuted.Transparency
    })
    tbl5.Padding = React.createElement("Frame", { LayoutOrder = 4, BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 10) })

    tbl5.AddFriendsButton = var1.addFriendsBtnEnabled
        and React.createElement(Button, {
            buttonType = ButtonType.PrimarySystem,
            layoutOrder = 5,
            text = var4.addFriendsBtn,
            standardSize = StandardButtonSize.Regular,
            onActivated = var1.openAddFriendsPage
        })
    tbl3.IndicatorInner = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return NoFriendsView
