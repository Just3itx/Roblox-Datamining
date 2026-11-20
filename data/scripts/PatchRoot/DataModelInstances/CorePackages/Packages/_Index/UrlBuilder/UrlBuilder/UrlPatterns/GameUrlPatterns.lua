-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppsFlyerUtil = require(script.Parent.utils.AppsFlyerUtil)

return function(arg1)
    local result = {}

    result.info = {
        webpage = arg1.fromString("www:games/{placeId}"),
        store = arg1.fromString("www:games/store-section/{universeId}"),
        badges = arg1.fromString("www:games/badges-section/{universeId}"),
        servers = arg1.fromString("www:games/servers-section/{universeId}"),
        serversPreopenCreateVip = arg1.fromString("www:games/servers-section-preopen-create-vip/{universeId}"),
        group = arg1.fromString("www:communities/{creatorId}"),
        user = arg1.fromString("www:users/{creatorId}/profile"),
        pass = arg1.fromString("www:game-pass/{passId}"),
        creator = function(arg2)
            if arg2.creatorType == "Group" then
                return result.info.group(arg2)
            elseif arg2.creatorType == "User" then
                return result.info.user(arg2)
            end
            warn(string.format("%s - unknown creatorType of %s", tostring(script.name), tostring(arg2.creatorType)))
            return nil
        end,
        appsflyer = function(arg2)
            local description = arg2.description
            local image = arg2.image
            local title = arg2.title

            if not (description and image and title) then
                return arg1.fromString("appsflyer:Ebh5?pid=share&is_retargeting=true&af_dp={mobileUrl}&af_web_dp={webUrl}")(
                    {
                        mobileUrl = arg1.fromString("mobilenav:game_details?gameId={universeId}")(arg2),
                        webUrl = result.info.webpage(arg2)
                    }
                )
            end

            return arg1.fromString(
                "appsflyer:Ebh5?pid=share&is_retargeting=true&af_og_title={title}&af_og_image={image}&af_og_description={description}&af_dp={mobileUrl}&af_web_dp={webUrl}"
            )(
                {
                    image = image,
                    title = title,
                    description = AppsFlyerUtil.sanitizeDescription(description),
                    mobileUrl = arg1.fromString("mobilenav:game_details?gameId={universeId}")(arg2),
                    webUrl = result.info.webpage(arg2)
                }
            )
        end
    }

    result.details = arg1.fromString("games:games?{universeIds}")
    result.playability = arg1.fromString("games:games/multiget-playability-status?{universeIds}")
    result.media = arg1.fromString("games:games/{universeId}/media")
    result.favorite = arg1.fromString("games:games/{universeId}/favorites")
    result.social = arg1.fromString("games:games/{universeId}/social-links/list")
    result.recommended = arg1.fromString("games:games/recommendations/game/{universeId}?{paginationKey|}&{maxRows|6}")
    result.thumbnail = arg1.fromString("games:games/game-thumbnails?{height|150}&{width|150}&{imageTokens}")
    result.vote = {
        all = arg1.fromString("games:games/{universeId}/votes"),
        get = arg1.fromString("games:games/{universeId}/votes/user"),
        set = arg1.fromString("games:games/{universeId}/user-votes")
    }
    result.follow = {
        get = arg1.fromString("followings:users/{userId}/universes/{universeId}/status"),
        set = arg1.fromString("followings:users/{userId}/universes/{universeId}")
    }
    result.report = arg1.fromString("www:abusereport/asset?id={placeId}")

    result.place = arg1.fromString("games:games/multiget-place-details?{placeIds}")

    return result
end
