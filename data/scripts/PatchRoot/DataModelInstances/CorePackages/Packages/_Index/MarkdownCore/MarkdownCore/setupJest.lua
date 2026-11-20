-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownCoreParent = script:FindFirstAncestor("MarkdownCore").Parent
local JestGlobals = require(MarkdownCoreParent.Dev.JestGlobals)
local beforeAll = JestGlobals.beforeAll
local expect = JestGlobals.expect
local jest = JestGlobals.jest

local function toWarnWith(_, callback, arg1)
    local bool1 = false
    local str1 = ""
    local var1 = jest.spyOn(jest.globalEnv, "warn").mockImplementation(function(arg2)
        print("WARN", arg2)
        local success, result = pcall(function()
            expect(arg2).toEqual(arg1)
        end)
        if success then
            bool1 = true
            str1 = result
        end
    end)

    local success, result = pcall(callback)
    if not success then
        var1:mockRestore()
        error(result)
    end

    local message = bool1 and function(): string
        return `Expected never to warn with string containing "{arg1}" but got "{str1}"`
    end or function(): string
        return `Expected to warn with string containing "{arg1}" but did not find a match`
    end

    var1:mockRestore()
    return { message = message, pass = bool1 }
end

local function toWarn(_, callback)
    local num1 = 0
    local var1 = jest.spyOn(jest.globalEnv, "warn").mockImplementation(function(arg1)
        print("WARN", arg1)
        num1 += 1
    end)

    local success, result = pcall(callback)
    if not success then
        var1:mockRestore()
        error(result)
    end

    local message = num1 > 0 and function(): string
        return `Expected never to warn but got {num1} warnings`
    end or function(): string
        return "Expected to warn but never did"
    end

    var1:mockRestore()
    return {
        message = message,
        pass = num1 > 0
    }
end

beforeAll(function()
    expect.extend({ toWarnWith = toWarnWith, toWarn = toWarn })
end)
