-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:11:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local PickedUserRow = require(script.Parent.PickedUserRow)

local List = Foundation.List

local InputSize = Foundation.Enums.InputSize

local function PickedUserList(tbl1)
    local testId = tbl1.testId or "picked-user-list"
    local onRemove = tbl1.onRemove
    local var1 = tbl1.removingUserIds or {}

    local tbl2 = {}
    if tbl1.header ~= nil then
        tbl2.Header = tbl1.header
    end

    for k, userId in tbl1.userIds do
        local str1 = `{testId}-user-{userId}`

        local str2 = `row-{userId}`
        tbl2[str2] = React.createElement(
            PickedUserRow,
            {
                userId = userId,
                isRemoving = var1[userId] == true,
                onRemove = onRemove,
                LayoutOrder = k + 1,
                testId = str1
            }
        )
    end
    return React.createElement(List.Root, {
        LayoutOrder = tbl1.layoutOrder,
        hasDivider = { hasDivider = true, isInset = false },
        isContained = true,
        size = InputSize.Medium,
        testId = testId
    }, tbl2)
end

return PickedUserList
