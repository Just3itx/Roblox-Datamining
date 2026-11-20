-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Banner = require(Foundation.Components.Banner)
local _Banner = require(Foundation.Components.Banner.Banner)
local InternalFloatingElement = require(Foundation.Components.InternalFloatingElement)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local BannerSize = require(Foundation.Enums.BannerSize)
local CardDensity = require(Foundation.Enums.CardDensity)
local ElevationLayer = require(Foundation.Enums.ElevationLayer)
local ScreenRegion = require(Foundation.Providers.ScreenRegion.ScreenRegion)
local ScreenRegionKind = require(Foundation.Providers.ScreenRegion.ScreenRegionKind)

local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { testId = "--foundation-floating-banner" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: FloatingBanner
    local var1 = withDefaults(arg1, tbl1)

    local var2, var3 = React.useState(false)
    React.useEffect(function()
        if not var1.isOpen then
            var3(false)
        end
    end, { var1.isOpen })

    local onClose = var1.onClose
    local primary = if var1.actions then var1.actions.primary else nil

    local actions = React.useMemo(function(): {primary: {onActivated: () -> ()}}?
        return if primary == nil then nil else {
            primary = {
                onActivated = function()
                    var3(true)
                    primary.onActivated()
                end
            }
        }
    end, { primary })
    local var4 = React.useMemo(function(): (() -> ())?
        return if onClose == nil then nil else function()
            var3(true)
            onClose()
        end
    end, { onClose })

    return React.createElement(
        InternalFloatingElement,
        withCommonProps(var1, {
            isOpen = var1.isOpen and not var2,
            onCloseComplete = var1.onCloseComplete,
            layer = ElevationLayer.Floating,
            queue = {
                region = ScreenRegion.Bottom,
                kind = ScreenRegionKind.FloatingBanner
            },
            ref = ref
        }),
        {
            Fill = React.createElement(View, {
                LayoutOrder = 1,
                tag = "shadow-overlay-100 size-full-0 auto-y radius-medium bg-surface-200",
                testId = `{var1.testId}--fill`
            }, {
                Banner = React.createElement(Banner, {
                    size = BannerSize.Small,
                    density = CardDensity.Compact,
                    title = var1.title,
                    description = var1.description,
                    thumbnail = var1.thumbnail,
                    actions = actions,
                    onClose = var4,
                    testId = `{var1.testId}--banner`
                })
            })
        }
    )
end))
