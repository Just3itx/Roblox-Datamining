-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsellParent = script:FindFirstAncestor("AmpUpsell").Parent

local default = require(AmpUpsellParent.LoggingProtocol).default

local bool1 = game:DefineFastFlag("EnableAmpUpsellLogging", false)

local module = {}

function module.logEventOnceIfEnabled(str1: string)
    if bool1 then
        default:logEventOnce(str1)
    end
end

return module
