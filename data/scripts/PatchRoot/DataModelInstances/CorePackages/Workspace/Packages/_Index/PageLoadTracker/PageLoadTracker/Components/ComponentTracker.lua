-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PageLoadTrackerParent = script:FindFirstAncestor("PageLoadTracker").Parent
local React = require(PageLoadTrackerParent.React)

local useSelector = require(PageLoadTrackerParent.RoactUtils).Hooks.RoactRodux.useSelector
local SharedFlags = require(PageLoadTrackerParent.SharedFlags)

local createPageTracker = require(script.Parent.Parent.createPageTracker)
local PageTrackerContext = require(script.Parent.Parent.PageTrackerContext)
local isElementInScreenBounds = require(script.Parent.Parent.isElementInScreenBounds)
local PageLoadConfig = require(script.Parent.Parent.PageLoadConfig)
local VisualDebugManager = require(script.Parent.Parent.VisualDebugManager)

local ExperienceService = require(PageLoadTrackerParent.ExperienceService).ExperienceService

local function usePageTracker(isActive: boolean, componentName: string)
    local var1 = React.useMemo(function()
        return createPageTracker()
    end, {})

    if isActive then
        var1:start(componentName)
    else
        var1:stop()
    end

    React.useEffect(function()
        var1:sendMilestone("first_react_frame_rendered")

        local var2 = if SharedFlags.FFlagLuaAppPageLoadTrackerJoinExperienceFix then ExperienceService:RegisterForExperienceJoin(function()
            var1:stop()
        end) else nil

        return function()
            var1:stop()
            if SharedFlags.FFlagLuaAppPageLoadTrackerJoinExperienceFix and var2 then
                var2:Disconnect()
            end
        end
    end, {})

    return var1
end

local function ComponentTracker(tbl1)
    local value = usePageTracker(tbl1.isActive, tbl1.componentName)

    local var2 = React.useRef(nil)
    local ref = React.useRef(nil)

    if SharedFlags.FFlagDebugEnablePageLoadTrackerVisualizer and var2.current == nil then
        var2.current = VisualDebugManager.new()
    end

    local var4 = useSelector(function(arg1)
        return arg1.ScreenSize or PageLoadConfig.SCREEN_BOUNDS.DEFAULT_SCREEN_SIZE
    end)

    local var5 = useSelector(function(arg1)
        return arg1.TopBar and arg1.TopBar.topBarHeight or PageLoadConfig.SCREEN_BOUNDS.DEFAULT_TOP_BAR_HEIGHT
    end)

    local function addTrackingToChild(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
        if not arg1:IsA("GuiObject") then
            return
        end

        if not isElementInScreenBounds(arg1, var4, var5) then
            return
        end

        value:onComponentAdded(arg1)
        if SharedFlags.FFlagDebugEnablePageLoadTrackerVisualizer then
            var2.current:highlightComponent(arg1)
        end
    end

    local function setupChildTracking(current)
        for _, descendant in current:GetDescendants() do
            if SharedFlags.FFlagLuaAppImproveComponentTrackingTiming then
                task.defer(function()
                    addTrackingToChild(descendant)
                end)
            else
                addTrackingToChild(descendant)
            end
        end

        return (current.DescendantAdded:Connect(function(descendant: Instance)
            if SharedFlags.FFlagLuaAppImproveComponentTrackingTiming then
                task.defer(function()
                    addTrackingToChild(descendant)
                end)

                return
            end

            addTrackingToChild(descendant)
        end))
    end
    if SharedFlags.FFlagDebugEnablePageLoadTrackerVisualizer then
        React.useEffect(function()
            return function()
                var2.current:destroy()
            end
        end, {})
    end

    React.useLayoutEffect(function()
        if not tbl1.isActive then
            return
        end

        local current = ref.current
        local var6 = setupChildTracking(current)
        if not SharedFlags.FFlagPageLoadAllowImprovedDisconnectTiming then
            return function()
                var6:Disconnect()
            end
        end

        value.onCompleteSignal:connect(function()
            var6:Disconnect()
        end)
    end, { tbl1.isActive })

    return React.createElement(
        "Frame",
        {
            ref = ref,
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1
        },
        {
            PageTrackerContext = React.createElement(PageTrackerContext.Provider, { value = value }, tbl1.children)
        }
    )
end
return ComponentTracker
