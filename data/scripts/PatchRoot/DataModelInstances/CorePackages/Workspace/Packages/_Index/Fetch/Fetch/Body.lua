-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local scriptParentParent = script.Parent.Parent

local Promise = require(scriptParentParent.Promise)

local _LuauPolyfill = require(scriptParentParent.LuauPolyfill)

local Body = {}
Body.__index = Body

function Body.new(got: string?)
    local result = {}

    if type(got) == "string" then
        result.body = got
    elseif got == nil then
        result.body = nil
    else
        error(string.format("Expected string or nil as the first argument to Body.new(), but got: %s", type(got)))
    end

    result.bodyUsed = false
    setmetatable(result, Body)
    return result
end

function Body.arrayBuffer(_)
    return Promise.new(function(_, callback)
        callback("arrayBuffer not implemented")
    end)
end

function Body.blob(_)
    return Promise.new(function(_, callback)
        callback("blob not implemented")
    end)
end

function Body.formData(_)
    return Promise.new(function(_, callback)
        callback("formData not implemented")
    end)
end

function Body.json(arg1)
    return Promise.new(function(callback, callback2)
        if arg1._json then
            callback(arg1._json)
            return
        end

        local success, result = pcall(function()
            return HttpService:JSONDecode(arg1.body)
        end)
        if not success then
            callback2("Failed to decode response body as JSON. JSON decoding is only supported for Content-Type = application/json")
            return
        end

        arg1._json = result
        callback(result)
    end)
end

function Body.text(arg1)
    return Promise.new(function(callback, _)
        callback(arg1.body or "")
    end)
end

return { Body = Body }
