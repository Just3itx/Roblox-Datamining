-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local LuauPolyfill = require(scriptParentParent.LuauPolyfill)
local Error = LuauPolyfill.Error
local inspect = LuauPolyfill.util.inspect
local getComponentName = require(script.Parent.getComponentName)

local __DEV__ = ReactGlobals.__DEV__
local var1 = require(scriptParentParent.SafeFlags).createGetFFlag("ReactInstanceMapDisableErrorChecking")()

local module = {}

local function isValidFiber(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return not (arg1.tag == nil or arg1.subtreeFlags == nil or arg1.lanes == nil) and arg1.childLanes ~= nil
end

function module.remove(arg1)
    arg1._reactInternals = nil
end

if not var1 or __DEV__ then
    function module.get(arg1)
        local _reactInternals = arg1._reactInternals

        if not isValidFiber(_reactInternals) then
            error(
                Error.new(
                    "invalid fiber in " .. (getComponentName(arg1) or "UNNAMED Component") .. " during get from ReactInstanceMap! " .. inspect(_reactInternals)
                )
            )
            return _reactInternals
        end

        if _reactInternals.alternate ~= nil and not isValidFiber(_reactInternals.alternate) then
            error(
                Error.new(
                    "invalid alternate fiber (" .. (getComponentName(arg1) or "UNNAMED alternate") .. ") in " .. (getComponentName(arg1) or "UNNAMED Component") .. " during get from ReactInstanceMap! " .. inspect(_reactInternals.alternate)
                )
            )
        end
        return _reactInternals
    end
else
    function module.get(arg1)
        return arg1._reactInternals
    end
end

function module.has(arg1): boolean
    return arg1._reactInternals ~= nil
end

if var1 and not __DEV__ then
    function module.set(arg1, _reactInternals)
        arg1._reactInternals = _reactInternals
    end

    return module
end

function module.set(arg1, arg2)
    local _reactInternals = arg2

    while arg2 ~= nil do
        if not isValidFiber(arg2) then
            local var3 = "invalid fiber in " .. (getComponentName(arg1) or "UNNAMED Component") .. " being set in ReactInstanceMap! " .. inspect(arg2) .. "\n"

            if _reactInternals ~= arg2 then
                var3 ..= " (from original fiber " .. (getComponentName(arg1) or "UNNAMED Component") .. ")"
            end
            error(Error.new(var3))
        elseif arg2.alternate ~= nil and not isValidFiber(arg2.alternate) then
            local var3 = "invalid alternate fiber (" .. (getComponentName(arg1) or "UNNAMED alternate") .. ") in " .. (getComponentName(arg1) or "UNNAMED Component") .. " being set in ReactInstanceMap! " .. inspect(arg2.alternate) .. "\n"

            if _reactInternals ~= arg2 then
                var3 ..= " (from original fiber " .. (getComponentName(arg1) or "UNNAMED Component") .. ")"
            end
            error(Error.new(var3))
        end
        arg2 = arg2.return_
    end
    arg1._reactInternals = _reactInternals
end

return module
