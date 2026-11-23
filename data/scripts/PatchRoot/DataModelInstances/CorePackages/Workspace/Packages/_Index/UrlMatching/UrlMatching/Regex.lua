-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function group(arg1, str1: string) -- Luacid: Inlined by compiler; 9 call sites recovered
    local str2 = "("

    if type(arg1) ~= "string" then
        arg1 = table.concat(arg1, "|")
    end

    return str2 .. str1 .. arg1 .. ")"
end

return {
    oneOf = function(arg1)
        return group(arg1, "?:")
    end,
    capture = function(arg1)
        return group(arg1, "")
    end,
    zeroOrOneOf = function(arg1)
        return group(arg1, "?:") .. "?"
    end,
    zeroOrMore = function(arg1)
        return group(arg1, "?:") .. "*"
    end,
    oneOrMore = function(arg1)
        return group(arg1, "?:") .. "+"
    end,
    lookahead = function(arg1)
        return group(arg1, "?=")
    end,
    lookbehind = function(arg1)
        return group(arg1, "?<=")
    end,
    negativeLookahead = function(arg1)
        return group(arg1, "?!")
    end,
    negativeLookbehind = function(arg1)
        return group(arg1, "?<!")
    end,
    matchWhole = function(str1: string): string
        return "^" .. str1 .. "$"
    end,
    regexOr = function(str1: string, str2: string): string
        return str1 .. "|" .. str2
    end,
    set = function(str1: string): string
        return "[" .. str1 .. "]"
    end,
    notSet = function(str1: string): string
        return "[" .. "^" .. str1 .. "]"
    end,
    SLASH = "\\/",
    QUESTION = "\\?",
    DASH = "\\-",
    DOT = "\\.",
    HASH = "\\#",
    COLON = "\\:",
    STRING_START = "^",
    STRING_END = "$",
    NON_WHITESPACE = "\\S",
    WHITESPACE = "\\s",
    ALPHANUMERIC = "\\w"
}
