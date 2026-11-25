-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local getPaymentFromPlatform = require(scriptParentParent.Utils.getPaymentFromPlatform)
local _getPaymentFromPlatformLegacy = require(scriptParentParent.Utils.getPaymentFromPlatformLegacy)
local getHasAmazonUserAgent = require(scriptParentParent.Utils.getHasAmazonUserAgent)
local getHasQuestUserAgent = require(scriptParentParent.Utils.getHasQuestUserAgent)
local GetFFlagEnableLuobuInGameUpsell = require(scriptParentParent.Flags.GetFFlagEnableLuobuInGameUpsell)

return function(arg1)
    local hasAmazonUserAgent = getHasAmazonUserAgent()
    local fFlagEnableLuobuInGameUpsell = GetFFlagEnableLuobuInGameUpsell()
    local hasQuestUserAgent = getHasQuestUserAgent()
    return getPaymentFromPlatform(arg1, fFlagEnableLuobuInGameUpsell, hasAmazonUserAgent, hasQuestUserAgent)
end
