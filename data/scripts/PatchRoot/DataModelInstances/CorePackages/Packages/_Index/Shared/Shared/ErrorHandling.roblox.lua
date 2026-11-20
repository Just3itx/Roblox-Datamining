-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local Error = LuauPolyfill.Error
local inspect = LuauPolyfill.util.inspect

local filterInternalStackFrames = require(script.Parent.ReactFeatureFlags).filterInternalStackFrames

local tbl1 = {
    "React",
    "ReactDevtoolsShared",
    "ReactNoopRenderer",
    "ReactReconciler",
    "ReactRefresh",
    "ReactRoblox",
    "RoactCompat",
    "Scheduler",
    "Shared"
}

local var1 = nil

local function getReactPackagePrefixes()
    if _G.ENVIRONMENT == "PRODUCTION" then
        return {}
    end

    if var1 then
        return var1
    end

    local reactPackagePrefixes = {}

    for _, value in tbl1 do
        local var2 = scriptParentParent.Parent:FindFirstChild(value)
        if var2 then
            table.insert(reactPackagePrefixes, (var2:GetFullName():gsub("^game%.", "")))
        end
    end

    var1 = reactPackagePrefixes
    return reactPackagePrefixes
end

local function isInternalFrame(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in (getReactPackagePrefixes()) do
        if string.sub(str1, 1, #value) == value then
            return true
        end
    end

    return false
end

local function buildStackString(num1: number)
    local str1 = ""

    local bool1 = false
    local bool2 = false

    for i = num1 + 1, math.huge do
        local var2, var3, var4 = debug.info(i, "sln")
        if not var2 then
            break
        end

        if var2 == "[C]" then
            continue
        end

        if not bool1 then
            local bool3 = false

            for _, value in (getReactPackagePrefixes()) do
                if string.sub(var2, 1, #value) == value then
                    bool3 = true
                    break
                end
            end

            bool2 = not bool3
            bool1 = true
        end

        if bool2 and isInternalFrame(var2) then
            continue
        end

        str1 ..= `{var2}:{var3} function {var4 or "?"}\n`
    end

    return (string.gsub(str1, "\n$", ""))
end

return {
    describeError = function(arg1)
        if typeof(arg1) ~= "string" then
            return arg1
        end

        local _, var2 = string.find(arg1, ":[%d]+: ")
        if var2 then
            arg1 = string.sub(arg1, var2 + 1)
        end
        local error = LuauPolyfill.Error.new(arg1)
        if filterInternalStackFrames then
            error.stack = buildStackString(2)
        else
            error.stack = debug.traceback(nil, 2)
        end
        return error
    end,
    errorToString = function(arg1)
        if typeof(arg1) ~= "table" then
            return (inspect(arg1))
        end

        if not (arg1.message and arg1.stack) then
            return (inspect(arg1))
        end

        return "\n------ Error caught by React ------\n" .. arg1.message .. "\n------ Error caught by React ------\n" .. tostring(arg1.stack)
    end,
    parseReactError = function(str1: string)
        local tbl2 = string.split(str1, "\n------ Error caught by React ------\n")

        if #tbl2 ~= 3 then
            local error = Error.new(str1)
            error.stack = nil

            return error, ""
        end

        local str2, str3, stack = table.unpack(tbl2)

        local error = Error.new(str3)
        error.stack = stack

        return error, str2
    end,
    __ERROR_DIVIDER = "\n------ Error caught by React ------\n"
}
