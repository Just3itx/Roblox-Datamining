-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)
local Localization = require(GroupsParent.Localization)
local useLocalization = Localization.Hooks.useLocalization
local useAbbreviatedNumberLocalization = Localization.Hooks.useAbbreviatedNumberLocalization
local VerifiedBadges = require(GroupsParent.VerifiedBadges)
local UserLib = require(GroupsParent.UserLib)
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local View = Foundation.View
local FoundationText = Foundation.Text
local Image = Foundation.Image
local Chip = Foundation.Chip
local ChipSize = Foundation.Enums.ChipSize

local EmojiWrapper = VerifiedBadges.EmojiWrapper
local TextKeys = require(Groups.Common.TextKeys)
local _Types = require(Groups.Common.Types)
local useMembersFollowersLabel = require(Groups.Hooks.useMembersFollowersLabel)
local useGroupsWrapperContext = require(Groups.Contexts.useGroupsWrapperContext)

return React.memo(function(tbl1) -- name: GroupListItem
    local var1 = useGroupsWrapperContext()
    local group = tbl1.group
    if not group then
        return nil
    end
    local memberCount = group.memberCount or 0

    local truncatedCount = useAbbreviatedNumberLocalization(if memberCount > 0 then memberCount else nil)

    local var3 = useMembersFollowersLabel({
        hasSocialModules = group.hasSocialModules or false,
        count = memberCount,
        truncatedCount = truncatedCount,
        capitalize = false
    })

    local var4 = useLocalization({ owned = TextKeys.LabelOwned })

    local id = group.id
    local image = React.useMemo(function()
        if group.thumbnail and group.thumbnail ~= "" then
            return group.thumbnail
        end
        return getRbxthumbWithTypeSizeAndOptions(tostring(id), Constants.RbxthumbTypes.GroupIcon, 150)
    end, { id, group.thumbnail })

    local onActivated = React.useCallback(function()
        if id then
            var1.navigateTo.groupDetails(id)
        end
    end, { var1.navigateTo.groupDetails, id })

    if not tbl1.showMemberCount or group.memberCount == nil then
        var3 = nil
    end
    local roleChip = React.useMemo(function()
        if not tbl1.showRank then
            return nil
        elseif group.isOwner then
            return React.createElement(Chip, {
                text = var4.owned,
                size = ChipSize.Small,
                LayoutOrder = 3,
                isChecked = true,
                onActivated = function() end
            })
        else
            local name = if group.role and group.role.name and group.role.name ~= "" then group.role.name else nil

            if name then
                return React.createElement(Chip, {
                    text = name,
                    size = ChipSize.Small,
                    LayoutOrder = 3,
                    onActivated = function() end
                })
            end

            return nil
        end
    end, {
        tbl1.showRank,
        group.isOwner,
        group.role,
        var4.owned
    })
    local createElement = React.createElement
    local var8 = View
    local tbl2 = {
        tag = "row size-full-0 auto-y gap-large align-y-center padding-small radius-medium",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.layoutOrder,
        onActivated = onActivated
    }
    local tbl3 = {
        Thumbnail = React.createElement(
            Image,
            {
                LayoutOrder = 1,
                Image = image,
                Size = UDim2.fromOffset(38, 38),
                tag = "radius-medium bg-surface-100"
            }
        ),
        Details = 0,
        RoleChip = 0
    }

    local createElement2 = React.createElement
    local var9 = View
    local tbl4 = { LayoutOrder = 2, tag = "col size-full-0 auto-y fill" }

    local tbl5 = { NameRow = 0, Meta = 0 }
    local createElement3 = React.createElement
    local var10 = View
    local tbl6 = { tag = "row auto-y size-full-0 align-y-center", LayoutOrder = 1 }

    local tbl7 = { Name = 0 }
    local element

    if group.groupHasVerifiedBadge then
        element = React.createElement(EmojiWrapper, {
            emoji = VerifiedBadges.emoji.verified,
            layoutOrder = 1
        }, {
            NameText = React.createElement(FoundationText, {
                Text = group.name or "",
                tag = "auto-xy text-align-x-left content-default text-title-medium text-no-wrap text-truncate-end padding-right-small"
            })
        })
    else
        element = React.createElement(FoundationText, {
            Text = group.name or "",
            tag = "auto-xy text-align-x-left content-default text-title-medium text-no-wrap text-truncate-end",
            LayoutOrder = 1
        })
    end

    tbl7.Name = element
    tbl5.NameRow = createElement3(var10, tbl6, tbl7)

    tbl5.Meta = if var3 then React.createElement(FoundationText, {
        Text = var3,
        tag = "auto-xy text-align-x-left content-muted text-no-wrap text-truncate-end text-body-medium",
        LayoutOrder = 2
    })
        or nil else nil
    tbl3.Details = createElement2(var9, tbl4, tbl5)

    tbl3.RoleChip = roleChip
    return createElement(var8, tbl2, tbl3)
end)
