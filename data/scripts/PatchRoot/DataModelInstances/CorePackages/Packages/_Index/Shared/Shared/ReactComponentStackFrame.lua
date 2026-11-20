-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)

local _ReactElementType = require(script.Parent.ReactElementType)

local _flowtypesRoblox = require(script.Parent["flowtypes.roblox"])

local ReactSymbols = require(script.Parent.ReactSymbols)
local REACT_SUSPENSE_TYPE = ReactSymbols.REACT_SUSPENSE_TYPE
local REACT_SUSPENSE_LIST_TYPE = ReactSymbols.REACT_SUSPENSE_LIST_TYPE
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_BLOCK_TYPE = ReactSymbols.REACT_BLOCK_TYPE
local REACT_LAZY_TYPE = ReactSymbols.REACT_LAZY_TYPE

local ConsolePatchingDevRoblox = require(script.Parent["ConsolePatchingDev.roblox"])
local disableLogs = ConsolePatchingDevRoblox.disableLogs
local reenableLogs = ConsolePatchingDevRoblox.reenableLogs

local ReactCurrentDispatcher = require(script.Parent.ReactSharedInternals).ReactCurrentDispatcher

local describeComponentFrame = nil

local function describeOwner(arg1) -- Luacid: unused: defined but never referenced
    if type(arg1) == "function" then
        return debug.info(arg1, "n")
    elseif type(arg1) == "table" then
        return tostring(arg1)
    end
    return nil
end

local function describeBuiltInComponentFrame(str1: string, arg1, arg2)
    local var1 = if ReactGlobals.__DEV__ and arg2 then if type(arg2) == "function" then debug.info(arg2, "n") elseif type(arg2) == "table" then tostring(arg2) else nil else nil
    return describeComponentFrame(str1, arg1, var1)
end

local bool1 = false
local var1 = if ReactGlobals.__DEV__ then setmetatable({}, { __mode = "k" }) else nil

local function describeNativeComponentFrame(arg1, bool2: boolean)
    if not arg1 or bool1 then
        return ""
    end

    if ReactGlobals.__DEV__ then
        local var2 = var1[arg1]

        if var2 ~= nil then
            return var2
        end
    end

    local var2 = nil
    bool1 = true
    local current

    if ReactGlobals.__DEV__ then
        current = ReactCurrentDispatcher.current

        ReactCurrentDispatcher.current = nil
        disableLogs()
    else
        current = nil
    end

    local var3 = nil
    local _success, result = xpcall(function()
        if bool2 then
            return
        end

        local _success, result = pcall(function()
            var3 = debug.traceback()
            error({ stack = var3 })
        end)

        var2 = result

        arg1()
    end, function(message)
        return { message = message, stack = var3 }
    end)

    local var4 = nil

    if result and var2 and type(result.stack) == "string" then
        local tbl1 = string.split(result.stack, "\n")
        local tbl2 = string.split(var2.stack, "\n")

        local num1 = #tbl1 - 1
        local num2 = #tbl2 - 1

        while num1 >= 2 and num2 >= 0 and tbl1[num1] ~= tbl2[num2] do
            num2 -= 1
        end

        while num1 >= 3 and num2 >= 1 do
            num1 -= 1
            num2 -= 1

            if tbl1[num1] == tbl2[num2] then
                continue
            end

            if num1 == 1 and num2 == 1 then
                break
            end

            repeat
                num1 -= 1
                num2 -= 1

                if num2 < 0 or tbl1[num1] ~= tbl2[num2] then
                    var4 = "\n" .. "    in " .. tbl1[num1]

                    if ReactGlobals.__DEV__ then
                        var1[arg1] = var4
                    end
                end
            until not (num1 >= 3 and num2 >= 1)

            break
        end
    end

    bool1 = false
    if ReactGlobals.__DEV__ then
        ReactCurrentDispatcher.current = current
        reenableLogs()
    end

    if var4 ~= nil then
        return var4
    end

    local var5 = if type(arg1) == "function" then debug.info(arg1, "n") elseif type(arg1) ~= "table" then "" else tostring(arg1)
    local var6

    if var5 == nil or var5 == "" then
        var6 = ""
    else
        local __dev = ReactGlobals.__DEV__
        var6 = describeComponentFrame(var5, nil, nil)
    end

    if ReactGlobals.__DEV__ then
        var1[arg1] = var6
    end

    return var6
