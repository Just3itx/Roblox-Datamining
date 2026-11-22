-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local Responsive = require(SquadsParent.Responsive)

local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local dependencies = require(Squads.dependencies)

local Foundation = dependencies.Foundation
local React = dependencies.React
local NetworkingSquads = dependencies.NetworkingSquads
local NetworkStatus = dependencies.RoduxNetworking.Enum.NetworkStatus
local useEffectOnce = dependencies.Hooks.useEffectOnce
local useDispatch = dependencies.Hooks.useDispatch
local useSelector = dependencies.Hooks.useSelector

local useTokens = Foundation.Hooks.useTokens
local useCurrentSquadSelector = dependencies.Hooks.useCurrentSquadSelector
local useLocalization = dependencies.Hooks.useLocalization

local reinviteToSquad = require(SquadsParent.SquadsCore.Thunks).reinviteToSquad
local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local useCurrentSquadId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadId

local AvatarGroup = Foundation.AvatarGroup
local AvatarGroupType = Foundation.Enums.AvatarGroupType
local InputSize = Foundation.Enums.InputSize

local NoResponseInviteAgainOrAddOthersEnum = require(Squads.Enums.NoResponseInviteAgainOrAddOthersEnum)
local SquadInvitePageNavSourceEnum = require(Squads.Enums.SquadInvitePageNavSourceEnum)

