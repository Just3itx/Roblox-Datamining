-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T09:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function register() end

local function noopRule(_)
    return nil
end

local function noopRuleFactory(...)
    return noopRule
end

local function noopFormatter(_, _, _)
    return nil
end

local function noopPreview(_)
    return nil
end

local function noopPreviewFactory(_)
    return noopPreview
end

return {
    register = function(_) -- name: noopRegister
        return register
    end,
    notify = function(_) -- name: noopNotify
    end,
    Resolvers = {
        fromEventName = noopRuleFactory,
        fromCtx = noopRuleFactory,
        fromField = noopRuleFactory,
        fromEnum = noopRuleFactory,
        eventNameAsLabel = noopRuleFactory,
        fixed = noopRuleFactory,
        walk = function(_, _)
            return nil
        end
    },
    Formatters = {
        enumLabel = function(_) -- name: noopFormatterFactory
            return noopFormatter
        end,
        invertEnum = function(_)
            return {}
        end
    },
    Previews = {
        rbxthumb = noopPreviewFactory,
        fromInstance = noopPreviewFactory,
        chain = noopPreviewFactory,
        isPlausibleId = function(_): boolean
            return false
        end
    }
}
