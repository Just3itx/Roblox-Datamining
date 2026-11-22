-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local API_URL = require(scriptParentParent.API_URL)
local _networkingShareLinkTypes = require(scriptParentParent.networkingShareLinkTypes)
local tutils = require(scriptParentParentParent.tutils)

local HttpService = game:GetService("HttpService")

return function(arg1)
    local var1 = arg1.roduxNetworking.POST("get-or-create-link", function(arg2, arg3)
        local input = tutils.deepCopy(arg3)
        input.linkType = nil

        local var1 = arg2(API_URL):path("sharelinks"):path("v1"):path("get-or-create-link")
        local tbl1 = {
            linkType = arg3.linkType,
            data = if next(input) == nil then nil else HttpService:JSONEncode(input)
        }
        return var1:body(tbl1)
    end)

    if arg1.useMockedResponse then
        var1.Mock.clear()
        var1.Mock.reply(function()
            return {
                responseBody = { linkId = "42685" }
            }
        end)
    end
    return var1
end
