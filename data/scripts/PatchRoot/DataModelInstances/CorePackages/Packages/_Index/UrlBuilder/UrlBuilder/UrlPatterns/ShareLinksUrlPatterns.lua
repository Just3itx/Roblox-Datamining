-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return {
        appsflyer = function(linkId: string, linkType: string)
            local tbl1 = { linkId = linkId, linkType = linkType }

            local mobileUrl = arg1.fromString("mobilenav:share_links?code={linkId}&type={linkType}")(tbl1)
            local webUrl = arg1.fromString("www:share-links?code={linkId}&type={linkType}")(tbl1)
            return arg1.fromString("appsflyer:Ebh5?pid=share&is_retargeting=true&af_dp={mobileUrl}&af_web_dp={webUrl}")(
                { mobileUrl = mobileUrl, webUrl = webUrl }
            )
        end,
        shortUrl = function(tbl1)
            return arg1.fromString("www:share?code={linkId}&type={type}&stamp={stamp|}")(tbl1)
        end
    }
end
