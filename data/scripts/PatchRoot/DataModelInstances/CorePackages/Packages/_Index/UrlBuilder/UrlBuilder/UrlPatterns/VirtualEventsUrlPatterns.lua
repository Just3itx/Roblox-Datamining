-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return {
        appsflyer = function(arg2)
            local mobileUrl = arg1.fromString("mobilenav:event_details?eventid={eventId}")(arg2)
            local webUrl = arg1.fromString("www:events/{eventId}")(arg2)
            return arg1.fromString("appsflyer:Ebh5?pid=share&is_retargeting=true&af_dp={mobileUrl}&af_web_dp={webUrl}")(
                { mobileUrl = mobileUrl, webUrl = webUrl }
            )
        end
    }
end
