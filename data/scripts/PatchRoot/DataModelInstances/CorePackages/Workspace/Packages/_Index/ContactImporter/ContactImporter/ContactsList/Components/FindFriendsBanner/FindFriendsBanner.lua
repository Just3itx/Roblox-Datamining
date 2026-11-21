-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContactImporter = script:FindFirstAncestor("ContactImporter")
local dependencies = require(ContactImporter.dependencies)
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local useLocalization = dependencies.useLocalization
local useStyle = dependencies.useStyle
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local IconSize = UIBlox.App.Constant.IconSize
local StandardButtonSize = UIBlox.App.Button.Enum.StandardButtonSize
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local TextKeys = require(ContactImporter.Common.TextKeys)

local iconsGraphicContacts_large = Images["icons/graphic/contacts_large"]

local function FindFriendsBanner(tbl1)
    local openAmpUpsell = tbl1.openAmpUpsell
    local bool1 = not tbl1.showMatchedContacts

    local isUserInGreenFindFriendsButtonExperiment = tbl1.isUserInGreenFindFriendsButtonExperiment

    local var1 = useLocalization({
        findFriendsButton = TextKeys.CONTACTS_FIND_FRIENDS_BUTTON,
        findFriendsDescription = TextKeys.CONTACTS_FIND_FRIENDS_DESCRIPTION,
        findFriendsDescriptionPV = TextKeys.CONTACTS_FIND_FRIENDS_DESCRIPTION_PV
    })
    local var2 = useStyle()

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 48),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        UIListLayout = React.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 12)
        }),
        ImageIcon = React.createElement(ImageSetLabel, {
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(0, IconSize.Large, 0, IconSize.Large),
            ScaleType = Enum.ScaleType.Fit,
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Image = iconsGraphicContacts_large,
            ImageTransparency = var2.Theme.SystemPrimaryDefault.Transparency
        }),
        TextFrame = 0,
        ButtonFrame = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -((if bool1 then 122 else 0) + 48 + 12), 0, 48),
        LayoutOrder = 2
    }
    local tbl5 = {
        textLayout = React.createElement(
            "UIListLayout",
            {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }
        ),
        Description = React.createElement(StyledTextLabel, {
            text = if bool1 then var1.findFriendsDescription else var1.findFriendsDescriptionPV,
            fontStyle = var2.Font.CaptionBody,
            colorStyle = var2.Theme.TextDefault,
            size = UDim2.new(1, 0, 1, 0),
            lineHeight = 1,
            textTruncate = Enum.TextTruncate.AtEnd,
            textXAlignment = Enum.TextXAlignment.Left,
            textYAlignment = Enum.TextYAlignment.Center
        })
    }
    tbl3.TextFrame = createElement2(str2, tbl4, tbl5)
    local var3

    if bool1 then
        local createElement3 = React.createElement
        local str3 = "Frame"
        local tbl6 = {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 110, 0, 48),
            AnchorPoint = Vector2.new(1, 0.5),
            LayoutOrder = 3
        }
        local tbl7 = {
            ButtonLayout = React.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }
            ),
            FindFriendsButton = React.createElement(Button, {
                buttonType = if isUserInGreenFindFriendsButtonExperiment then ButtonType.PrimaryContextual else ButtonType.PrimarySystem,
                standardSize = StandardButtonSize.XSmall,
                fitContent = false,
                text = var1.findFriendsButton,
                onActivated = openAmpUpsell
            })
        }
        var3 = createElement3(str3, tbl6, tbl7)
    else
        var3 = nil
    end

    tbl3.ButtonFrame = var3
    return createElement(str1, tbl2, tbl3)
end

return FindFriendsBanner
