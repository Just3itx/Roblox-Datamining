-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    local result = {}

    result.info = {
        webbundle = arg1.fromString("www:bundles/{assetId}"),
        webasset = arg1.fromString("www:catalog/{assetId}"),
        webpage = function(arg2)
            if arg2.assetType == "Bundle" then
                return result.info.webbundle(arg2)
            elseif arg2.assetType == "Asset" then
                return result.info.webasset(arg2)
            end
            warn(string.format("%s - unknown assetType of %s", tostring(script.name), tostring(arg2.assetType)))
            return nil
        end,
        appsflyer = function(arg2)
            return arg1.fromString("appsflyer:Ebh5?pid=share&is_retargeting=true&af_dp={mobileUrl}&af_web_dp={webUrl}")({
                mobileUrl = arg1.fromString("mobilenav:item_details?itemId={assetId}&itemType={assetType}")(arg2),
                webUrl = result.info.webpage(arg2)
            })
        end
    }

    return result
end