return function(tbl1)
    local var1 = useDispatch()
    local var2 = useTokens()
    local col = Responsive.useBreakpointXOrSmaller(Responsive.Keys.XSmall)
    local var4 = Responsive.useBreakpointYOrSmaller(Responsive.Keys.XSmall)
    local var5 = useLocalUserId()

    local var6 = useLocalization({
        addOthers = "Feature.Squads.Action.AddOthers",
        upsellText = "Feature.Squads.Description.upsellInviteText",
        inviteText = "Feature.Squads.Action.Invite",
        inviteAgain = "Feature.Squads.Action.InviteAgain"
    })

    local var7 = useCurrentSquadSelector()
    local parentChannelId = if var7 and var7.parentChannelId then var7.parentChannelId else nil
    local squadId = useCurrentSquadId()

    local var9 = React.useCallback(function(arg1)
        return NetworkingSquads.ReinviteToSquad.getStatus(arg1, { squadId = squadId })
    end, { squadId })
    local var10 = useSelector(var9)

    local var11 = React.useContext(SquadExternalContractContext)
    local var12 = var11.useGetConversationFromId(parentChannelId or "")

    local upsellLabel = React.useMemo(function()
        return React.createElement(Foundation.Text, {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 0),
            fontStyle = var2.Typography.BodyLarge,
            LayoutOrder = 1,
            Text = var6.upsellText,
            textStyle = var2.Color.Content.Default,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextWrapped = true,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-upsell-card--label" else nil
        })
    end, { var2, var6.upsellText })

    local upsellFacepile = React.useMemo(function()
        local avatars = {}
        if var12 and var12.participants then
            for _, participant in ipairs(var12.participants) do
                if participant ~= var5 then
                    table.insert(avatars, participant)
                end
            end
        end

        if var4 or col then
            return nil
        end

        return (React.createElement(AvatarGroup, {
            avatars = avatars,
            size = InputSize.Medium,
            type = AvatarGroupType.Stacked,
            max = 4,
            imageBackgroundStyle = {
                Color3 = var2.Color.OverMedia.OverMedia_300.Color3,
                Transparency = var2.Color.OverMedia.OverMedia_300.Transparency
            },
            imageBorderStyle = {
                Color = var2.Color.Surface.Surface_0.Color3,
                Transparency = var2.Color.Surface.Surface_0.Transparency
            },
            layoutOrder = 0,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-upsell-card--facepile" else nil
        }))
    end, {
        var12 and var12.participants,
        var5,
        var4,
        col
    })
    useEffectOnce(function()
        var11.fireSquadAnalytics(EventNames.NoResponseInviteAgainOrAddOthers, {
            actionType = NoResponseInviteAgainOrAddOthersEnum.Impression,
            button = NoResponseInviteAgainOrAddOthersEnum.InviteAgain,
            conversationId = parentChannelId
        })
        var11.fireSquadAnalytics(EventNames.NoResponseInviteAgainOrAddOthers, {
            actionType = NoResponseInviteAgainOrAddOthersEnum.Impression,
            button = NoResponseInviteAgainOrAddOthersEnum.AddOthers,
            conversationId = parentChannelId
        })
    end, parentChannelId)

    local onActivated = React.useCallback(function()
        var1(reinviteToSquad(squadId, var11.setSquadPrompt))

        var11.fireSquadAnalytics(EventNames.NoResponseInviteAgainOrAddOthers, {
            actionType = NoResponseInviteAgainOrAddOthersEnum.Click,
            button = NoResponseInviteAgainOrAddOthersEnum.InviteAgain,
            conversationId = parentChannelId
        })
    end, { var11.fireSquadAnalytics, parentChannelId })

    local var3 = React.useCallback(function()
        var11.fireSquadAnalytics(EventNames.NoResponseInviteAgainOrAddOthers, {
            actionType = NoResponseInviteAgainOrAddOthersEnum.Click,
            button = NoResponseInviteAgainOrAddOthersEnum.AddOthers,
            conversationId = parentChannelId
        })
        var11.fireSquadAnalytics(
            EventNames.SquadInvitePageNavSource,
            {
                inviteNavSource = SquadInvitePageNavSourceEnum.SquadLobbyUpsellCardClicked,
                parentChannelId = parentChannelId
            }
        )
        tbl1.navigateToSquadInviteFriends()
    end, { parentChannelId, var11.fireSquadAnalytics, tbl1.navigateToSquadInviteFriends })

    local inviteAgainButton = React.useMemo(function()
        return React.createElement(Foundation.Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            isDisabled = var10 == NetworkStatus.Fetching,
            LayoutOrder = 1,
            onActivated = onActivated,
            text = var6.inviteAgain,
            size = Foundation.Enums.InputSize.Medium,
            variant = Foundation.Enums.ButtonVariant.Standard,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-upsell-card--invite-again-button" else nil
        })
    end, { onActivated, var6.inviteAgain, var10 })

    local addOthersButton = React.useMemo(function()
        return React.createElement(Foundation.Button, {
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            LayoutOrder = 2,
            onActivated = var3,
            text = var6.addOthers,
            size = Foundation.Enums.ButtonSize.Medium,
            variant = Foundation.Enums.ButtonVariant.Standard,
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-upsell-card--add-others-button" else nil
        })
    end, { var3, var6.addOthers })

    return React.createElement("Frame", {
        Size = tbl1.size,
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder
    }, {
        React.createElement(Foundation.View, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, -2 * var2.Stroke.Standard, 1, -2 * var2.Stroke.Standard),
            cornerRadius = UDim.new(0, var2.Radius.Medium),
            padding = var2.Padding.XXLarge,
            layout = {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, if var4 or col then var2.Padding.Medium else var2.Padding.XXLarge),
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center
            },
            stroke = {
                Color = var2.Color.Stroke.Default.Color3,
                Transparency = var2.Color.Stroke.Default.Transparency,
                Thickness = var2.Stroke.Standard
            },
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-upsell-card" else nil
        }, {
            UpsellInformation = React.createElement(
                Foundation.View,
                { LayoutOrder = 1, tag = "size-full-0 gap-medium align-x-center auto-y col" },
                { UpsellFacepile = upsellFacepile, UpsellLabel = upsellLabel }
            ),
            Buttons = React.createElement(
                Foundation.View,
                {
                    LayoutOrder = 2,
                    tag = {
                        ["size-full-0 gap-small align-x-center flex-fill align-y-center auto-y"] = true,
                        col = col,
                        row = not col
                    }
                },
                { InviteAgainButton = inviteAgainButton, AddOthersButton = addOthersButton }
            )
        })
    })
end
