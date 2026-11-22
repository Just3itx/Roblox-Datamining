-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local getStandardSizeAvatarHeadShotRbxthumb = require(SquadsParent.UserLib).Utils.getStandardSizeAvatarHeadShotRbxthumb
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local Cryo = require(SquadsParent.Cryo)
local UserProfiles = require(SquadsParent.UserProfiles)

local HorizontalFacepileGroup = require(Squads.Common.HorizontalFacepileGroup)
local dependencies = require(Squads.dependencies)
local FFlagIntroduceTopBannerPartyStates = require(Squads.Flags.FFlagIntroduceTopBannerPartyStates)
local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)
local _SquadActivityEnum = require(Squads.Enums.SquadActivityEnum)

local Foundation = dependencies.Foundation
local React = dependencies.React
local SharedFlags = dependencies.SharedFlags

local SquadCoordinationUIChangesExperimentation = dependencies.SocialExperiments.SquadCoordinationUIChangesExperimentation
local useLocalization = dependencies.Hooks.useLocalization

local Constants = require(SquadsParent.SquadsCore.Constants)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local useCurrentSquadParentChannelId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadParentChannelId

local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local FFlagDebugAppChatEnableDomLocators = SharedFlags.FFlagDebugAppChatEnableDomLocators
local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local useLastActiveParticipant = if GetFFlagEnableCrossExpVoice() then require(SquadsParent.CrossExperienceVoice).Hooks.useLastActiveParticipant else nil