end

describeComponentFrame = function(str1: string?, arg1, str2: string?)
    local str3 = ""

    if ReactGlobals.__DEV__ and arg1 then
        local fileName = arg1.fileName
        local var2 = string.gsub(fileName, "^(.*)[\\/]", "")

        if string.match(var2, "^init%.") then
            local var3 = string.match(fileName, "^(.*)[\\/]")

            if var3 and #var3 ~= 0 then
                var2 = string.gsub(var3, "^(.*)[\\/]", "") .. "/" .. var2
            end
        end

        str3 = " (at " .. var2 .. ":" .. arg1.lineNumber .. ")"
    elseif str2 then
        str3 = " (created by " .. str2 .. ")"
    end

    return "\n    in " .. (str1 or "Unknown") .. str3
end

local function describeClassComponentFrame(arg1, arg2, arg3)
    local str1 = tostring(arg1)
    local var2 = if ReactGlobals.__DEV__ and arg3 then if type(arg3) == "function" then debug.info(arg3, "n") elseif type(arg3) == "table" then tostring(arg3) else nil else nil
    return describeComponentFrame(str1, arg2, var2)
end

local function describeFunctionComponentFrame(func1: ((...any) -> (...any))?, arg1, arg2)
    if not func1 then
        return ""
    end

    local var2 = if type(func1) == "function" then debug.info(func1, "n") else tostring(func1)
    local var3 = if ReactGlobals.__DEV__ and arg2 then if type(arg2) == "function" then debug.info(arg2, "n") elseif type(arg2) == "table" then tostring(arg2) else nil else nil
    return describeComponentFrame(var2, arg1, var3)
end

local function describeUnknownElementTypeFrameInDEV(arg1, arg2, arg3)
    if not ReactGlobals.__DEV__ then
        return ""
    end
    if arg1 == nil then
        return ""
    end

    if type(arg1) == "table" and type(arg1.__ctor) == "function" then
        return describeClassComponentFrame(arg1, arg2, arg3)
    end

    if type(arg1) == "function" then
        return describeFunctionComponentFrame(arg1, arg2, arg3)
    end

    if type(arg1) == "string" then
        return describeBuiltInComponentFrame(arg1, arg2, arg3)
    end

    if arg1 == REACT_SUSPENSE_TYPE then
        return describeBuiltInComponentFrame("Suspense", arg2, arg3)
    end

    if arg1 == REACT_SUSPENSE_LIST_TYPE then
        return describeBuiltInComponentFrame("SuspenseList", arg2, arg3)
    end

    if type(arg1) == "table" then
        local typeof = arg1["$$typeof"]
        if typeof == REACT_FORWARD_REF_TYPE then
            return describeFunctionComponentFrame(arg1.render, arg2, arg3)
        end

        if typeof == REACT_MEMO_TYPE then
            return describeUnknownElementTypeFrameInDEV(arg1.type, arg2, arg3)
        end

        if typeof == REACT_BLOCK_TYPE then
            return describeFunctionComponentFrame(arg1._render, arg2, arg3)
        end

        if typeof == REACT_LAZY_TYPE then
            local _payload = arg1._payload
            local _init = arg1._init

            local success, result = pcall(function()
                describeUnknownElementTypeFrameInDEV(_init(_payload), arg2, arg3)
            end)

            if success then
                return result
            end
        end
    end

    return ""
end

return {
    describeComponentFrame = describeComponentFrame,
    describeBuiltInComponentFrame = describeBuiltInComponentFrame,
    describeNativeComponentFrame = describeNativeComponentFrame,
    describeClassComponentFrame = describeClassComponentFrame,
    describeFunctionComponentFrame = describeFunctionComponentFrame,
    describeUnknownElementTypeFrameInDEV = describeUnknownElementTypeFrameInDEV
}
