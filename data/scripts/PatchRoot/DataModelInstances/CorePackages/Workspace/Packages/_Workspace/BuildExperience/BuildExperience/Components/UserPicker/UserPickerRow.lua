-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local useUserProfileInfo = require(script.Parent.useUserProfileInfo)
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local Icon = Foundation.Icon
local List = Foundation.List
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local AccessoryType = Foundation.Enums.AccessoryType
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize

local function UserPickerRow(tbl1)
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
    local var3 = useTokens()
    local trailing = if tbl1.isSelected then React.createElement(Icon, { name = IconName.CheckLarge, size = IconSize.Medium, style = var3.Color.Content.Emphasis }) else nil
    local createElement = React.createElement
    local item = List.Item
    local tbl2 = {
        leading = {
            type = AccessoryType.Avatar,
            userId = tbl1.userId
        },
        title = 0,
        description = 0,
        trailing = 0
    }
    if var1.displayName ~= "" then
        unknownUser = var1.displayName
    end

    tbl2.title = unknownUser
    tbl2.description = username
    tbl2.trailing = trailing
    local element2 = createElement(item, tbl2)

    local element3 = React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        },
        {
            Item = element2,
            Scrim = if tbl1.isDisabled then React.createElement("Frame", {
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = var3.Color.Surface.Surface_100.Color3,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                ZIndex = 2
            }) else nil
        }
    )

    return React.createElement(View, {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.onToggle,
        stateLayer = {},
        isDisabled = tbl1.isDisabled,
        tag = "size-full-0 auto-y",
        testId = tbl1.testId
    }, { Item = element3 })
end

return UserPickerRow
