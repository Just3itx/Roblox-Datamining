-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCardsParent = script:FindFirstAncestor("SocialCards").Parent

local Foundation = require(SocialCardsParent.Foundation)
local React = require(SocialCardsParent.React)
local SquadExternalContractProvider = require(SocialCardsParent.SquadsCore.SquadExternalContractProvider)
local SharedFlags = require(SocialCardsParent.SharedFlags)
local useCurrentSquadId = require(SocialCardsParent.SquadsCore.Hooks).useCurrentSquadId
local useCurrentSquadParentChannelId = require(SocialCardsParent.SquadsCore.Hooks).useCurrentSquadParentChannelId
local useDispatch = require(SocialCardsParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(SocialCardsParent.Localization).Hooks.useLocalization
local useNavigation = require(SocialCardsParent.Navigation).useNavigation

local leaveSquad = require(SocialCardsParent.SquadsCore.Thunks).leaveSquad
local SquadButtonClickIntentionEnum = require(SocialCardsParent.Squads.Enums).SquadButtonClickIntentionEnum
local SquadButtonSourceEnum = require(SocialCardsParent.Squads.Enums).SquadButtonSourceEnum

local EventNames = require(SocialCardsParent.SquadsCore.EventNames)
local SquadExternalContractContext = SquadExternalContractProvider.SquadExternalContractContext
local SquadPromptType = require(SocialCardsParent.SquadsCore.Enums).SquadPromptType

local useTokens = Foundation.Hooks.useTokens

local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = SharedFlags.FFlagPartyDevAPIToRespectThirdPartySettingsEnabled
local useCanAccessParty = require(SocialCardsParent.Squads.useCanAccessParty)

local function SquadEndedCard(tbl1)
    local var1 = useDispatch()
    local var2 = useLocalization(
        {
            partyEnded = "Feature.Squads.Label.PartyEndedText",
            tapToStartNewParty = "Feature.Squads.Action.TapToStartNewParty"
        }
    )

    local var3 = useNavigation()
    local var4 = useTokens()

    local squadId = useCurrentSquadId()
    local var6 = useCurrentSquadParentChannelId()

    local var7 = React.useContext(SquadExternalContractContext)
    local var8 = var7.useParentChannelHasGroupUp(tbl1.conversationId)

    local var9 = useCanAccessParty()
    local var10 = var7.useParentChannelHasSquadAccess(tbl1.conversationId)

    local var11 = var9 and var10
    local var12 = not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var7.useIsChatEnabled()

    local var13 = React.useMemo(function(): boolean
        return var6 == tbl1.conversationId
    end, { var6, tbl1.conversationId })

    local userIntention = React.useMemo(function()
        return if var13 then SquadButtonClickIntentionEnum.View elseif var8 then SquadButtonClickIntentionEnum.Join else SquadButtonClickIntentionEnum.Create
    end, { var13, var8 })

    local var15 = React.useCallback(function()
        var7.fireSquadAnalytics(EventNames.EnterSquadButtonPressed, {
            conversationId = tbl1.conversationId,
            squadButtonSource = SquadButtonSourceEnum.PartyEndedCard,
            squadId = squadId,
            squadLocation = tbl1.squadLocation,
            userIntention = userIntention
        })
    end, {
        userIntention,
        squadId,
        tbl1.conversationId,
        tbl1.squadLocation,
        var7.fireSquadAnalytics
    })

    local createElement = React.createElement
    local view = Foundation.View

    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        backgroundStyle = var4.Color.Shift.Shift_200,
        cornerRadius = UDim.new(0, var4.Radius.Large),
        layout = {
            FillDirection = Enum.FillDirection.Vertical,
            Padding = UDim.new(0, var4.Gap.XSmall),
            SortOrder = Enum.SortOrder.LayoutOrder
        },
        selection = { Selectable = true },
        onActivated = var11 and function()
            var15()

            if squadId and tbl1.conversationId ~= var6 then
                var1(leaveSquad(SquadPromptType.JoinAnotherSquad, var7.setSquadPrompt, function()
                    var3.navigate("SquadLobby", { conversationId = tbl1.conversationId })
                end, var7.squadLocation, not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var12))

                return
            end

            var3.navigate("SquadLobby", { conversationId = tbl1.conversationId })
        end or nil,
        padding = {
            bottom = UDim.new(0, var4.Padding.Medium),
            left = UDim.new(0, var4.Padding.Large),
            right = UDim.new(0, var4.Padding.Large),
            top = UDim.new(0, var4.Padding.Medium)
        }
    }

    local tbl3 = {
        Title = React.createElement(Foundation.Text, {
            AutomaticSize = Enum.AutomaticSize.XY,
            backgroundStyle = var4.Color.None,
            fontStyle = var4.Typography.TitleMedium,
            LayoutOrder = 1,
            Text = var2.partyEnded,
            textStyle = var4.Color.Content.Emphasis,
            TextTruncate = Enum.TextTruncate.AtEnd
        }),
        Status = 0
    }
    local element

    if var11 then
        element = React.createElement(Foundation.Text, {
            AutomaticSize = Enum.AutomaticSize.XY,
            backgroundStyle = var4.Color.None,
            fontStyle = var4.Typography.LabelSmall,
            LayoutOrder = 2,
            Text = var2.tapToStartNewParty,
            textStyle = var4.Color.Content.Muted,
            TextTruncate = Enum.TextTruncate.AtEnd
        })
    else
        element = nil
    end

    tbl3.Status = element
    return createElement(view, tbl2, tbl3)
end

return SquadEndedCard
