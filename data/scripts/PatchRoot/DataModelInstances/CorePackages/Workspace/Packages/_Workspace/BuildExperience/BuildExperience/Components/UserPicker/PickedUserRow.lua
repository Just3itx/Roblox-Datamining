-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local useUserProfileInfo = require(script.Parent.useUserProfileInfo)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local IconButton = Foundation.IconButton
local List = Foundation.List
local Loading = Foundation.Loading
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local AccessoryType = Foundation.Enums.AccessoryType

local function PickedUserRow(tbl1)
    local var1 = useUserProfileInfo(tbl1.userId)
    local var2 = useLocalization({
        unknownUser = LocalizationStrings.PRIVATE_INVITES_UNKNOWN_USER,
        username = {
            LocalizationStrings.USER_PICKER_USERNAME,
            USERNAME = var1.username
        }
    })
    local unknownUser = var2.unknownUser
    local username = var2.username
    local size1000 = useTokens().Size.Size_1000
    local element

    if tbl1.isRemoving then
        element = React.createElement(View, {
            Size = UDim2.fromOffset(size1000, size1000),
            tag = "align-x-center align-y-center",
            testId = `{tbl1.testId}-removing`
        }, {
            Spinner = React.createElement(Loading, { size = IconSize.Small })
        })
    else
        element = React.createElement(IconButton, {
            icon = IconName.TrashCan,
            onActivated = function()
                tbl1.onRemove(tbl1.userId)
            end,
            testId = `{tbl1.testId}-remove`
        })
    end
    local createElement = React.createElement
    local item = List.Item
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        leading = {
            type = AccessoryType.Avatar,
            userId = tbl1.userId
        },
        title = 0,
        description = 0,
        trailing = 0,
        testId = 0
    }
    if var1.displayName ~= "" then
        unknownUser = var1.displayName
    end

    tbl2.title = unknownUser
    tbl2.description = username
    tbl2.trailing = element
    tbl2.testId = tbl1.testId
    return createElement(item, tbl2)
end

return PickedUserRow
