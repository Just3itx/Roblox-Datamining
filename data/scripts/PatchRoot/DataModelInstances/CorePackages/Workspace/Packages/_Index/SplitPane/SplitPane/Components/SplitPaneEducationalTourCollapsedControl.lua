-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local Foundation = require(SplitPaneParent.Foundation)

local View = Foundation.View
local Divider = Foundation.Divider
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local EnumsOrientation = Foundation.Enums.Orientation
local useTokens = Foundation.Hooks.useTokens

local isSplitPaneEducationalTourGuiObjectVisible = require(script.Parent.isSplitPaneEducationalTourGuiObjectVisible)
local useTrackedRect = require(script.Parent.useTrackedRect)
local getSplitPaneEducationalTourStore = require(script.Parent.Parent.Stores.getSplitPaneEducationalTourStore)

local function isVisibleAndLaidOut(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not isSplitPaneEducationalTourGuiObjectVisible(arg1) then
        return false
    end
    local parent = arg1.Parent
    local isGuiObject

    if parent == nil then
        isGuiObject = false
    else
        isGuiObject = parent:IsA("GuiObject")

        if isGuiObject then
            if parent.AbsoluteSize.X > 0 then
                isGuiObject = parent.AbsoluteSize.Y > 0
            else
                isGuiObject = false
            end
        end
    end

    return isGuiObject
end

local function SplitPaneEducationalTourCollapsedControl()
    local var1, ref = React.useState(nil)
    local var3 = useTrackedRect(var1)
    local splitPaneEducationalTourStore = getSplitPaneEducationalTourStore(false)

    React.useLayoutEffect(function()
        if var1 == nil then
            return
        end

        return function()
            if splitPaneEducationalTourStore.getCollapsedExpandButtonInstance(false) == var1 then
                splitPaneEducationalTourStore.setCollapsedExpandButtonRect(nil)
                splitPaneEducationalTourStore.setCollapsedExpandButtonInstance(nil)
            end
        end
    end, { var1, splitPaneEducationalTourStore })

    React.useLayoutEffect(function()
        if var1 == nil then
            return
        end

        if not isVisibleAndLaidOut(var1) or var3 == nil then
            if splitPaneEducationalTourStore.getCollapsedExpandButtonInstance(false) == var1 then
                splitPaneEducationalTourStore.setCollapsedExpandButtonRect(nil)
            end
        else
            splitPaneEducationalTourStore.setCollapsedExpandButtonInstance(var1)
            splitPaneEducationalTourStore.setCollapsedExpandButtonRect(var3)
        end
    end, { var1, var3, splitPaneEducationalTourStore })

    local var4 = useTokens()
    local actionUtility = var4.Color.ActionUtility

    return React.createElement(View, {
        tag = "row align-y-center size-0-full auto-x padding-left-xsmall"
    }, {
        DividerContainer = React.createElement(
            View,
            { tag = "size-0-600 auto-x", LayoutOrder = 1 },
            {
                Divider = React.createElement(Divider, { orientation = EnumsOrientation.Vertical })
            }
        ),
        ButtonSlot = React.createElement(View, {
            tag = "size-1000-1000 padding-left-xsmall",
            LayoutOrder = 2
        }, {
            Button = React.createElement(View, {
                ref = ref,
                tag = "row align-x-center align-y-center",
                Size = UDim2.fromOffset(var4.Size.Size_1000, var4.Size.Size_1000),
                padding = UDim.new(0, var4.Size.Size_250),
                cornerRadius = UDim.new(0, var4.Radius.Medium),
                backgroundStyle = actionUtility.Background,
                stroke = actionUtility.Border ~= nil
                    and {
                        Color = actionUtility.Border.Color3,
                        Transparency = actionUtility.Border.Transparency
                    }
                    or nil,
                testId = "split-pane-educational-tour--expand"
            }, {
                Icon = React.createElement(Icon, {
                    name = IconName.RectangleRightPaneChevronLeft,
                    size = var4.Size.Size_600,
                    style = actionUtility.Foreground,
                    LayoutOrder = 1
                })
            })
        })
    })
end

return SplitPaneEducationalTourCollapsedControl
