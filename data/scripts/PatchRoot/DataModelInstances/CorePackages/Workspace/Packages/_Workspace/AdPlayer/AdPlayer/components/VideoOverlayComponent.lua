-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdPlayer = script:FindFirstAncestor("AdPlayer")
local AdPlayerParent = AdPlayer.Parent
local React = require(AdPlayerParent.React)
local AdGuiInteractivity = require(AdPlayerParent.AdGuiInteractivity)
local ReactOtter = require(AdPlayerParent.ReactOtter)
local Foundation = require(AdPlayerParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local Flags = require(AdPlayer.Flags)
local components = script:FindFirstAncestor("components")
local AdLabelComponent = require(components.AdLabelComponent)
local LinearProgressComponent = require(components.LinearProgressComponent)
local AdDropdownMenu = AdGuiInteractivity.AdDropdownMenu

local adDropdownButtonDefault = Flags.GetAdDropdownButtonDefault()
local adDropdownButtonOpen = Flags.GetAdDropdownButtonOpen()
local adPlayerExitButton = Flags.GetAdPlayerExitButton()

local font = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

local function ExitButtonComponent(arg1)
    local var1 = useTokens()

    return React.createElement(View, {
        tag = "size-900 radius-circle",
        backgroundStyle = var1.Color.Common.Scrim,
        onActivated = arg1.showExitConfirmationModal
    }, {
        icon = React.createElement(
            Image,
            {
                tag = "size-600 radius-circle position-center-center anchor-center-center",
                Image = adPlayerExitButton
            }
        )
    })
end

local function TimerComponent(arg1)
    return React.createElement(FoundationText, {
        tag = "size-0-500 auto-x content-emphasis",
        LayoutOrder = 2,
        Text = arg1.alpha:map(function(arg2): string
            local num1 = math.ceil((1 - arg2) * arg1.totalDuration)
            local num2 = num1 // 60
            local num3 = num1 % 60

            return string.format("%02i:%02i", num2, num3)
        end),
        fontStyle = { Font = font, FontSize = 14 }
    })
end

local function ScrimComponent(arg1)
    local var1 = useTokens()

    local groupTransparency, var3 = ReactOtter.useAnimatedBinding(0)
    React.useEffect(function()
        if arg1.showScrim then
            var3(ReactOtter.instant(0))

            return nil
        end

        local bool1 = false
        task.delay(2, function()
            if not bool1 then
                var3(ReactOtter.spring(1))
            end
        end)

        return function()
            bool1 = true
        end
    end, { arg1.showScrim })

    local var4 = table.clone(arg1.children or {})
    var4.scrim = React.createElement(View, { tag = "size-full", backgroundStyle = var1.Color.Common.Scrim, ZIndex = -1 })

    return React.createElement(View, { tag = "size-full", GroupTransparency = groupTransparency, ZIndex = 0 }, var4)
end

local function TopContainer(arg1)
    return React.createElement(
        View,
        {
            tag = "size-full-1500 anchor-top-center position-top-center padding-x-medium padding-y-medium"
        },
        arg1.children
    )
end

local function BottomContainer(arg1)
    return React.createElement(
        View,
        {
            tag = "size-full-700 anchor-bottom-center padding-x-medium",
            Position = UDim2.new(0.5, 0, 1, -24)
        },
        arg1.children
    )
end

local function BottomContainerListContainer(tbl1)
    return React.createElement(View, { tag = "size-full-500 row align-x-left align-y-center gap-medium" }, tbl1.children)
end

return (React.forwardRef(function(tbl1, arg1)
    local var1, var2 = React.useState(false)
    local var3, var4 = React.useState(false)
    local var5 = useTokens()

    local function dismissModals() -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl1.setPaused(false)
        tbl1.dismissModals()
        var2(false)
    end

    local function handleToggleAdsModal()
        dismissModals()

        if not var1 then
            tbl1.setPaused(true)
            var2(true)
        end
    end

    React.useImperativeHandle(arg1, function()
        return { dismissModals = dismissModals }
    end)

    React.useEffect(function()
        if var3 then
            var4(false)
        end
    end, { var3 })

    local createElement = React.createElement
    local var6 = View

    local tbl2 = {
        tag = "size-full",
        onActivated = function()
            dismissModals()
            var4(true)
        end,
        stateLayer = {
            affordance = StateLayerAffordance.None
        }
    }

    local tbl3 = { persistentBottom = 0, scrim = 0 }

    local createElement2 = React.createElement
    local func1 = BottomContainer
    local tbl4 = {}
    local tbl5 = {
        adDropdownMenu = React.createElement(AdDropdownMenu, {
            showDropDownMenu = var1,
            onWhyThisAdActivated = tbl1.showWhyThisAd,
            onReportAdActivated = tbl1.showReportAdModal,
            transparency = 0.2,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromOffset(0, -var5.Padding.Small)
        }),
        leftBottomListContainer = 0
    }
    local createElement3 = React.createElement
    local func2 = BottomContainerListContainer
    local tbl6 = {}
    local tbl7 = {
        adLabel = React.createElement(
            AdLabelComponent,
            {
                Image = if var1 then adDropdownButtonOpen else adDropdownButtonDefault,
                handleToggleAdsModal = handleToggleAdsModal
            }
        )
    }
    tbl5.leftBottomListContainer = createElement3(func2, tbl6, tbl7)
    tbl3.persistentBottom = createElement2(func1, tbl4, tbl5)

    tbl3.scrim = React.createElement(ScrimComponent, {
        showScrim = var1 or tbl1.parentModalOpen or var3
    }, {
        fadingBottom = React.createElement(BottomContainer, {}, {
            progressBar = React.createElement(LinearProgressComponent, {
                alpha = tbl1.alpha,
                Size = UDim2.new(1, 0, 0, 2),
                Position = UDim2.fromScale(0.5, 1),
                AnchorPoint = Vector2.new(0.5, 1)
            }),
            bottomListContainer = React.createElement(BottomContainerListContainer, {}, {
                dummyAdLabel = React.createElement(AdLabelComponent, { Visible = false }),
                timer = React.createElement(TimerComponent, { alpha = tbl1.alpha, totalDuration = tbl1.totalDuration })
            })
        }),
        top = React.createElement(TopContainer, {}, {
            closeButton = React.createElement(ExitButtonComponent, { showExitConfirmationModal = tbl1.showExitConfirmationModal })
        })
    })
    return createElement(var6, tbl2, tbl3)
end))
