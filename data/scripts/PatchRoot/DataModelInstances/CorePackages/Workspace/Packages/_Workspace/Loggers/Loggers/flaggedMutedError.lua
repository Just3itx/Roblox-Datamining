-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local mutedError = require(script.Parent.mutedError)

game:DefineFastString("SuppressMutedErrorKeys", "")
local function getFStringSuppressMutedErrorKeys(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return game:GetFastString("SuppressMutedErrorKeys")
end

local str1 = ""
local tbl1 = ({})

local function shouldSuppressMutedError(str2: string)
    local fStringSuppressMutedErrorKeys = getFStringSuppressMutedErrorKeys()

    if fStringSuppressMutedErrorKeys ~= str1 then
        str1 = fStringSuppressMutedErrorKeys
        tbl1 = {}
        for _, value in (fStringSuppressMutedErrorKeys:split(",")) do
            tbl1[value] = true
        end
    end

    return tbl1[str2] or false
end

local function flaggedMutedError(str2: string, str3: string, arg1)
    if not shouldSuppressMutedError(str2) then
        mutedError(str3, arg1)
    end
end

return flaggedMutedError
