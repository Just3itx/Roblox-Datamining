-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function func1() end

local DevOnly = script:FindFirstChild("DevOnly")

local bool1 = false
local var1 = nil

local function register()
    if _G.ENVIRONMENT == "PRODUCTION" or DevOnly == nil then
        return func1
    end

    if bool1 then
        return var1 or func1
    end
    bool1 = true

    local tbl1 = { (require(DevOnly.TagAnnotation.TagAnnotationSection)) }

    var1 = function()
        for _, value in tbl1 do
            value()
        end
        bool1 = false
        var1 = nil
    end

    return var1
end

return {
    ["jest.config"] = script["jest.config"],
    dumpInstanceTree = require(script.dumpInstanceTree),
    idFor = require(script.idFor),
    littleTraceback = require(script.littleTraceback),
    logTreeGraphviz = require(script.logTreeGraphviz),
    LogTree = require(script.LogTree),
    register = register
}
