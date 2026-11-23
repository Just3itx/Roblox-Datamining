-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local HttpService = game:GetService("HttpService")

local app_session = HttpService:GenerateGUID()
local var1 = nil
local num1 = os.clock()
local function getLandingPageTiming() -- Luacid: Inlined by compiler; 1 call site recovered
    local now = os.clock()
    if not var1 then
        return nil
    end

    local duration = now - num1
    return { app_session = app_session, landing_page_session = var1, duration = duration }
end

return {
    landingPageLoadStart = function()
        var1 = HttpService:GenerateGUID()
        num1 = os.clock()
    end,
    landingPageLoadFinish = function()
        local landingPageTiming = getLandingPageTiming()
        var1 = nil
        return landingPageTiming
    end
}
