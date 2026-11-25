-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local Foundation = require(VirtualEvents.Parent.Foundation)
local _GraphQLServer = require(VirtualEvents.Parent.GraphQLServer)
local useScreenSize = require(VirtualEvents.Parent.RobloxAppHooks).useScreenSize

local EventDetailsBody = require(VirtualEvents.Components.EventDetailsBody)
local EventActionBar = require(VirtualEvents.Components.EventActionBar)

local _VirtualEventsState = require(VirtualEvents.Parent.VirtualEventsState)
local constants = require(VirtualEvents.constants)

local useTokens = Foundation.Hooks.useTokens

local function EventDetailsContainer(tbl1)
    local var1 = useTokens()
    local var2 = useScreenSize()
    local experienceDetails = tbl1.virtualEvent.experienceDetails
    local isExpanded, setIsExpanded = React.useState(false)
    local time, var5 = React.useState(0.99)

    local var6 = React.useRef(0)

    local var7 = React.useCallback(function()
        if not (var6.current and tbl1.bottomHeight) then
            return
        end
        if tbl1.bottomHeight > 0 and tbl1.bottomHeight < var6.current then
            var5(1 - tbl1.bottomHeight / var6.current)
        end
    end, { tbl1.bottomHeight })

    local var8 = React.useCallback(function(arg1)
        if var6.current and var6.current ~= arg1.AbsoluteSize.Y then
            var6.current = arg1.AbsoluteSize.Y
            var7()
        end
    end, { var7 })

    React.useEffect(function()
        var7()
    end, { tbl1.bottomHeight, var7 })

    local createElement = React.createElement
    local tbl2 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false
    }

    tbl2[React.Event.TouchTap] = function()
        setIsExpanded(false)
    end
    tbl2[React.Event.Activated] = function()
        setIsExpanded(false)
    end
    local tbl3 = {
        Scrim = React.createElement("Frame", {
            ZIndex = 1,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = if isExpanded then var1.Color.Extended.Black.Black_50.Transparency else 1,
            BackgroundColor3 = var1.Color.Extended.Black.Black_50.Color3,
            BorderSizePixel = 0
        }),
        EventsWithGradientContainer = 0
    }

    local createElement2 = React.createElement
    local tbl4 = {
        ZIndex = 2,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        BackgroundTransparency = var1.Color.Extended.White.White_100.Transparency,
        BackgroundColor3 = var1.Color.Extended.White.White_100.Color3,
        BorderSizePixel = 0,
        [React.Change.AbsoluteSize] = var8
    }
    local tbl5 = {
        Gradient = React.createElement("UIGradient", {
            Rotation = 90,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, var1.Color.Surface.Surface_100.Color3), ColorSequenceKeypoint.new(1, var1.Color.Surface.Surface_100.Color3) }),
            Transparency = NumberSequence.new(
                { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(time, 0), NumberSequenceKeypoint.new(1, 0) }
            )
        }),
        ContentContainer = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            [React.Change.AbsoluteSize] = var8
        }, {
            Padding = React.createElement("UIPadding", {
                PaddingTop = UDim.new(0, 80),
                PaddingLeft = UDim.new(0, 20),
                PaddingRight = UDim.new(0, 20),
                PaddingBottom = UDim.new(0, 20)
            }),
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 16)
            }),
            EventDetailsBody = React.createElement(EventDetailsBody, {
                virtualEvent = tbl1.virtualEvent,
                eventStatus = tbl1.eventStatus,
                containerSize = Vector2.new((tbl1.isWideMode and constants.CONTAINER_WIDTH or var2.X) - 40, var2.Y),
                isExpanded = isExpanded,
                setIsExpanded = setIsExpanded
            }),
            Divider = React.createElement("Frame", {
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = var1.Color.Common.Shimmer.Color3,
                BackgroundTransparency = var1.Color.Common.Shimmer.Transparency,
                BorderSizePixel = 0
            }),
            EventActionBar = React.createElement(EventActionBar, {
                universeId = tbl1.virtualEvent.universeId,
                experienceName = if experienceDetails then experienceDetails.name else "",
                onExperienceTileActivated = tbl1.onExperienceTileActivated,
                ctaProps = tbl1.ctaProps
            })
        })
    }
    tbl3.EventsWithGradientContainer = createElement2("Frame", tbl4, tbl5)
    return createElement("TextButton", tbl2, tbl3)
end

return EventDetailsContainer
