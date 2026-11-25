-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEventsParent = script:FindFirstAncestor("VirtualEvents").Parent
local UrlBuilder = require(VirtualEventsParent.UrlBuilder).UrlBuilder

return function(arg1, id, str1: string?)
    return arg1(UrlBuilder.fromString("apis:virtual-events/v1/virtual-events/{id}")({ id = id }), "GET"):andThen(function(arg3)
        local mediaId = arg3.responseBody
            and arg3.responseBody.thumbnails
            and arg3.responseBody.thumbnails[1]
            and arg3.responseBody.thumbnails[1].mediaId
            or nil

        return if mediaId then "rbxassetid://" .. mediaId else str1
    end, function()
        return str1
    end)
end
