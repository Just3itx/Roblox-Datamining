-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ReactGlobals = require(scriptParentParent.ReactGlobals)
local Error = require(scriptParentParent.LuauPolyfill).Error

local console = require(script.Parent.console)

local tbl1 = {}

local describeUnknownElementTypeFrameInDEV = require(script.Parent.ReactComponentStackFrame).describeUnknownElementTypeFrameInDEV

local ReactSharedInternals = require(script.Parent.ReactSharedInternals)

local describeError = require(script.Parent["ErrorHandling.roblox"]).describeError

local ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame

local function setCurrentlyValidatingElement(bool1: boolean) -- Luacid: Inlined by compiler; 4 call sites recovered
    if not ReactGlobals.__DEV__ then
        return
    end

    if bool1 then
        local _owner = bool1._owner
        local var1 = describeUnknownElementTypeFrameInDEV(bool1.type, bool1._source, if _owner == nil then nil else _owner.type)

        ReactDebugCurrentFrame.setExtraStackFrame(var1)
        return
    end
    ReactDebugCurrentFrame.setExtraStackFrame(nil)
end

local function checkPropTypes(arg1, func1: ((...any) -> (...any))?, arg2, str1: string, str2: string?, arg3)
    if not ReactGlobals.__DEV__ and not ReactGlobals.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        return
    end

    if arg1 and func1 then
        console.warn("You've defined both propTypes and validateProps on " .. (str2 or "a component"))
    end

    if func1 then
        if typeof(func1) ~= "function" then
            console.error(
                ("validateProps must be a function, but it is a %s.\nCheck the definition of the component %q."):format(
                    typeof(func1),
                    str2 or ""
                )
            )
        else
            local var1, var2 = func1(arg2)

            if not var1 then
                local str3 = string.format(
                    "validateProps failed on a %s type in %s: %s",
                    str1,
                    str2 or "<UNKNOWN Component>",
                    tostring(var2 or "<Validator function did not supply a message>")
                )

                error(str3)
            end
        end
    end

    if not arg1 then
        return
    end
    assert(typeof(arg1) == "table", "propTypes needs to be a table")
    for value, _ in arg1 do
        local _success, result = xpcall(function()
            if typeof(arg1[value]) ~= "function" then
                local error2 = Error.new(
                    (str2 or "React class")
                        .. ": "
                            .. str1
                                .. " type `"
                                    .. value .. "` is invalid; " .. "it must be a function, usually from the `prop-types` package, but received `" .. typeof(arg1[value]) .. "`.This often happens because of typos such as `PropTypes.function` instead of `PropTypes.func`."
                )
                error2.name = "Invariant Violation"
                error(error2)
            end

            return arg1[value](arg2, value, str2, str1, nil, "SECRET_DO_NOT_PASS_THIS_OR_YOU_WILL_BE_FIRED")
        end, describeError)

        local bool1 = typeof(result) == "table"
        if result ~= nil and not bool1 then
            setCurrentlyValidatingElement(arg3)
            console.error(
                string.format(
                    "%s: type specification of %s `%s` is invalid; the type checker function must return `nil` or an `Error` but returned a %s. You may have forgotten to pass an argument to the type checker creator (arrayOf, instanceOf, objectOf, oneOf, oneOfType, and shape all require an argument).",
                    str2 or "React class",
                    str1,
                    value,
                    typeof(result)
                )
            )
            setCurrentlyValidatingElement(false)
        end

        if not bool1 or tbl1[result.message] ~= nil then
            continue
        end

        local tbl2 = tbl1
        local message = result.message
        tbl2[tostring(message)] = true
        setCurrentlyValidatingElement(arg3)
        local warn = console.warn
        local format = string.format

        local message2 = result.message
        warn(format("Failed %s type: %s", str1, tostring(message2)))
        setCurrentlyValidatingElement(false)
    end
end

return checkPropTypes
