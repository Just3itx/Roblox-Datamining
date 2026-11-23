-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local CoreGui = game:GetService("CoreGui")
local Dash = require(AvatarExperienceAnalyticsParent.Dash)
local UnifiedEventLogConstants = require(script.Parent.Parent.UnifiedEventLogConstants)

local FFlagAXMISEnableMultiShoppingUnifiedEvents = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXMISEnableMultiShoppingUnifiedEvents
local FFlagCleanupTenFootUiPaddingAndAnalytics = require(AvatarExperienceAnalyticsParent.SharedFlags).FFlagCleanupTenFootUiPaddingAndAnalytics

local module = {}

local function getParentScrollingFrames(arg1, tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    tbl1 = tbl1 or {}

    local scrollingFrame = arg1:FindFirstAncestorWhichIsA("ScrollingFrame")
    if not scrollingFrame then
        return tbl1
    end
    table.insert(tbl1, scrollingFrame)
    return getParentScrollingFrames(scrollingFrame, tbl1)
end

function module.getUnifiedLoggingFieldName(arg1)
    local attributePrefix = UnifiedEventLogConstants.ATTRIBUTE_PREFIX
    return arg1.sub(arg1, string.len(attributePrefix) + 1, string.len(arg1))
end

function module.isUnifiedLoggingAttribute(arg1)
    return Dash.startsWith(arg1, UnifiedEventLogConstants.ATTRIBUTE_PREFIX)
end

function module.formatLookTypeAttribute(arg1): string
    return string.upper("LOOK_TYPE_" .. arg1)
end

if FFlagAXMISEnableMultiShoppingUnifiedEvents then
    function module.getFieldsToSendFromInstanceAttributes(arg1)
        local fieldsToSendFromInstanceAttributes = {}
        if arg1 then
            for value, value2 in arg1 do
                if module.isUnifiedLoggingAttribute(value) then
                    fieldsToSendFromInstanceAttributes[module.getUnifiedLoggingFieldName(value)] = value2
                end
            end
        end

        return fieldsToSendFromInstanceAttributes
    end
end

function module.getElementSizeAndPosition(arg1)
    local absolutePositionX = arg1.AbsolutePosition.X
    local absolutePositionY = arg1.AbsolutePosition.Y
    local parentScrollingFrames = getParentScrollingFrames(arg1, nil)
    if parentScrollingFrames then
        for _, value in parentScrollingFrames do
            absolutePositionX += value.CanvasPosition.X
            absolutePositionY += value.CanvasPosition.Y
        end
    end

    return {
        elementSizeWidth = math.round(arg1.AbsoluteSize.X),
        elementSizeHeight = math.round(arg1.AbsoluteSize.Y),
        elementCoordinatesX = math.round(arg1.AbsolutePosition.X),
        elementCoordinatesY = math.round(arg1.AbsolutePosition.Y),
        elementRelativePositionX = math.round(absolutePositionX),
        elementRelativePositionY = math.round(absolutePositionY)
    }
end

function module.getScreenSize(arg1)
    local var1 = nil
    local screenGui = arg1:FindFirstAncestorOfClass("ScreenGui")
    if screenGui and screenGui:IsA("ScreenGui") then
        var1 = screenGui
    else
        local luaAppScreenGui = CoreGui:FindFirstChild("LuaAppScreenGui")
        local mainAppScreenSurfaceGui = if luaAppScreenGui then luaAppScreenGui:FindFirstChild("MainAppScreen_SurfaceGui") else nil

        if mainAppScreenSurfaceGui and mainAppScreenSurfaceGui:IsA("SurfaceGui") then
            var1 = mainAppScreenSurfaceGui
        elseif not FFlagCleanupTenFootUiPaddingAndAnalytics then
            local tenFootUiSurfaceGuiFolder = CoreGui:FindFirstChild("TenFootUiSurfaceGuiFolder")
            local rootViewSurfaceSurfaceGui = if tenFootUiSurfaceGuiFolder then tenFootUiSurfaceGuiFolder:FindFirstChild("RootViewSurface_SurfaceGui") else nil

            if rootViewSurfaceSurfaceGui and rootViewSurfaceSurfaceGui:IsA("SurfaceGui") then
                var1 = rootViewSurfaceSurfaceGui
            end
        end
    end

    local tbl1 = {
        screenSizeWidth = if var1 and var1.AbsoluteSize then math.round(var1.AbsoluteSize.X) else nil,
        screenSizeHeight = if var1 and var1.AbsoluteSize then math.round(var1.AbsoluteSize.Y) else nil
    }
    return tbl1
end

return module
