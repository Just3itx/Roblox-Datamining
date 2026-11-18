-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T22:56:49Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local str1 = game:DefineFastString("MrRouterEnvName", "")

local module = {}

function module.generateTraceparent(): string
    local var1 = HttpService:GenerateGUID(false):gsub("-", ""):lower()
    local var2 = HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 16):lower()
    return string.format("00-%s-%s-01", var1, var2)
end

function module.mergeMrRouterInTracestate(tracestate: string?, str2: string): string
    local str3 = "mrrouter-env=" .. str2

    local tbl1 = {}
    if tracestate and #tracestate > 0 then
        for value in tracestate:gmatch(" *([^,]+)") do
            table.insert(tbl1, value)
        end
    end

    local function isMrRouterEntry(str4: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        return str4:sub(1, 13) == "mrrouter-env="
    end

    local var1 = nil
    for i, value in ipairs(tbl1) do
        if isMrRouterEntry(value) then
            var1 = i
            break
        end
    end

    if var1 == nil then
        table.insert(tbl1, str3)
        return table.concat(tbl1, ",")
    end

    local tbl2 = {}
    for _, value in ipairs(tbl1) do
        if not isMrRouterEntry(value) then
            table.insert(tbl2, value)
        end
    end
    table.insert(tbl2, var1, str3)
    return table.concat(tbl2, ",")
end

function module.injectMrRouterHeaders(tbl1)
    if #str1 == 0 then
        return tbl1
    end

    local var1 = not tbl1 and {} or table.clone(tbl1)
    if not var1.Traceparent then
        var1.Traceparent = module.generateTraceparent()
    end
    var1.Tracestate = module.mergeMrRouterInTracestate(var1.Tracestate, str1)
    return var1
end

module["jest.config"] = script["jest.config"]

return module
