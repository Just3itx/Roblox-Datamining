-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpClientParent = script:FindFirstAncestor("HttpClient").Parent

local Promise = require(HttpClientParent.Promise)
local Signals = require(HttpClientParent.Signals)

local _types = require(script.Parent.types)

local tbl1 = ({})

local function asPromise(arg1)
    local tbl2 = {}
    return Promise.new(function(callback, callback2, callback3)
        local bool1 = false
        local bool2 = false

        local function cleanupEffect() -- Luacid: Inlined by compiler; 2 call sites recovered
            if bool2 then
                return
            end
            bool2 = true
            local var1 = tbl1[tbl2]
            tbl1[tbl2] = nil
            if var1 ~= nil then
                var1()
            end

            arg1.dispose()
        end

        local function settle(arg2)
            if bool1 then
                return
            end
            bool1 = true
            cleanupEffect()

            if arg2.status == "succeeded" then
                callback(arg2.result)
                return
            end
            callback2({ responseCode = arg2.errorCode, errorMessage = arg2.error, response = arg2.response })
        end

        local var1 = arg1.state(false)
        if var1.status ~= "pending" then
            settle(var1)
            return
        end

        local effect = Signals.createEffect(function(arg2)
            local var2 = arg1.state(arg2)
            if var2.status == "pending" then
                return
            end
            settle(var2)
        end)
        if bool2 then
            effect()
        else
            tbl1[tbl2] = effect
        end

        callback3(function()
            if bool1 then
                return
            end
            bool1 = true
            cleanupEffect()
        end)
    end)
end

return asPromise
