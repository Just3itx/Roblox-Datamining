-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local Foundation = require(GroupsParent.Foundation)

local View = Foundation.View
local FoundationText = Foundation.Text

local _Types = require(Groups.Common.Types)
local GroupListItem = require(script.Parent.GroupListItem)

return React.memo(function(tbl1) -- name: GroupsListSection
    if #tbl1.groups == 0 then
        return nil
    end

    local tbl2 = {}
    local bool1 = false

    if tbl1.heading and tbl1.heading ~= "" then
        tbl2.Heading = React.createElement(
            FoundationText,
            {
                LayoutOrder = 1,
                Text = tbl1.heading,
                tag = "content-default text-align-x-left size-full-0 auto-y text-title-large"
            }
        )
    end

    for i, group in ipairs(tbl1.groups) do
        local bool2 = not tbl1.visibleIds or tbl1.visibleIds[group.id] == true

        local str1 = `Group_{group.id}`
        local createElement = React.createElement
        local var1 = View
        local tbl3 = {
            Visible = bool2,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = i + 1
        }
        local tbl4 = {
            Item = React.createElement(
                GroupListItem,
                {
                    group = group,
                    layoutOrder = i + 1,
                    showRank = tbl1.showRank,
                    showMemberCount = tbl1.showMemberCount
                }
            )
        }
        tbl2[str1] = createElement(var1, tbl3, tbl4)
        bool1 = bool1 or bool2
    end

    return React.createElement(View, {
        tag = "col gap-small",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = tbl1.layoutOrder,
        Visible = bool1
    }, tbl2)
end)
