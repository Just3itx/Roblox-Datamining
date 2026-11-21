-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local ReactOtter = require(AvatarExperienceControlBarParent.ReactOtter)

local useSemanticTokens = require(AvatarExperienceControlBar.Hooks.useSemanticTokens)

local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)
local IconTextButton = require(AvatarExperienceControlBar.Components.Buttons.IconTextButton)
local ColorTextButton = require(AvatarExperienceControlBar.Components.Buttons.ColorTextButton)

local bool1 = game:DefineFastFlag("AXDisableControlBarMenuAnimation", false)

local tbl1 = { dampingRatio = 1, frequency = 5 }

local function IconTextMenu(tbl2)
    local var1 = useSemanticTokens()

    local var2, var3 = React.useBinding(0)
    local var4, var5 = ReactOtter.useAnimatedBinding(0)
    local bool2 = #tbl2.items > 0

    local ref = React.useRef(nil)

    local offset = tbl2.radius or var1.defaultIconTextMenuRadius

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local absoluteSize = arg1.AbsoluteSize
        var3(absoluteSize.X)
        var5(ReactOtter.spring(if bool2 then absoluteSize.Y else 0, tbl1))
    end, { bool2 })

    local var8 = React.useMemo(function()
        local result = ({})
        for layoutOrder, item in tbl2.items do
            if item.type == "icon" then
                local str1 = `IconTextMenuItem-{item.id}`
                local createElement = React.createElement
                local var8 = IconTextButton
                local tbl3 = {
                    icon = item.icon,
                    text = item.text,
                    iconSize = item.iconSize,
                    disabled = item.disabled,
                    onActivated = 0,
                    Visible = 0,
                    LayoutOrder = 0
                }

                function tbl3.onActivated()
                    if tbl2.onItemActivated then
                        tbl2.onItemActivated(item.id)
                    end
                    if item.onActivated then
                        item.onActivated()
                    end
                end
                tbl3.Visible = item.visible
                tbl3.LayoutOrder = layoutOrder
                result[str1] = createElement(var8, tbl3)
            elseif item.type == "color" then
                local str1 = `IconTextMenuItem-{item.id}`
                local createElement = React.createElement
                local var8 = ColorTextButton
                local tbl3 = {
                    colors = item.colors,
                    colorSize = item.colorSize,
                    size = item.size,
                    text = item.text,
                    disabled = item.disabled,
                    onActivated = 0,
                    Visible = 0,
                    LayoutOrder = 0
                }

                function tbl3.onActivated()
                    if tbl2.onItemActivated then
                        tbl2.onItemActivated(item.id)
                    end
                    if item.onActivated then
                        item.onActivated()
                    end
                end
                tbl3.Visible = item.visible
                tbl3.LayoutOrder = layoutOrder
                result[str1] = createElement(var8, tbl3)
            end
        end

        return result
    end, { tbl2.items, tbl2.onItemActivated })

    return React.createElement(Foundation.View, {
        tag = "clip",
        Name = "IconTextMenu-Animation-Container",
        Size = if bool1 then nil else React.joinBindings({ X = var2, Y = var4 }):map(function(arg1)
            return UDim2.fromOffset(arg1.X, math.round(arg1.Y))
        end),
        AutomaticSize = if bool1 then Enum.AutomaticSize.XY else nil,
        Position = tbl2.Position,
        AnchorPoint = tbl2.AnchorPoint,
        LayoutOrder = tbl2.LayoutOrder
    }, {
        MenuContent = if #tbl2.items > 0 then React.createElement(Foundation.View, {
            tag = "auto-xy clip col clip padding-xsmall gap-xsmall",
            backgroundStyle = var1.menuBackgroundStyle,
            cornerRadius = UDim.new(0, offset),
            ref = ref,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged
        }, var8) else nil
    })
end

return IconTextMenu
