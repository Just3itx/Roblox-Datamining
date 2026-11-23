-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local React = require(VideoUtilsParent.React)
local useViewportBounds = require(VideoUtilsParent.ViewportUtils).useViewportBounds

local _ViewportVideoAutoplayController = require(VideoUtils.ViewportVideoAutoplayController)
local VideoEndReason = require(VideoUtils.Analytics.Enums).VideoEndReason

local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local num1 = game:DefineFastInt("LuaAppVideoAutoplayWinnerLineOffsetFromTopBarPx", 240)

local function ViewportVideoAutoplaySync(tbl1)
    local var1 = useViewportBounds(tbl1.scrollingFrameRef)

    React.useEffect(function()
        local viewportAutoplayController = tbl1.viewportAutoplayController
        if not viewportAutoplayController then
            return
        end

        viewportAutoplayController:setWinnerLineOffsetFromTopBarPx(num1)

        viewportAutoplayController:setFeedScopeRef(tbl1.scrollingFrameRef)
        viewportAutoplayController:setViewPortBounds(var1)
    end, { tbl1.viewportAutoplayController, tbl1.scrollingFrameRef, var1 })

    React.useEffect(function()
        local viewportAutoplayController = tbl1.viewportAutoplayController
        if not viewportAutoplayController then
            return
        end

        return function()
            viewportAutoplayController:setFeedScopeRef({ current = nil })
            if FFlagLuaAppOneByTwoHoverIdleAutoplay then
                viewportAutoplayController:clearUserIntentCandidate()
            end

            viewportAutoplayController:reset(VideoEndReason.Unmounted)
        end
    end, { tbl1.viewportAutoplayController })

    return nil
end

return ViewportVideoAutoplaySync
