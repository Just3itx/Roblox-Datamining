-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local makeActionCreator = require(scriptParent.makeActionCreator)
local RequestBuilder = require(scriptParent.RequestBuilder)
local NetworkStatus = require(scriptParent.NetworkStatus)
local Promise = require(scriptParent.Promise)
local _Types = require(scriptParent.Types)

return function(arg1, arg2)
    local keyPath = arg1.keyPath
    local killRequestWithFilteredIds = arg1.killRequestWithFilteredIds

    local var1 = NetworkStatus({ keyPath = keyPath, killRequestWithFilteredIds = killRequestWithFilteredIds })

    return function(arg3, func1: (...any) -> (...any))
        local actionCreator = makeActionCreator(arg3)
        local var2 = nil

        local function func2(arg4, tbl1)
            if tbl1.mockNetworkImpl then
                error("Request already mocked - you may need to call `Mock.clear` between tests/uses")
            end

            if type(arg4) ~= "function" and type(arg4) ~= tbl1.defaultType then
                error(tbl1.argumentName .. " must be a " .. tbl1.defaultType .. " or function")
            end

            var2 = function(...)
                local var3 = type(arg4) == "function" and arg4(...) or arg4

                return Promise[tbl1.defaultResolveMethod](var3)
            end
        end

        return {
            Mock = {
                reply = function(arg4)
                    return func2(
                        arg4,
                        {
                            defaultResolveMethod = "resolve",
                            argumentName = "mockResponse",
                            defaultType = "table",
                            mockNetworkImpl = var2
                        }
                    )
                end,
                replyWithError = function(arg4)
                    return func2(
                        arg4,
                        {
                            defaultResolveMethod = "reject",
                            argumentName = "mockError",
                            defaultType = "string",
                            mockNetworkImpl = var2
                        }
                    )
                end,
                clear = function()
                    var2 = nil
                end
            },
            getStatus = function(arg4, arg5)
                local var3 = func1(function(str1: string, arg6)
                    return RequestBuilder.new(str1, arg6)
                end, arg5):makeKeyMapper()(arg5)

                return var1.getStatus(arg4, var3)
            end,
            API = function(arg4, ...)
                local var3 = func1(function(str1: string, arg5)
                    return RequestBuilder.new(str1, arg5)
                end, arg4, ...)

                return function(tbl1)
                    return var1.setStatus(tbl1, var3:getIds(), var3:makeKeyMapper(), function(arg5, arg6)
                        local var4 = var2 or arg1.networkImpl
                        local var5 = var3:makeOptions()
                        local namedIds = var3:getNamedIds()

                        return var4(var3:makeUrl(arg6), arg2, var5):andThen(function(arg7)
                            arg5:dispatch(actionCreator.Succeeded(arg6, arg7.responseBody, namedIds, var5, var3:getAdditionalData()))
                            return arg7
                        end, function(arg7)
                            arg5:dispatch(actionCreator.Failed(arg6, arg7, namedIds, var5, var3:getAdditionalData()))

                            return Promise.reject(arg7)
                        end)
                    end)
                end
            end,
            Succeeded = actionCreator.Succeeded,
            Failed = actionCreator.Failed
        }
    end
end
