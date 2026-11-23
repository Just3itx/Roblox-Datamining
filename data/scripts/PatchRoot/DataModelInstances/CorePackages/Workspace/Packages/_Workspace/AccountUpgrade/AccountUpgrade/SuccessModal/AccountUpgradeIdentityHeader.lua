-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local React = require(AccountUpgradeParent.React)

local Foundation = require(AccountUpgradeParent.Foundation)
local Avatar = Foundation.Avatar
local FoundationText = Foundation.Text
local View = Foundation.View
local AvatarSize = Foundation.Enums.AvatarSize

local function AccountUpgradeIdentityHeader(tbl1)
    local displayName = tbl1.displayName
    if displayName == nil or displayName == "" then
        displayName = tbl1.username
    end

    return React.createElement(View, {
        tag = "col align-x-center gap-medium size-full-0 auto-y",
        LayoutOrder = tbl1.LayoutOrder,
        testId = "account-upgrade-identity-header"
    }, {
        Avatar = React.createElement(
            Avatar,
            {
                userId = tbl1.userId,
                size = AvatarSize.Pictogram,
                LayoutOrder = 1,
                testId = "account-upgrade-identity-avatar"
            }
        ),
        Credentials = React.createElement(
            View,
            { tag = "col align-x-center gap-xsmall size-full-0 auto-y", LayoutOrder = 2 },
            {
                DisplayName = React.createElement(FoundationText, {
                    tag = "size-full-0 auto-y text-heading-small text-wrap text-align-x-center content-default",
                    Text = displayName,
                    LayoutOrder = 1,
                    testId = "account-upgrade-display-name"
                }),
                Username = React.createElement(FoundationText, {
                    tag = "size-full-0 auto-y text-label-medium text-wrap text-align-x-center content-muted",
                    Text = `@{tbl1.username}`,
                    LayoutOrder = 2,
                    testId = "account-upgrade-username"
                })
            }
        )
    })
end

return AccountUpgradeIdentityHeader
