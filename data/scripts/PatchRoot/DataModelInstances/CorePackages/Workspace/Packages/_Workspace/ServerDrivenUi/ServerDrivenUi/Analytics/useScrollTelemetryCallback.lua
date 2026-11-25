-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local React = require(ServerDrivenUiParent.React)
local _UnifiedLogging = require(ServerDrivenUiParent.UnifiedLogging)
local GetDisplayStore = require(ServerDrivenUiParent.Display).GetDisplayStore

local feedScroll = require(ServerDrivenUiParent.ScrollTelemetry).feedScroll

local SduiErrors = require(ServerDrivenUiParent.SduiCoreSystem).SduiErrors

local function useScrollTelemetryCallback(tbl1, tbl2, arg1)
    return (React.useCallback(function(distance: number, scrollDuration: number, startPos: number)
        if not tbl1 or tbl1.current == nil or not tbl2.current then
            return
        end

        local current = tbl2.current
        local scrollingDirection = tbl1.current.ScrollingDirection
        local num1 = 0
        if scrollingDirection == Enum.ScrollingDirection.X then
            num1 = tbl1.current.AbsoluteSize.X
        elseif scrollingDirection == Enum.ScrollingDirection.Y then
            num1 = tbl1.current.AbsoluteSize.Y
        else
            arg1.dependencies.logger.reportError(SduiErrors.SduiErrorType.InvalidScrollDirection, {
                name = `{current.collectionId}`,
                message = `Direction {scrollingDirection.Name} is an unsupported option for feedScroll event`
            }, arg1.appPage)
        end

        local var1 = GetDisplayStore(false).getViewportSize(false)

        local tbl3 = {
            distance = distance,
            screenSizeX = var1.X,
            screenSizeY = var1.Y,
            scrollAreaSize = num1,
            scrollDepth = if num1 > 0 then distance / num1 else nil,
            startDepth = if num1 > 0 then startPos / num1 else nil,
            startPos = startPos,
            scrollDuration = scrollDuration,
            sortPos = current.collectionPosition,
            gameSetTypeId = tostring(current.collectionId),
            gameSetTargetId = nil
        }

        feedScroll(arg1.dependencies.eventIngest, arg1.appPage, scrollingDirection, tbl3)
    end, { arg1, tbl2, tbl1 }))
end

return useScrollTelemetryCallback
