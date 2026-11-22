-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialProof = script:FindFirstAncestor("SocialProof")
local SocialProofParent = SocialProof.Parent

local Foundation = require(SocialProofParent.Foundation)
local Chip = Foundation.Chip

local React = require(SocialProofParent.React)
local useDispatch = require(SocialProofParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigateDown = require(SocialProofParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(SocialProofParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(SocialProofParent.RobloxAppNavigation).NavigationCommands else nil
local AppPage = require(SocialProofParent.RobloxAppEnums).AppPage
local AvatarGroupType = Foundation.Enums.AvatarGroupType
local useEntityConnectionsPagination = require(SocialProof.Hooks.useEntityConnectionsPagination)
local Enums = require(SocialProof.Common.Enums)
local useLocalization = require(SocialProofParent.Localization).Hooks.useLocalization
local _Types = require(SocialProof.Common.Types)

local FFlagEnableSocialProofOnItemDetailsRoactGamepadNavigation = require(SocialProofParent.SharedFlags).FFlagEnableSocialProofOnItemDetailsRoactGamepadNavigation

return React.forwardRef(function(arg1, ref) -- name: FriendsOwnedChip
    local fromProfile = arg1.fromProfile
    local itemId = arg1.itemId
    local itemType = arg1.itemType

    local var1 = useDispatch()

    local var2 = useEntityConnectionsPagination(
        {
            entityId = itemId,
            entityType = itemType,
            connectionType = Enums.ConnectionType.Friend
        }
    )
    local var3 = var2.userIds or {}

    local avatars = { table.unpack(var3, 1, math.min(2, #var3)) }
    local totalConnections = var2.totalConnections or 0

    local onActivated = React.useCallback(function()
        local tbl2 = {
            name = AppPage.FriendsOwnedUserList,
            extraProps = {
                entityId = itemId,
                entityType = itemType,
                source = if fromProfile then "profile" else "marketplace"
            }
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
            return
        end
        var1(NavigateDown(tbl2))
    end, {
        var1,
        itemId,
        itemType,
        fromProfile
    })
    local var5 = useLocalization({
        connectionsOwn = {
            "Feature.Friends.Label.FriendsOwn",
            numberOfConnections = totalConnections
        },
        singleConnectionOwns = "Feature.Friends.Label.FriendOwns"
    })
    local text = if totalConnections == 1 then var5.singleConnectionOwns else var5.connectionsOwn

    if FFlagEnableSocialProofOnItemDetailsRoactGamepadNavigation then
        React.useEffect(function()
            if totalConnections > 0 and arg1.chipIsRenderedCallback then
                arg1.chipIsRenderedCallback(true)
            end
        end, { totalConnections, arg1.chipIsRenderedCallback })
    end

    if totalConnections == 0 then
        return nil
    end

    return React.createElement(Chip, {
        LayoutOrder = arg1.layoutOrder or 0,
        text = text,
        onActivated = onActivated,
        leading = {
            type = "AvatarGroup",
            props = {
                avatars = avatars,
                type = AvatarGroupType.Stacked,
                max = 2
            }
        },
        ref = ref,
        NextSelectionUp = arg1.NextSelectionUp,
        NextSelectionDown = arg1.NextSelectionDown,
        NextSelectionRight = arg1.NextSelectionRight,
        NextSelectionLeft = arg1.NextSelectionLeft
    })
end)
