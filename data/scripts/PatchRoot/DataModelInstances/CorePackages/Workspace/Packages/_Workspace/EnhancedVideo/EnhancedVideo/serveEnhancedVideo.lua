-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Url = require(scriptParentParent.Http).Url

return function(arg1, num1: number)
    return arg1(`{Url.APIS_URL}enhanced-video-experience-service/v1/serve-enhanced-video?universeId={num1}`, "GET")
end
