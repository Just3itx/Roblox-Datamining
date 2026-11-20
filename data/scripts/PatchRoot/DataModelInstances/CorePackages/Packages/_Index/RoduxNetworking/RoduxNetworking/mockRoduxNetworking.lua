-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local makeActionCreator = require(script.Parent.makeActionCreator)

local function makeMockRequestObject(arg1)
    local actionCreator = makeActionCreator(arg1)
    local function func1() end
    function actionCreator.API()
        return actionCreator.Succeeded()
    end

    actionCreator.Mock = { reply = func1, clear = func1, replyWithError = func1 }

    return actionCreator
end

return function()
    return {
        GET = makeMockRequestObject,
        POST = makeMockRequestObject,
        PATCH = makeMockRequestObject,
        DELETE = makeMockRequestObject
    }
end
