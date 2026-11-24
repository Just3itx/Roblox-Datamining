-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCallingParent = script:FindFirstAncestor("FriendsCalling").Parent

local _FloatingWindow = require(FriendsCallingParent.FloatingWindow)

local function safeAreaInsets(deviceInsets, margin: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        bottom = math.max(deviceInsets.bottom, margin),
        left = math.max(deviceInsets.left, margin),
        right = math.max(deviceInsets.right, margin),
        top = math.max(deviceInsets.top, margin)
    }
end

local function resolveExpanded(tbl1)
    local deviceInsets = tbl1.deviceInsets

    if not tbl1.isPortrait then
        return {
            boundsInsets = safeAreaInsets(deviceInsets, tbl1.margin),
            hasRoundedCorners = true,
            size = UDim2.new(0, 416, 1, 0),
            topPadding = 0
        }
    end

    if tbl1.exposesTopSafeArea then
        return {
            boundsInsets = {
                bottom = 0,
                left = 0,
                right = 0,
                top = deviceInsets.top
            },
            hasRoundedCorners = true,
            size = UDim2.fromScale(1, 1),
            topPadding = 0
        }
    end

    return {
        boundsInsets = { bottom = 0, left = 0, right = 0, top = 0 },
        hasRoundedCorners = false,
        size = UDim2.fromScale(1, 1),
        topPadding = deviceInsets.top
    }
end

local function resolveGeometry(tbl1)
    return {
        collapsed = {
            boundsInsets = safeAreaInsets(tbl1.deviceInsets, tbl1.margin)
        },
        expanded = resolveExpanded(tbl1)
    }
end

return resolveGeometry
