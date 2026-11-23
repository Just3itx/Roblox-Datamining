-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserListParent = script:FindFirstAncestor("UserList").Parent

local React = require(UserListParent.React)
local Foundation = require(UserListParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton

local Avatar = Foundation.Avatar
local InputSize = Foundation.Enums.InputSize
local useTokens = Foundation.Hooks.useTokens

local function UserRow(tbl1)
    local bool1 = tbl1.displayName == "" or tbl1.username == ""
    local displayName = tbl1.displayName
    local str1 = `@{tbl1.username}`
    local userId = tonumber(tbl1.userId)

    local var2 = useTokens()

    if userId == nil then
        return nil
    end

    local createElement = React.createElement
    local str2 = "TextButton"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundTransparency = 1,
        Text = "",
        BorderSizePixel = 0,
        [React.Event.Activated] = tbl1.onActivated
    }
    local tbl3 = {
        Layout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 12)
        }),
        Avatar = React.createElement(Avatar, {
            userId = userId,
            size = InputSize.Large,
            userPresence = tbl1.userPresence,
            backgroundStyle = var2.Color.Shift.Shift_300,
            LayoutOrder = 1
        }),
        UserInfo = React.createElement(
            Foundation.View,
            {
                tag = "size-full-0 auto-y col gap-xsmall align-x-left align-y-center",
                LayoutOrder = 2
            },
            {
                DisplayName = if bool1 then nil else React.createElement(
                    Foundation.Text,
                    {
                        LayoutOrder = 1,
                        Text = displayName,
                        tag = "auto-xy text-title-medium content-emphasis text-align-x-left"
                    }
                ),
                Username = if bool1 then nil else React.createElement(
                    Foundation.Text,
                    {
                        LayoutOrder = 2,
                        Text = str1,
                        tag = "auto-xy text-body-medium content-default text-align-x-left"
                    }
                ),
                ShimmerDisplayName = if bool1 then React.createElement(Skeleton, {
                    LayoutOrder = 1,
                    Size = UDim2.new(0.8, 0, 0, var2.Typography.TitleMedium.FontSize + var2.Typography.BodyMedium.FontSize),
                    radius = Radius.Circle
                }) else nil
            }
        )
    }
    return createElement(str2, tbl2, tbl3)
end

return UserRow
