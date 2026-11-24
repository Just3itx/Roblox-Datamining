-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local Promise = require(InExperienceShopParent.Promise)

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

local function badRequestError(message: string, cause) -- Luacid: Inlined by compiler; 1 call site recovered
    return { kind = "BadRequest", message = message, cause = cause }
end

return {
    networkError = networkError,
    parseError = parseError,
    schemaError = schemaError,
    engineError = engineError,
    badRequestError = badRequestError,
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
    end,
    rejectBadRequest = function(message: string, cause)
        local tbl1 = badRequestError(message, cause)
        return Promise.reject(tbl1)
    end
}
