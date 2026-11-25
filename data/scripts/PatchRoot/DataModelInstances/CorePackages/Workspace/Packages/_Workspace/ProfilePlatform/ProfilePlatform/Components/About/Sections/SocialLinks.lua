-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local Foundation = require(ProfilePlatformParent.Foundation)
local Localization = require(ProfilePlatformParent.Localization)
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local useLocalization = Localization.Hooks.useLocalization
local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local InputSize = Foundation.Enums.InputSize
local ButtonVariant = Foundation.Enums.ButtonVariant

local tbl1 = {
    x = "icons/brands/x",
    facebook = "icons/brands/facebook",
    youtube = "icons/brands/youtube",
    twitch = "icons/brands/twitch",
    guilded = "icons/brands/guilded"
}

local tbl2 = {
    "facebook",
    "x",
    "youtube",
    "twitch",
    "guilded"
}

local function SocialLinks(tbl3)
    local var1 = useLocalization({ socialLinks = TextKeys.SocialLinks, noSocialLink = TextKeys.NoSocialLink })

    local tbl4 = ({})
    if tbl3.socialLinks then
        for layoutOrder, value in ipairs(tbl2) do
            local socialLink = tbl3.socialLinks[value]
            if not (socialLink and socialLink.target) then
                continue
            end

            local createElement = React.createElement
            local var2 = Button
            local tbl5 = {
                LayoutOrder = layoutOrder,
                Selectable = false,
                tag = "auto-y size-full-0 padding-left-small padding-right-small no-hover",
                text = socialLink.target,
                icon = tbl1[value],
                size = InputSize.Small,
                variant = ButtonVariant.Utility,
                onActivated = 0
            }

            function tbl5.onActivated() end

            tbl4[value] = createElement(var2, tbl5)
        end
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl3.layoutOrder,
            tag = "col size-full-0 auto-y gap-small align-x-left"
        },
        {
            SocialLinksTitle = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 1,
                    tag = "auto-y size-full-0 text-align-x-left text-heading-small",
                    Text = var1.socialLinks
                }
            ),
            LinksContainer = if tbl3.socialLinks then React.createElement(View, { LayoutOrder = 2, tag = "row wrap size-full-0 auto-xy gap-small align-x-left" }, tbl4) else React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    tag = "auto-y size-full-0 text-align-x-left text-body-medium",
                    Text = var1.noSocialLink
                }
            )
        }
    )
end

return SocialLinks
