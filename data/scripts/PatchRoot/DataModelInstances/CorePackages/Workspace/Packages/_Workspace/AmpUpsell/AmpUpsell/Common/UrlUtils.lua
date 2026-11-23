-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent

local UrlBase = require(AmpUpsellParent.UrlBuilder).UrlBase

local module = {}

function module.buildAmpWizardUrl(str1: string, str2: string, str3: string?, str4: string?)
    local var1 = UrlBase.new("www") .. "/amp-wizard?feature_name=" .. str1 .. "&namespace=" .. str2

    if str3 then
        var1 ..= "&entry_point=" .. str3
    end

    if str4 then
        var1 ..= "&returnpage=" .. str4
    end

    return var1
end

return module
