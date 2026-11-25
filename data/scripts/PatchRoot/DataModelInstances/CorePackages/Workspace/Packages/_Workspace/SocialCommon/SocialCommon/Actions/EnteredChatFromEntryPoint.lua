-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent

local Rodux = require(SocialCommonParent.Rodux)

local _ChatEntryPointNames = require(SocialCommon.Enums.ChatEntryPointNames)

return Rodux.makeActionCreator(script.Name, function(entryPoint)
    return { entryPoint = entryPoint }
end)
