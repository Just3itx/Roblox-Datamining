-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local ReactIs = require(PeopleReactViewParent.ReactIs)
local Signals = require(PeopleReactViewParent.Signals)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local Foundation = require(PeopleReactViewParent.Foundation)
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens
local Skeleton = Foundation.Skeleton
local View = Foundation.View

local PeopleService = require(PeopleReactViewParent.PeopleService)

local _GetScrollingFrameStore = require(PeopleReactView.Stores.GetScrollingFrameStore)

local PersonCard = require(PeopleReactView.Components.Card.PersonCard)
local LazyScrollingComponent = require(PeopleReactView.Components.Common.LazyScrollingComponent)

local service = PeopleService.getService("Flags")
local GetFFlagPeoplePageEnablePersonSignalStore = service.GetFFlagPeoplePageEnablePersonSignalStore
local FFlagPeoplePageRemoveSkeletons = service.FFlagPeoplePageRemoveSkeletons
local FFlagPeoplePageRemoveUseMemoElements = service.FFlagPeoplePageRemoveUseMemoElements

local var1 = React.memo(function(tbl1)
    local var1 = useTokens()

    if FFlagPeoplePageRemoveSkeletons then
        return React.createElement(View, { tag = "bg-surface-100 radius-medium", Size = tbl1.size })
    end

    return React.createElement(View, {
        tag = "col bg-surface-100 radius-medium",
        Size = tbl1.size
    }, {
        ThumbnailContainer = React.createElement(
            View,
            { tag = "size-full aspect-1-1 padding-small", LayoutOrder = 1 },
            {
                ThumbnailSkeleton = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), radius = Radius.Small })
            }
        ),
        Details = React.createElement(
            View,
            {
                tag = "size-full-1400 col align-y-center gap-xsmall padding-x-small",
                LayoutOrder = 2
            },
            {
                NameSkeleton = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.new(0.9, 0, 0, var1.Size.Size_350),
                        radius = Radius.Small,
                        LayoutOrder = 1
                    }
                ),
                HandleSkeleton = React.createElement(
                    Skeleton,
                    {
                        Size = UDim2.new(0.6, 0, 0, var1.Size.Size_350),
                        radius = Radius.Small,
                        LayoutOrder = 2
                    }
                )
            }
        )
    })
end)

return React.memo(function(tbl1)
    local var2 = useTokens()

    local var3 = if GetFFlagPeoplePageEnablePersonSignalStore() then SignalsReact.useSignalBinding(Signals.createComputed(function(arg1)
        if type(tbl1.layoutOrder) == "function" then
            return tbl1.layoutOrder(arg1)
        end
        return tbl1.layoutOrder or 0
    end)) else nil

    local size = if ReactIs.isBinding(tbl1.width) then tbl1.width:map(function(xOffset: number): UDim2
        return UDim2.new(0, xOffset, 0, xOffset + var2.Size.Size_1400)
    end) else UDim2.new(0, tbl1.width, 0, tbl1.width + var2.Size.Size_1400)

    local element

    if FFlagPeoplePageRemoveUseMemoElements then
        element = React.createElement(PersonCard, {
            width = tbl1.width,
            person = tbl1.person,
            showTooltip = tbl1.showTooltip,
            onDismissTooltip = tbl1.onDismissTooltip,
            shouldShowMenu = tbl1.shouldShowMenu,
            layoutOrder = tbl1.layoutOrder,
            isCompactCardLayout = tbl1.isCompactCardLayout
        })
    else
        element = React.useMemo(function()
            return React.createElement(PersonCard, {
                width = tbl1.width,
                person = tbl1.person,
                showTooltip = tbl1.showTooltip,
                onDismissTooltip = tbl1.onDismissTooltip,
                shouldShowMenu = tbl1.shouldShowMenu,
                layoutOrder = tbl1.layoutOrder,
                isCompactCardLayout = tbl1.isCompactCardLayout
            })
        end, {
            tbl1.width,
            tbl1.person,
            tbl1.showTooltip,
            tbl1.onDismissTooltip,
            tbl1.shouldShowMenu,
            tbl1.layoutOrder,
            tbl1.isCompactCardLayout
        })
    end

    local placeholder = if FFlagPeoplePageRemoveUseMemoElements then React.createElement(var1, { size = size }) else React.useMemo(function()
        if FFlagPeoplePageRemoveSkeletons then
            return React.createElement(View, { tag = "bg-surface-100 radius-medium", Size = size })
        end

        return React.createElement(View, { tag = "col bg-surface-100 radius-medium", Size = size }, {
            ThumbnailContainer = React.createElement(
                View,
                { tag = "size-full aspect-1-1 padding-small", LayoutOrder = 1 },
                {
                    ThumbnailSkeleton = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), radius = Radius.Small })
                }
            ),
            Details = React.createElement(
                View,
                {
                    tag = "size-full-1400 col align-y-center gap-xsmall padding-x-small",
                    LayoutOrder = 2
                },
                {
                    NameSkeleton = React.createElement(
                        Skeleton,
                        {
                            Size = UDim2.new(0.9, 0, 0, var2.Size.Size_350),
                            radius = Radius.Small,
                            LayoutOrder = 1
                        }
                    ),
                    HandleSkeleton = React.createElement(
                        Skeleton,
                        {
                            Size = UDim2.new(0.6, 0, 0, var2.Size.Size_350),
                            radius = Radius.Small,
                            LayoutOrder = 2
                        }
                    )
                }
            )
        })
    end, { size, var2 })

    if not tbl1.scrollingFrameStore then
        return element
    end

    local createElement = React.createElement
    local var6 = LazyScrollingComponent
    local tbl2 = {
        scrollingFrameAbsolutePositionY = tbl1.scrollingFrameStore.getAbsolutePositionY,
        scrollingFrameAbsoluteSizeY = tbl1.scrollingFrameStore.getAbsoluteSizeY,
        scrollingFrameCanvasPositionY = tbl1.scrollingFrameStore.getCanvasPositionY,
        placeholder = placeholder,
        placeholderLayoutOrder = 0
    }

    if not GetFFlagPeoplePageEnablePersonSignalStore() then
        var3 = tbl1.layoutOrder
    end

    tbl2.placeholderLayoutOrder = var3
    return createElement(var6, tbl2, { PersonCard = element })
end)
