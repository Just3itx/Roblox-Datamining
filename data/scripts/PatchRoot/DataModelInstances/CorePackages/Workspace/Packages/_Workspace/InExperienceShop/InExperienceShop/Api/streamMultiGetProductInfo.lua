-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local Promise = require(InExperienceShopParent.Promise)
local getProductInfo = require(script.Parent.getProductInfo)
local _multiGetProductInfo = require(script.Parent.multiGetProductInfo)

local function streamMultiGetProductInfo(tbl1, tbl2)
    local num1 = #tbl1
    if num1 == 0 then
        return Promise.resolve({})
    end

    local var1 = table.create(num1)
    local num2 = 0

    return Promise.new(function(callback)
        for i, request in ipairs(tbl1) do
            getProductInfo(request.id, request.infoType):andThen(function(value)
                return { request = request, ok = true, value = value }
            end):catch(function(err)
                return { request = request, ok = false, err = err }
            end):andThen(function(arg1)
                var1[i] = arg1
                tbl2.onResult(arg1)
                num2 += 1
                if num2 == num1 then
                    callback(var1)
                end
            end)
        end
    end)
end

return streamMultiGetProductInfo
