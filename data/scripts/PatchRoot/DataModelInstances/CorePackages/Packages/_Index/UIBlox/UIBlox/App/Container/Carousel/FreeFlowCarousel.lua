-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local FitFrameOnAxis = require(scriptParentParentParentParentParent.FitFrame).FitFrameOnAxis
local isCallable = require(scriptParentParentParentParent.Utility.isCallable)

local CarouselHeader = require(scriptParent.CarouselHeader)
local HorizontalCarousel = require(scriptParent.HorizontalCarousel)

local var1 = Roact.PureComponent:extend("FreeFlowCarousel")

var1.validateProps = t.strictInterface({
    identifier = t.optional(t.callback),
    headerText = t.optional(t.string),
    onSeeAll = t.optional(t.callback),
    itemList = t.array(t.any),
    renderItem = t.callback,
    itemSize = t.optional(t.Vector2),
    itemPadding = t.optional(t.number),
    carouselMargin = t.optional(t.number),
    innerPadding = t.optional(t.number),
    layoutOrder = t.optional(t.integer),
    loadNext = t.optional(t.callback),
    maxNumOfItemsVisible = t.optional(t.integer),
    viewabilityConfigCallbackPairs = t.optional(
        t.array(
            t.strictInterface({
                viewabilityConfig = t.strictInterface({
                    minimumViewTime = t.optional(t.number),
                    viewAreaCoveragePercentThreshold = t.optional(t.number),
                    itemVisiblePercentThreshold = t.optional(t.number),
                    waitForInteraction = t.optional(t.boolean)
                }),
                onViewableItemsChanged = isCallable
            })
        )
    )
})
var1.defaultProps = { headerText = "", innerPadding = 12, itemPadding = 12, carouselMargin = 24 }

function var1.render(arg1)
    local innerPadding = arg1.props.innerPadding
    local carouselMargin = arg1.props.carouselMargin

    return Roact.createElement(FitFrameOnAxis, {
        axis = FitFrameOnAxis.Axis.Vertical,
        minimumSize = UDim2.fromScale(1, 0),
        LayoutOrder = arg1.props.layoutOrder,
        contentPadding = UDim.new(0, innerPadding),
        BackgroundTransparency = 1
    }, {
        CarouselHeader = Roact.createElement(
            CarouselHeader,
            {
                headerText = arg1.props.headerText,
                onSeeAll = arg1.props.onSeeAll,
                carouselMargin = carouselMargin,
                layoutOrder = 1
            }
        ),
        Carousel = Roact.createElement(HorizontalCarousel, {
            identifier = arg1.props.identifier,
            itemList = arg1.props.itemList,
            renderItem = arg1.props.renderItem,
            itemSize = arg1.props.itemSize,
            itemPadding = innerPadding,
            carouselMargin = carouselMargin,
            layoutOrder = 2,
            loadNext = arg1.props.loadNext,
            maxNumOfItemsVisible = arg1.props.maxNumOfItemsVisible,
            viewabilityConfigCallbackPairs = arg1.props.viewabilityConfigCallbackPairs
        })
    })
end

return var1
