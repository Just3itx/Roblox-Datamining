-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)

local RetrievalStatus = require(scriptParentParentParent.App.Loading.Enum.RetrievalStatus)
local LoadingStatePage = require(scriptParentParentParent.App.Container.LoadingStatePage)
local FailedStatePage = require(scriptParentParentParent.App.Container.FailedStatePage)

local var1 = Roact.PureComponent:extend("LoadingStateContainer")

var1.validateProps = t.strictInterface({
    dataStatus = RetrievalStatus.isEnumValue,
    renderOnLoaded = t.callback,
    renderOnFailed = t.optional(t.callback),
    onRetry = t.optional(t.callback),
    renderOnLoading = t.optional(t.callback),
    renderOnEmpty = t.optional(t.callback)
})

function var1.init(arg1)
    local statePages = {}
    statePages[RetrievalStatus.NotStarted] = function()
        if arg1.props.renderOnEmpty then
            return arg1.props.renderOnEmpty()
        elseif arg1.props.renderOnLoading then
            return arg1.props.renderOnLoading()
        end
        return Roact.createElement(LoadingStatePage)
    end

    statePages[RetrievalStatus.Fetching] = function()
        if arg1.props.renderOnLoading then
            return arg1.props.renderOnLoading()
        end
        return Roact.createElement(LoadingStatePage)
    end

    statePages[RetrievalStatus.Failed] = function()
        if arg1.props.renderOnFailed then
            return arg1.props.renderOnFailed()
        end
        return Roact.createElement(FailedStatePage, { onRetry = arg1.props.onRetry })
    end

    statePages[RetrievalStatus.Done] = function()
        return arg1.props.renderOnLoaded()
    end

    arg1.statePages = statePages
end

function var1.render(arg1)
    return arg1.statePages[arg1.props.dataStatus]()
end

return var1
