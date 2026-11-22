-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCardsParent = script:FindFirstAncestor("SocialCards").Parent

local Foundation = require(SocialCardsParent.Foundation)
local getStandardSizeAvatarHeadShotRbxthumb = require(SocialCardsParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb
local ImagePile = require(SocialCardsParent.AppBlox).ImagePile
local React = require(SocialCardsParent.React)
local useNavigation = require(SocialCardsParent.Navigation).useNavigation
local useLocalization = require(SocialCardsParent.Localization).Hooks.useLocalization

local useTokens = Foundation.Hooks.useTokens

local SquadJoinButton = require(SocialCardsParent.Squads.SquadJoinButton)
local SquadComponentAccessWrapper = require(SocialCardsParent.Squads.SquadComponentAccessWrapper)
local SquadButtonSourceEnum = require(SocialCardsParent.Squads.Enums).SquadButtonSourceEnum

local function SquadStartedCard(tbl1)
    local var1 = useNavigation()
    local var2 = useTokens()
    local var3 = useLocalization({
        manyPeopleActive = {
            "Feature.Squads.Description.ManyPeopleActive",
            userCount = #tbl1.participantUserIds
        },
        onePersonActive = "Feature.Squads.Description.OnePersonActive",
        partyStarted = "Feature.Squads.Label.PartyStartedText"
    })

    local var4 = React.useCallback(function(arg1)
        local images = {}
        for _, value in ipairs(arg1) do
            table.insert(images, {
                Image = getStandardSizeAvatarHeadShotRbxthumb(tostring(value)),
                BackgroundColor3 = var2.Color.Surface.Surface_200.Color3:lerp(
                    var2.Color.ActionStandard.Background.Color3,
                    1 - var2.Color.ActionStandard.Background.Transparency
                )
            })
        end

        return React.createElement(ImagePile, {
            images = images,
            imageBorderColor = if var2.Config.Theme.IsUIBlox == "true" then var2.Color.Shift.Shift_200.Color3 else var2.Color.Surface.Surface_200.Color3
        })
    end, {})

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, var2.Gap.Small),
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        padding = {
            bottom = UDim.new(0, var2.Padding.Medium),
            left = UDim.new(0, var2.Padding.Large),
            right = UDim.new(0, var2.Padding.Large),
            top = UDim.new(0, var2.Padding.Medium)
        },
        selection = { Selectable = true },
        tag = "bg-shift-200 radius-large"
    }

    local tbl3 = { InfoContainer = 0, ActionButton = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var2.Gap.Large),
            VerticalAlignment = Enum.VerticalAlignment.Center
        },
        LayoutOrder = 1
    }

    local tbl5 = {
        Thumbnail = if #tbl1.participantUserIds > 0 then React.createElement(
            Foundation.View,
            {
                Size = UDim2.fromOffset(var2.Size.Size_1000, var2.Size.Size_1000),
                LayoutOrder = 1
            },
            { var4(tbl1.participantUserIds) }
        ) else nil,
        TextContainer = 0
    }

    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl6 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = if #tbl1.participantUserIds > 0 then UDim2.new(1, -var2.Size.Size_1000 - var2.Padding.Large, 0, 0) else UDim2.fromScale(1, 0),
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, var2.Gap.XSmall),
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        LayoutOrder = 2
    }

    local tbl7 = {
        Title = React.createElement(Foundation.Text, {
            AutomaticSize = Enum.AutomaticSize.XY,
            backgroundStyle = var2.Color.None,
            fontStyle = var2.Typography.TitleMedium,
            LayoutOrder = 1,
            Text = var3.partyStarted,
            textStyle = var2.Color.Content.Emphasis,
            TextTruncate = Enum.TextTruncate.AtEnd
        }),
        Status = React.createElement(Foundation.Text, {
            AutomaticSize = Enum.AutomaticSize.XY,
            backgroundStyle = var2.Color.None,
            fontStyle = var2.Typography.LabelSmall,
            LayoutOrder = 2,
            Text = if #tbl1.participantUserIds == 1 then var3.onePersonActive else var3.manyPeopleActive,
            textStyle = var2.Color.Content.Muted,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
    }
    tbl5.TextContainer = createElement3(view3, tbl6, tbl7)
    tbl3.InfoContainer = createElement2(view2, tbl4, tbl5)

    tbl3.ActionButton = React.createElement(SquadComponentAccessWrapper, {
        parentChannelId = tbl1.conversationId
    }, {
        React.createElement(SquadJoinButton, {
            conversationId = tbl1.conversationId,
            isFullWidth = true,
            isInCard = true,
            layoutOrder = 3,
            onActivated = function()
                var1.navigate("SquadLobby", { conversationId = tbl1.conversationId })
            end,
            shouldAnimate = false,
            squadButtonSource = SquadButtonSourceEnum.PartyStartedCard,
            squadLocation = tbl1.squadLocation
        })
    })

    return createElement(view, tbl2, tbl3)
end

return SquadStartedCard