function SquadTopBanner(tbl1)
    React.useEffect(function()
        SquadCoordinationUIChangesExperimentation.logExposure()
    end, {})

    local var1 = if FFlagIntroduceTopBannerPartyStates and GetFFlagEnableCrossExpVoice() then useLastActiveParticipant() else nil
    local userId = var1 and var1.userId or nil

    local var2 = useTokens()
    local var3 = if FFlagIntroduceTopBannerPartyStates then nil else useCurrentSquadParentChannelId()
    local var4 = if FFlagIntroduceTopBannerPartyStates then nil else React.useContext(SquadExternalContractContext)
    local var5 = if FFlagIntroduceTopBannerPartyStates then "" else var4.useParentChannelTitleSelector(var3 or "") or ""

    local var6 = useLocalUserId()

    local combinedNameFromId = nil

    local var7 = React.useMemo(function()
        if tbl1.parentChannelType == Constants.CONVERSATION_CHANNEL_ONE_TO_ONE_TYPE and tbl1.parentChannelParticipants then
            for _, parentChannelParticipant in ipairs(tbl1.parentChannelParticipants) do
                if parentChannelParticipant ~= var6 then
                    return parentChannelParticipant
                end
            end
        end

        return ""
    end, { tbl1.parentChannelParticipants, tbl1.parentChannelType, var6 })

    local var8 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = if var7 == "" then {} else { var7 } or {},
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
        }
    )
    if var8.data then
        combinedNameFromId = UserProfiles.Selectors.getCombinedNameFromId(var8.data, var7 or "") or ""
    end

    local bool1 = not tbl1.parentChannelType

    if not bool1 then
        if tbl1.parentChannelType == Constants.CONVERSATION_CHANNEL_ONE_TO_ONE_TYPE and var7 ~= "" then
            bool1 = not combinedNameFromId
        else
            bool1 = false
        end
    end

    local var9, var10

    if FFlagIntroduceTopBannerPartyStates then
        local var11 = useLocalization({
            waitingForOthers = "Feature.Squads.Label.WaitingForOthers",
            numberInTheParty = "Feature.Squads.Label.PartyCountStatus",
            loading = "Feature.Squads.Label.Loading",
            waitingForCombinedName = "Feature.Squads.Label.WaitingForCombinedName"
        })

        var9 = React.useMemo(function()
            if bool1 then
                return var11.loading
            end
            if tbl1.parentChannelType == Constants.CONVERSATION_CHANNEL_ONE_TO_ONE_TYPE
                and combinedNameFromId
                and #tbl1.squadMemberList < 2
            then
                return var11.waitingForCombinedName:gsub("{(.-)}", { combinedName = combinedNameFromId })
            end
            if tbl1.parentChannelType == Constants.CONVERSATION_CHANNEL_GROUP_TYPE and #tbl1.squadMemberList < 2 then
                return var11.waitingForOthers
            end
            return var11.numberInTheParty:gsub("{(.-)}", { partyCount = tostring(#tbl1.squadMemberList) })
        end, {
            bool1,
            var11,
            combinedNameFromId,
            tbl1.parentChannelType,
            tbl1.squadMemberList
        })

        local var12 = React.useCallback(function()
            local result = {}

            if var6 == "-1" or not tbl1.squadMemberList then
                return result
            end

            for _, value in ipairs(tbl1.squadMemberList) do
                if tostring(value) ~= var6 then
                    table.insert(result, tostring(value))
                end
            end

            table.insert(result, var6)
            return result
        end, { tbl1.squadMemberList })

        var10 = React.useMemo(function()
            local var13 = var12()

            return Cryo.List.map(var13, function(arg1)
                return getStandardSizeAvatarHeadShotRbxthumb(arg1)
            end)
        end, { var12 })
    else
        var10 = nil
        var9 = nil
    end

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        backgroundStyle = var2.Color.None,
        testId = if FFlagDebugAppChatEnableDomLocators then Constants.SQUAD_TOP_BANNER_TEST_ID else nil,
        layout = {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0, var2.Gap.Small),
            VerticalAlignment = Enum.VerticalAlignment.Center
        }
    }
    local tbl3 = { Icon = 0, HorizontalFacepileGroup = 0, Title = 0, Avatar = 0 }
    local element

    if FFlagIntroduceTopBannerPartyStates then
        element = nil
    else
        element = React.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(20, 20),
                BackgroundTransparency = 1,
                LayoutOrder = 1
            },
            { React.createElement(Foundation.Icon, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    size = 28,
                    name = "three-people",
                    style = var2.Color.Extended.Gray.Gray_100,
                    testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-top-banner--icon" else nil
                }) }
        )
    end

    tbl3.Icon = element

    tbl3.HorizontalFacepileGroup = if FFlagIntroduceTopBannerPartyStates then React.createElement(
        View,
        { tag = "auto-xy", BackgroundTransparency = 1, LayoutOrder = 1 },
        { React.createElement(HorizontalFacepileGroup, {
                avatarSize = var2.Size.Size_600,
                images = var10,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-top-banner--facepile" else nil
            }) }
    ) else nil

    local createElement2 = React.createElement
    local foundationText = Foundation.Text
    local tbl4 = {
        AutomaticSize = Enum.AutomaticSize.XY,
        textStyle = var2.Color.Extended.Gray.Gray_100,
        fontStyle = var2.Typography.TitleMedium,
        backgroundStyle = var2.Color.None,
        LayoutOrder = 2,
        Text = 0,
        TextTruncate = 0,
        TextXAlignment = 0,
        testId = 0
    }
    if FFlagIntroduceTopBannerPartyStates then
        var5 = var9
    end

    tbl4.Text = var5
    tbl4.TextTruncate = Enum.TextTruncate.AtEnd
    tbl4.TextXAlignment = Enum.TextXAlignment.Left
    tbl4.testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-top-banner--title" else nil
    tbl3.Title = createElement2(
        foundationText,
        tbl4,
        {
            UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill })
        }
    )
    local element2

    if FFlagIntroduceTopBannerPartyStates or not userId then
        element2 = nil
    else
        element2 = React.createElement(Foundation.Image, {
            LayoutOrder = 3,
            Size = UDim2.fromOffset(24, 24),
            backgroundStyle = var2.Color.Extended.Gray.Gray_700,
            cornerRadius = UDim.new(0, var2.Radius.Circle),
            Image = getStandardSizeAvatarHeadShotRbxthumb(tostring(userId)),
            testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-top-banner--last-active-avatar" else nil
        })
    end

    tbl3.Avatar = element2
    return createElement(view, tbl2, tbl3)
end

return React.memo(SquadTopBanner)
