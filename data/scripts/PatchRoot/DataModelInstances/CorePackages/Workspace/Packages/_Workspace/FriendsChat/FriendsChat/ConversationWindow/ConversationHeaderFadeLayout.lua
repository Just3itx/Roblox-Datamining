-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

return {
    getHeaderOverlapPadding = function(arg1)
        return arg1:map(function(num1: number): UDim
            return UDim.new(0, -num1)
        end)
    end,
    getHeaderVisibleHeight = function(height, fade)
        if type(fade) == "number" then
            local num1 = 1 - math.clamp(fade, 0, 1)
            return height:map(function(num2: number): number
                return num2 * num1
            end)
        elseif fade ~= nil then
            return React.joinBindings({ height = height, fade = fade }):map(function(tbl1)
                return tbl1.height * (1 - math.clamp(tbl1.fade, 0, 1))
            end)
        else
            return height
        end
    end,
    getContentTopPadding = function(height, visibleHeight, canvasY)
        return React.joinBindings({ height = height, visibleHeight = visibleHeight, canvasY = canvasY }):map(function(tbl1)
            local num1 = math.max(tbl1.height - tbl1.canvasY, 0)
            local num2 = math.min(tbl1.height - tbl1.visibleHeight, num1)
            return tbl1.height - num2
        end)
    end,
    getHeaderInteractable = function(arg1)
        if type(arg1) == "number" then
            return arg1 < 1
        elseif arg1 ~= nil then
            return arg1:map(function(num1: number): boolean
                return num1 < 1
            end)
        end
        return true
    end
}
