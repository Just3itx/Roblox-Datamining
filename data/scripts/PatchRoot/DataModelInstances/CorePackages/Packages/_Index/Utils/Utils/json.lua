-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
return {
    stringify = function(input, ...): string
        local select = select

        if select("#", ...) > 0 then
            warn("JSON.stringify doesn't currently support more than 1 argument. All additional arguments will be ignored.")
        end

        return HttpService:JSONEncode(input)
    end,
    parse = function(input: string, ...)
        local select = select

        if select("#", ...) > 0 then
            warn("JSON.parse doesn't currently support more than 1 argument. All additional arguments will be ignored.")
        end
        return HttpService:JSONDecode(input)
    end
}
