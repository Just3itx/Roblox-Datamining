-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:11:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceTimedOptionsParent = script:FindFirstAncestor("AvatarExperienceTimedOptions").Parent

local React = require(AvatarExperienceTimedOptionsParent.React)
local View = require(AvatarExperienceTimedOptionsParent.Foundation).View

local _AvatarExperienceCommon = require(AvatarExperienceTimedOptionsParent.AvatarExperienceCommon)
local WearTimeListItem = require(script.Parent.WearTimeListItem)

local function WearTimeList(tbl1)
    local tbl2 = ({})

    for layoutOrder, option in tbl1.options do
        local str1 = "WearTimeListItem_" .. tostring(layoutOrder)

        tbl2[str1] = React.createElement(WearTimeListItem, {
            days = option.days,
            price = option.price,
            isActive = not (option.selected == nil) and option.selected,
            onActivated = tbl1.onOptionActivated and function()
                tbl1.onOptionActivated(layoutOrder)
            end or nil,
            LayoutOrder = layoutOrder
        })
    end

    return React.createElement(View, {
        tag = "col gap-small size-full-0 auto-y padding-small radius-medium stroke-default stroke-thick",
        LayoutOrder = tbl1.LayoutOrder
    }, tbl2)
end

return WearTimeList
