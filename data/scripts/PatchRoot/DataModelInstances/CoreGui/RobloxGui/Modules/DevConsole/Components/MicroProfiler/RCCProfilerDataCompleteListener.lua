-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local getClientReplicator = require(script.Parent.Parent.Parent.Util.getClientReplicator)

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local Actions = script.Parent.Parent.Parent.Actions
local AppendRecentDumpPath = require(Actions.AppendRecentDumpPath)
local SetRCCProfilerState = require(Actions.SetRCCProfilerState)

local var1 = Roact.Component:extend("RCCProfilerDataCompleteListener")

function var1.didMount(arg1)
    local clientReplicator = getClientReplicator()
    if not clientReplicator then
        return
    end

    arg1.completeSignal = clientReplicator.RCCProfilerDataComplete:Connect(function(success: boolean, message: string)
        if not arg1.props.waitingForRecording then
            return
        end

        if not success then
            warn(message)
            arg1.props.dispatchSetRCCProfilerState(false)
            return
        end
        arg1.props.dispatchSetRCCProfilerState(false, message)
        arg1.props.dispatchAppendRecentDumpPath(message)
    end)
end

function var1.willUnmount(arg1)
    if arg1.completeSignal then
        arg1.completeSignal:Disconnect()
        arg1.completeSignal = nil
    end
end

function var1.render(_)
    return nil
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _) -- name: mapStateToProps
    return {
        waitingForRecording = arg1.MicroProfiler.waitingForRecording
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        dispatchAppendRecentDumpPath = function(str1: string)
            callback(AppendRecentDumpPath(str1))
        end,
        dispatchSetRCCProfilerState = function(arg1, arg2)
            callback(SetRCCProfilerState(arg1, arg2))
        end
    }
end)(var1)
