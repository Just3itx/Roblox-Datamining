-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local t = require(CorePackages.Packages.t)
local Constants = require(script.Parent.Parent.Constants)
local maybeAssert = require(script.Parent.maybeAssert)

local function validateMessageText(str1: string)
    maybeAssert(t.string(str1))

    if utf8.len(str1) == nil then
        return false
    end

    local var1 = utf8.len(utf8.nfcnormalize(str1))
    if Constants.MAX_MESSAGE_LENGTH < var1 then
        return false, var1
    end

    return true
end

return validateMessageText
