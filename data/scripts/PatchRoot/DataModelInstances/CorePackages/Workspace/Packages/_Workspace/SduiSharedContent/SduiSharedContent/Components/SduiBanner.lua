-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local Banner = Foundation.Banner

local function getThumbnail(tbl1)
    if tbl1.thumbnailComponent then
        return {
            type = "Slot",
            children = tbl1.thumbnailComponent
        }
    end

    if tbl1.thumbnailIcon then
        return {
            type = "Icon",
            icon = tbl1.thumbnailIcon
        }
    end

    if tbl1.thumbnailImage then
        return {
            type = "Image",
            image = tbl1.thumbnailImage
        }
    end

    if not tbl1.thumbnailUserId then
        return nil
    end

    return {
        type = "Avatar",
        userId = tbl1.thumbnailUserId,
        userPresence = tbl1.thumbnailUserPresence
    }
end

local function withOnClose(arg1, onClose: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if onClose then
        arg1.onClose = onClose
    end
    return arg1
end

return React.memo(function(tbl1) -- name: SduiBanner
    if tbl1.size == "Small" then
        local createElement = React.createElement
        local var1 = Banner
        local tbl2 = {
            size = "Small",
            density = tbl1.density,
            title = tbl1.title,
            description = tbl1.description,
            thumbnail = getThumbnail(tbl1),
            actions = tbl1.primaryAction and {
                primary = {
                    onActivated = tbl1.primaryAction
                }
            } or nil,
            LayoutOrder = tbl1.layoutOrder,
            AnchorPoint = tbl1.anchorPoint,
            Position = tbl1.position,
            Visible = tbl1.visible,
            ZIndex = tbl1.zIndex,
            testId = tbl1.testId
        }
        withOnClose(tbl2, tbl1.onClose)
        return createElement(var1, tbl2)
    end

    local media = tbl1.media
    if tbl1.media then
        media = tbl1.mediaWidth and {
            image = tbl1.media,
            width = tbl1.mediaWidth
        } or media
    end

    local createElement = React.createElement
    local var1 = Banner
    local tbl2 = {
        size = tbl1.size,
        density = tbl1.density,
        title = tbl1.title,
        description = tbl1.description,
        media = media,
        actions = 0,
        LayoutOrder = 0,
        AnchorPoint = 0,
        Position = 0,
        Visible = 0,
        ZIndex = 0,
        testId = 0
    }
    local tbl3

    if tbl1.primaryAction or tbl1.secondaryActionText and tbl1.secondaryAction then
        tbl3 = {
            primary = tbl1.primaryAction and {
                onActivated = tbl1.primaryAction
            } or nil,
            secondary = if tbl1.secondaryActionText then tbl1.secondaryAction and {
                text = tbl1.secondaryActionText,
                onActivated = tbl1.secondaryAction
            } or nil else nil
        }
    else
        tbl3 = nil
    end

    tbl2.actions = tbl3

    tbl2.LayoutOrder = tbl1.layoutOrder
    tbl2.AnchorPoint = tbl1.anchorPoint
    tbl2.Position = tbl1.position
    tbl2.Visible = tbl1.visible
    tbl2.ZIndex = tbl1.zIndex
    tbl2.testId = tbl1.testId
    withOnClose(tbl2, tbl1.onClose)
    return createElement(var1, tbl2)
end)
