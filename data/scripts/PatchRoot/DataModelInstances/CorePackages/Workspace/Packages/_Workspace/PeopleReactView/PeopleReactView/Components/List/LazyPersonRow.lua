-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)

local RobloxAppEnums = require(PeopleReactViewParent.RobloxAppEnums)
local useDeviceOrientation = require(PeopleReactViewParent.RobloxAppHooks).useDeviceOrientation

local Foundation = require(PeopleReactViewParent.Foundation)
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens
local Skeleton = Foundation.Skeleton
local View = Foundation.View

local PeopleService = require(PeopleReactViewParent.PeopleService)
local FFlagPeopleListButtonOverflow = require(PeopleReactView.Flags.FFlagPeopleListButtonOverflow)

local _GetScrollingFrameStore = require(PeopleReactView.Stores.GetScrollingFrameStore)

local PersonRow = require(PeopleReactView.Components.List.PersonRow)
local PeoplePageLayoutContext = require(PeopleReactView.PeoplePageLayoutContext)
local LazyScrollingComponent = require(PeopleReactView.Components.Common.LazyScrollingComponent)

local service = PeopleService.getService("Flags")
local FFlagPeoplePageRemoveSkeletons = service.FFlagPeoplePageRemoveSkeletons
local FFlagPeoplePageRemoveUseMemoElements = service.FFlagPeoplePageRemoveUseMemoElements

local var1 = React.memo(function(tbl1)
    local var1 = useTokens()

    if FFlagPeoplePageRemoveSkeletons then
        return React.createElement(View, {
            tag = {
                ["bg-surface-200 radius-medium"] = true,
                ["size-full-2600"] = tbl1.isPortrait,
                ["size-full-1500"] = not tbl1.isPortrait
            }
        })
    end
    return React.createElement(View, {
        tag = {
            ["row bg-surface-200 gap-medium padding-small radius-medium"] = true,
            ["size-full-2600"] = tbl1.isPortrait,
            ["size-full-1500"] = not tbl1.isPortrait
        }
    }, {
        ThumbnailContainer = React.createElement(
            View,
            { tag = "size-1200", LayoutOrder = 1 },
            {
                ThumbnailSkeleton = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), radius = Radius.Circle })
            }
        ),
        Details = React.createElement(View, {
            tag = "col grow size-0-full gap-medium",
            LayoutOrder = 2
        }, {
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
        })
    })
end)

return React.memo(function(tbl1)
    local var2 = useTokens()

    local bool1 = useDeviceOrientation() == RobloxAppEnums.DeviceOrientationMode.Portrait
    local var3 = React.useContext(PeoplePageLayoutContext)
    local isPortrait = bool1 or FFlagPeopleListButtonOverflow and var3.isCompact

    local personRow = if FFlagPeoplePageRemoveUseMemoElements then React.createElement(PersonRow, { person = tbl1.person, layoutOrder = tbl1.layoutOrder }) else React.useMemo(function()
        return React.createElement(PersonRow, { person = tbl1.person, layoutOrder = tbl1.layoutOrder })
    end, { tbl1.person, tbl1.layoutOrder })

    local placeholder = if FFlagPeoplePageRemoveUseMemoElements then React.createElement(var1, { isPortrait = isPortrait }) else React.useMemo(function()
        if FFlagPeoplePageRemoveSkeletons then
            return React.createElement(View, {
                tag = {
                    ["bg-surface-200 radius-medium"] = true,
                    ["size-full-2600"] = isPortrait,
                    ["size-full-1500"] = not isPortrait
                }
            })
        end
        return React.createElement(View, {
            tag = {
                ["row bg-surface-200 gap-medium padding-small radius-medium"] = true,
                ["size-full-2600"] = isPortrait,
                ["size-full-1500"] = not isPortrait
            }
        }, {
            ThumbnailContainer = React.createElement(
                View,
                { tag = "size-1200", LayoutOrder = 1 },
                {
                    ThumbnailSkeleton = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1), radius = Radius.Circle })
                }
            ),
            Details = React.createElement(View, {
                tag = "col grow size-0-full gap-medium",
                LayoutOrder = 2
            }, {
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
            })
        })
    end, { isPortrait, var2 })

    if not tbl1.scrollingFrameStore then
        return personRow
    end

    return React.createElement(LazyScrollingComponent, {
        scrollingFrameAbsolutePositionY = tbl1.scrollingFrameStore.getAbsolutePositionY,
        scrollingFrameAbsoluteSizeY = tbl1.scrollingFrameStore.getAbsoluteSizeY,
        scrollingFrameCanvasPositionY = tbl1.scrollingFrameStore.getCanvasPositionY,
        placeholder = placeholder,
        placeholderLayoutOrder = tbl1.layoutOrder
    }, { PersonRow = personRow })
end)
