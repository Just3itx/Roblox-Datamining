-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Boolean = LuauPolyfill.Boolean
local Object = LuauPolyfill.Object

local tbl1 = {}

local React = require(scriptParentParentParent.React)

local VirtualizedSectionList = require(script.Parent.VirtualizedSectionList)

local _ScrollView = require(scriptParentParent.Components.ScrollView.ScrollView)

local default = React.PureComponent:extend("SectionList")

function default.init(arg1, props)
    arg1.props = props
    function arg1._captureRef(_wrapperListRef)
        arg1._wrapperListRef = _wrapperListRef
    end
end

function default.scrollToLocation(arg1, arg2)
    if arg1._wrapperListRef ~= nil then
        arg1._wrapperListRef:scrollToLocation(arg2)
    end
end

function default.recordInteraction(arg1)
    local var2 = if arg1._wrapperListRef then arg1._wrapperListRef:getListRef() else arg1._wrapperListRef

    if var2 then
        var2:recordInteraction()
    end
end

function default.flashScrollIndicators(arg1)
    local var2 = if arg1._wrapperListRef then arg1._wrapperListRef:getListRef() else arg1._wrapperListRef

    if var2 then
        var2:flashScrollIndicators()
    end
end

function default.getScrollResponder(arg1)
    local var2 = if arg1._wrapperListRef then arg1._wrapperListRef:getListRef() else arg1._wrapperListRef

    if Boolean.toJSBoolean(var2) then
        return var2:getScrollResponder()
    end
    return nil
end

function default.getScrollableNode(arg1)
    local var2 = if arg1._wrapperListRefthen then arg1._wrapperListRef:getListRef() else arg1._wrapperListRef

    if Boolean.toJSBoolean(var2) then
        return var2:getScrollableNode()
    end
    return nil
end

function default.setNativeProps(arg1, arg2)
    local var2 = if arg1._wrapperListRef then arg1._wrapperListRef:getListRef() else arg1._wrapperListRef

    if Boolean.toJSBoolean(var2) then
        var2:setNativeProps(arg2)
    end
end

function default.render(arg1)
    local stickySectionHeadersEnabled = arg1.props.stickySectionHeadersEnabled
    local var2 = Object.assign({}, arg1.props, { stickySectionHeadersEnabled = Object.None })
    if stickySectionHeadersEnabled == nil then
        stickySectionHeadersEnabled = false
    end

    return React.createElement(
        VirtualizedSectionList,
        Object.assign({}, var2, {
            stickySectionHeadersEnabled = stickySectionHeadersEnabled,
            ref = arg1._captureRef,
            getItemCount = function(arg2): number
                return #arg2
            end,
            getItem = function(arg2, arg3)
                return arg2[arg3]
            end
        })
    )
end
tbl1.default = default
return tbl1
