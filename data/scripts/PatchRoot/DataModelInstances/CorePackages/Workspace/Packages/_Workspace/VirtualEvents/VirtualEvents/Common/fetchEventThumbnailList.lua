-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent
local UrlBuilder = require(VirtualEventsParent.UrlBuilder).UrlBuilder

return function(arg1, id)
    return arg1(UrlBuilder.fromString("apis:virtual-events/v1/virtual-events/{id}")({ id = id }), "GET"):andThen(function(arg3)
        return arg3.responseBody and arg3.responseBody.thumbnails or {}
    end, function()
        return {}
    end)
end
