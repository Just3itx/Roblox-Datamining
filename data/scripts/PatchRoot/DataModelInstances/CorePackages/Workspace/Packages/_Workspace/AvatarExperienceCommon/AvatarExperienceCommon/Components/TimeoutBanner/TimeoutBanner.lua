-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)

local _useTimeoutBannerProps = require(script.Parent.useTimeoutBannerProps)

local function TimeoutBanner(arg1)
    if not arg1.shouldShow then
        return nil
    end

    local onBannerActivated = arg1.onBannerActivated
    local messageText = arg1.messageText

    return React.createElement(Foundation.View, {
        tag = "auto-y size-full-0 padding-x-medium padding-y-small row align-x-center align-y-center gap-small",
        onActivated = onBannerActivated or nil
    }, {
        WarningIcon = React.createElement(
            Foundation.Image,
            {
                tag = "content-system-warning size-600",
                Image = "icons/status/alert",
                LayoutOrder = 1
            }
        ),
        Text = React.createElement(
            Foundation.Text,
            {
                tag = "auto-xy text-title-large text-wrap content-emphasis",
                Text = messageText,
                LayoutOrder = 2
            }
        )
    })
end

return TimeoutBanner
