-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local UIBlox = require(ProfilePlatformParent.UIBlox)
local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization

local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local SocialLinksCarousel = require(ProfilePlatform.Components.SocialLinks.SocialLinksCarousel)
local Enums = require(ProfilePlatform.Common.Enums)
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local SocialMediaTypes = Enums.SocialMediaTypes

local Images = UIBlox.App.ImageSet.Images

local tbl1 = {
    [SocialMediaTypes.Twitter] = Images["icons/brands/x"],
    [SocialMediaTypes.Facebook] = Images["icons/brands/facebook"],
    [SocialMediaTypes.Discord] = Images["icons/brands/discord"],
    [SocialMediaTypes.YouTube] = Images["icons/brands/youtube"],
    [SocialMediaTypes.Twitch] = Images["icons/brands/twitch"],
    [SocialMediaTypes.Guilded] = Images["icons/brands/guilded"],
    [SocialMediaTypes.X] = Images["icons/brands/x"]
}

return function(tbl2)
    local var1 = useProfileJsonComponent(Enums.Components.SocialLinks)
    local var2 = useLocalization({
        facebook = TextKeys.Facebook,
        twitter = TextKeys.X,
        youtube = TextKeys.YouTube,
        twitch = TextKeys.Twitch,
        guilded = TextKeys.Guilded,
        discord = TextKeys.Discord,
        x = TextKeys.X
    })

    local function func1(arg1)
        local result = {}
        for key, value in pairs(arg1) do
            local name = var2[key]
            local var4 = tbl1[key]
            if not (value and var4) then
                continue
            end

            table.insert(result, { key = key, logo = tbl1[key], url = value.url, name = name })
        end

        return result
    end

    local items = React.useMemo(function()
        return (func1(var1))
    end, { var1, var2 })

    if not (#items > 0) then
        return React.None
    end

    return React.createElement(SocialLinksCarousel, { layoutOrder = tbl2.layoutOrder, items = items, title = tbl2.title })
end
