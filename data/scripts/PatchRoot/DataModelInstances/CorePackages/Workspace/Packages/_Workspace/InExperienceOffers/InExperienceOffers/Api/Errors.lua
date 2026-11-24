-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffersParent = script:FindFirstAncestor("InExperienceOffers").Parent

local Promise = require(InExperienceOffersParent.Promise)

local function networkError(message: string, cause) -- Luacid: Inlined by compiler; 1 call site recovered
    return { kind = "Network", message = message, cause = cause }
end

local function parseError(message: string, cause) -- Luacid: Inlined by compiler; 1 call site recovered
    return { kind = "Parse", message = message, cause = cause }
end

local function schemaError(message: string, cause) -- Luacid: Inlined by compiler; 1 call site recovered
    return { kind = "Schema", message = message, cause = cause }
end

local function engineError(message: string, cause) -- Luacid: Inlined by compiler; 1 call site recovered
    return { kind = "Engine", message = message, cause = cause }
end

return {
    networkError = networkError,
    parseError = parseError,
    schemaError = schemaError,
    engineError = engineError,
    rejectNetwork = function(message: string, cause)
        local tbl1 = networkError(message, cause)
        return Promise.reject(tbl1)
    end,
    rejectParse = function(message: string, cause)
        local tbl1 = parseError(message, cause)
        return Promise.reject(tbl1)
    end,
    rejectSchema = function(message: string, cause)
        local tbl1 = schemaError(message, cause)
        return Promise.reject(tbl1)
    end,
    rejectEngine = function(message: string, cause)
        local tbl1 = engineError(message, cause)
        return Promise.reject(tbl1)
    end
}
