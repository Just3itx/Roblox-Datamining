-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceLoadingScriptParent = script:FindFirstAncestor("ExperienceLoadingScript").Parent

local Rodux = require(ExperienceLoadingScriptParent.Rodux)
local ArgCheck = require(ExperienceLoadingScriptParent.ArgCheck)

return Rodux.makeActionCreator(script.Name, function(productInfo)
    ArgCheck.isType(productInfo, "table", "SetGameProductInfo action expects productInfo to be a table")
    return { productInfo = productInfo }
end)
